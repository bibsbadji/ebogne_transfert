import 'package:flutter/material.dart';
import '../../core/controller/transfert_controller.dart';

class SendMoneyScreen extends StatefulWidget {
  const SendMoneyScreen({super.key});

  @override
  State<SendMoneyScreen> createState() => _SendMoneyScreenState();
}

class _SendMoneyScreenState extends State<SendMoneyScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();

  @override
  void dispose() {
    _phoneController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  void _onConfirmTransfer(TransfertController controller) async {
    // 1. Validation du formulaire (Validation des champs - Phase 9)
    if (_formKey.currentState!.validate()) {
      double montant = double.parse(_amountController.text);

      // 2. Appel de la logique via le contrôleur
      final result = await controller.initierTransfert(
        telephoneDestinataire: _phoneController.text,
        montant: montant,
      );

      // 3. Feedback utilisateur (Phase 1.3)
      if (result == "SUCCESS") {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Transfert réussi !"),
            backgroundColor: Colors.green,
          ),
        );
        // Retour automatique au Dashboard ou Historique
        Navigator.pushReplacementNamed(context, '/dashboard');
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(result),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    // Écoute du contrôleur pour obtenir le solde actuel
    final transferController = context.watch<TransfertController>();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Envoyer de l'argent"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Affichage du solde actuel pour guider l'utilisateur
              _buildBalancePreview(transferController.soldeDisponible),
              const SizedBox(height: 30),

              // Champ Destinataire
              const Text("Destinataire", style: TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(height: 10),
              TextFormField(
                controller: _phoneController,
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                  hintText: "77 000 00 00",
                  prefixIcon: const Icon(Icons.person_add_alt_1),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                ),
                validator: (value) => value!.isEmpty ? "Numéro requis" : null,
              ),

              const SizedBox(height: 25),

              // Champ Montant
              const Text("Montant (FCFA)", style: TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(height: 10),
              TextFormField(
                controller: _amountController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: "Ex: 2500",
                  prefixIcon: const Icon(Icons.account_balance_wallet_outlined),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) return "Saisissez un montant";
                  final m = double.tryParse(value);
                  if (m == null) return "Montant invalide";
                  if (m <= 0) return "Le montant doit être > 0"; // Sécurité Phase 9
                  if (m > transferController.soldeDisponible) return "Solde insuffisant";
                  return null;
                },
              ),

              const SizedBox(height: 40),

              // Bouton d'envoi
              SizedBox(
                width: double.infinity,
                height: 55,
                child: ElevatedButton(
                  onPressed: transferController.isProcessing
                      ? null
                      : () => _onConfirmTransfer(transferController),
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  child: transferController.isProcessing
                      ? const CircularProgressIndicator(color: Colors.white)
                      : const Text("Envoyer maintenant", style: TextStyle(fontSize: 16)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBalancePreview(double solde) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.blue[50],
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.blue[100]!),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text("Votre solde disponible :", style: TextStyle(color: Colors.blue)),
          Text(
            "$solde FCFA",
            style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.blue),
          ),
        ],
      ),
    );
  }
}

extension on BuildContext {
  watch<T>() => read<T>();
  
  read<T>() {}  
}

