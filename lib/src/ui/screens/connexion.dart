import 'package:ebogne_transfert/src/ui/routes/route_path.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/controller/login_controller.dart';

class ConnexionScreen extends StatefulWidget {
  final VoidCallback onSuccess;
  const ConnexionScreen({super.key, required this.onSuccess});

  @override
  State<ConnexionScreen> createState() => _ConnexionScreenState();
}

class _ConnexionScreenState extends State<ConnexionScreen> {
  String _pin = "";

  void _onKeyTap(String value) {
    if (_pin.length < 4) {
      setState(() => _pin += value);
    }

    // Une fois les 4 chiffres saisis, on vérifie
    if (_pin.length == 4) {
      _verifyPin();
    }
  }

  void _verifyPin() {
    final auth = Provider.of<LoginController>(context, listen: false);

    // Logique : On compare avec le PIN stocké dans le contrôleur (Phase 9)
    // Ici, on simule une vérification (ex: 1234)
    if (_pin == "1234") {
      widget.onSuccess();
      Navigator.pushReplacementNamed(
          context, dashboard); // Ferme l'écran PIN et navigue vers le dashboard
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text("Code PIN incorrect"), backgroundColor: Colors.red),
      );
      setState(() => _pin = ""); // Réinitialise en cas d'erreur
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Validation Sécurisée")),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.lock_outline, size: 60, color: Colors.blue),
          const SizedBox(height: 20),
          const Text("Entrez votre code PIN pour confirmer",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
          const SizedBox(height: 30),

          // Affichage des points (Indicateur de saisie)
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
                4,
                (index) => Container(
                      margin: const EdgeInsets.all(8),
                      width: 20,
                      height: 20,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: index < _pin.length
                            ? Colors.blue
                            : Colors.grey[300],
                      ),
                    )),
          ),

          const SizedBox(height: 50),

          // Clavier numérique (Grid)
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3, childAspectRatio: 1.5),
              itemCount: 12,
              itemBuilder: (context, index) {
                if (index == 9) return const SizedBox(); // Vide
                if (index == 10) return _buildKey("0");
                if (index == 11) {
                  return IconButton(
                      icon: const Icon(Icons.backspace),
                      onPressed: () => setState(() => _pin = _pin.isNotEmpty
                          ? _pin.substring(0, _pin.length - 1)
                          : ""));
                }

                return _buildKey("${index + 1}");
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildKey(String text) {
    return TextButton(
      onPressed: () => _onKeyTap(text),
      child: Text(text,
          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
    );
  }
}
