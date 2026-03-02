import 'dart:async';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Redirection automatique après 3 secondes vers l'Onboarding
    Timer(const Duration(seconds: 3), () {
      Navigator.pushReplacementNamed(context, '/onboarding');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueAccent, // Votre couleur primaire [cite: 41]
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Utilisation de l'icône seule pour l'app icon [cite: 37]
            Image.asset('assets/images/image.png', height: 120),
            const SizedBox(height: 20),
            const CircularProgressIndicator(color: Colors.white),
            Title(
              color: Colors.white,
              child: const Text("Ebogne Transfert",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
            )
          ],
        ),
      ),
    );
  }
}
