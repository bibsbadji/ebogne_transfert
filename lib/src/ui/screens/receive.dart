import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/controller/login_controller.dart';

class ReceiveMoneyScreen extends StatelessWidget {
  const ReceiveMoneyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Récupération des infos de l'utilisateur connecté (Phase 7)
    final authController = Provider.of<LoginController>(context);
    final String userPhone = authController.currentUserPhone ?? "77 000 00 00";

    return Scaffold(
      appBar: AppBar(
        title: const Text("Recevoir de l'argent"),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            children: [
              const SizedBox(height: 20),
              const Text(
                "Faites scanner ce code pour recevoir un transfert instantané",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
              const SizedBox(height: 40),

              // --- ZONE QR CODE (PHASE 1.3 : DESIGN) ---
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      spreadRadius: 5,
                      blurRadius: 10,
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    // Simulation d'un QR Code (Remplacez par un widget QR plus tard)
                    const Icon(Icons.qr_code_2,
                        size: 200, color: Colors.black87),
                    const SizedBox(height: 10),
                    Text(
                      userPhone,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.2,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 40),

              // --- OPTIONS DE PARTAGE ---
              const Divider(),
              const SizedBox(height: 20),

              ListTile(
                leading: const CircleAvatar(
                  backgroundColor: Colors.blueAccent,
                  child: Icon(Icons.copy, color: Colors.white),
                ),
                title: const Text("Copier mon numéro"),
                subtitle: Text(userPhone),
                onTap: () {
                  // Logique de copie vers le presse-papier
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Numéro copié !")),
                  );
                },
              ),

              ListTile(
                leading: const CircleAvatar(
                  backgroundColor: Colors.green,
                  child: Icon(Icons.share, color: Colors.white),
                ),
                title: const Text("Partager mon lien de paiement"),
                onTap: () {
                  // Logique de partage (Phase 6)
                },
              ),

              const SizedBox(height: 30),

              // Petit rappel de sécurité (Phase 9)
              const Card(
                color: Color(0xFFFFF3E0),
                child: Padding(
                  padding: EdgeInsets.all(12.0),
                  child: Row(
                    children: [
                      Icon(Icons.info_outline, color: Colors.orange),
                      SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          "Ne partagez jamais votre code PIN, même pour recevoir de l'argent.",
                          style: TextStyle(fontSize: 12, color: Colors.orange),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
