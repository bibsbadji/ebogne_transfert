import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/controller/login_controller.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _pinController = TextEditingController();
  bool _isPinVisible = false;

  @override
  void dispose() {
    _phoneController.dispose();
    _pinController.dispose();
    super.dispose();
  }

  // Logique de connexion liée au contrôleur
  void _submitLogin(LoginController authController) async {
    if (_formKey.currentState!.validate()) {
      final result = await authController.login(
        _phoneController.text,
        _pinController.text,
      );

      if (result == "SUCCESS") {
        // Navigation vers le tableau de bord (Phase 6)
        Navigator.pushReplacementNamed(context, '/dashboard');
      } else {
        // Feedback en cas d'erreur (Couleur d'état Erreur - Phase 1.3)
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(result),
            backgroundColor: Colors.red,
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    // Écoute du contrôleur d'authentification
    final authController = context.read<LoginController>();

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 40.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Image.asset('assets/images/image.png', height: 120),
                const SizedBox(height: 20),
                const CircularProgressIndicator(color: Colors.white),
                const Text(
                  "Ebogne Transfert !",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                ),
                const Text(
                  "Ton argent ton rythme. Transfert sans stress.",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.grey),
                ),
                const SizedBox(height: 40),

                // Champ Téléphone (Attribut de l'entité UTILISATEUR)
                TextFormField(
                  controller: _phoneController,
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                    labelText: "Numéro de téléphone",
                    prefixIcon: const Icon(Icons.phone_android),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) return "Numéro requis";
                    if (value.length < 9) return "Numéro invalide";
                    return null;
                  },
                ),
                const SizedBox(height: 20),

                // Champ PIN (Sécurité minimale - Phase 9)
                TextFormField(
                  controller: _pinController,
                  obscureText: !_isPinVisible,
                  keyboardType: TextInputType.number,
                  maxLength: 4,
                  decoration: InputDecoration(
                    labelText: "Code PIN",
                    counterText: "", // Masque le compteur de caractères
                    prefixIcon: const Icon(Icons.lock_outline),
                    suffixIcon: IconButton(
                      icon: Icon(_isPinVisible
                          ? Icons.visibility
                          : Icons.visibility_off),
                      onPressed: () =>
                          setState(() => _isPinVisible = !_isPinVisible),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  validator: (value) => (value?.length != 4)
                      ? "Le PIN doit avoir 4 chiffres"
                      : null,
                ),

                const SizedBox(height: 10),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {}, // Option mot de passe oublié
                    child: const Text("Code PIN oublié ?"),
                  ),
                ),
                const SizedBox(height: 30),

                // Bouton de Connexion (Phase 1.3 & 6)
                SizedBox(
                  height: 55,
                  child: ElevatedButton(
                    onPressed: authController.isLoading
                        ? null
                        : () => _submitLogin(authController),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blueAccent,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: authController.isLoading
                        ? const CircularProgressIndicator(color: Colors.white)
                        : const Text("Se connecter",
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold)),
                  ),
                ),

                const SizedBox(height: 20),

                // Lien Inscription (Navigation Phase 6)
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Pas encore de compte ?"),
                    TextButton(
                      onPressed: () =>
                          Navigator.pushNamed(context, '/register'),
                      child: const Text("S'inscrire",
                          style: TextStyle(fontWeight: FontWeight.bold)),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
