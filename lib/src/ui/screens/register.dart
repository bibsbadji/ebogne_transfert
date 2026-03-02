import 'package:ebogne_transfert/src/ui/routes/route_path.dart' as AppRouter;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/controller/login_controller.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  // 1. Contrôleurs pour les champs du MCD
  final _formKey = GlobalKey<FormState>();
  final _nomController = TextEditingController();
  final _prenomController = TextEditingController();
  final _phoneController = TextEditingController();
  final _pinController = TextEditingController();

  @override
  void dispose() {
    _nomController.dispose();
    _prenomController.dispose();
    _phoneController.dispose();
    _pinController.dispose();
    super.dispose();
  }

  void _handleRegister(LoginController authController) async {
    if (_formKey.currentState!.validate()) {
      // 2. Appel de la méthode register du contrôleur
      final result = await authController.register(
        nom: _nomController.text,
        prenom: _prenomController.text,
        phone: _phoneController.text,
        pin: _pinController.text,
      );

      if (result == "SUCCESS") {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content: Text("Compte créé avec succès ! Connectez-vous.")),
        );
        // Retour au login après inscription (Phase 6)
        Navigator.pushReplacementNamed(context, AppRouter.login);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(result), backgroundColor: Colors.red),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final authController = Provider.of<LoginController>(context);

    return Scaffold(
      appBar: AppBar(title: const Text("Créer un compte")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              const Text("Informations Personnelles",
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue)),
              const SizedBox(height: 20),

              // Champ Nom (Entité UTILISATEUR)
              TextFormField(
                controller: _nomController,
                decoration: const InputDecoration(
                    labelText: "Nom", border: OutlineInputBorder()),
                validator: (v) => v!.isEmpty ? "Champ obligatoire" : null,
              ),
              const SizedBox(height: 15),

              // Champ Prénom (Entité UTILISATEUR)
              TextFormField(
                controller: _prenomController,
                decoration: const InputDecoration(
                    labelText: "Prénom", border: OutlineInputBorder()),
                validator: (v) => v!.isEmpty ? "Champ obligatoire" : null,
              ),
              const SizedBox(height: 15),

              // Champ Téléphone
              TextFormField(
                controller: _phoneController,
                keyboardType: TextInputType.phone,
                decoration: const InputDecoration(
                    labelText: "Numéro de téléphone",
                    border: OutlineInputBorder()),
                validator: (v) => v!.length < 9 ? "Numéro invalide" : null,
              ),
              const SizedBox(height: 15),

              // Champ PIN (Sécurité Phase 9)
              TextFormField(
                controller: _pinController,
                obscureText: true,
                keyboardType: TextInputType.number,
                maxLength: 4,
                decoration: const InputDecoration(
                    labelText: "Code PIN (4 chiffres)",
                    border: OutlineInputBorder()),
                validator: (v) =>
                    v!.length != 4 ? "Le PIN doit avoir 4 chiffres" : null,
              ),

              const SizedBox(height: 30),

              // Bouton d'inscription
              SizedBox(
                width: double.infinity,
                height: 55,
                child: ElevatedButton(
                  onPressed: authController.isLoading
                      ? null
                      : () => _handleRegister(authController),
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      foregroundColor: Colors.white),
                  child: authController.isLoading
                      ? const CircularProgressIndicator(color: Colors.white)
                      : const Text("S'inscrire",
                          style: TextStyle(fontSize: 16)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
