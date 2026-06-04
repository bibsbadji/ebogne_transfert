import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:ebogne_transfert/src/core/providers/auth_providers.dart';
import 'package:ebogne_transfert/src/ui/routes/route_path.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authProvider = context.watch<AuthProviders>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Accueil'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              authProvider.logout();

              Navigator.pushNamedAndRemoveUntil(
                context,
                login,
                (route) => false,
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.account_circle,
                size: 100,
              ),

              const SizedBox(height: 20),

              const Text(
                'Bienvenue sur Ebogne Transfert',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 10),

              Text(
                authProvider.isLoggedIn
                    ? 'Utilisateur connecté'
                    : 'Utilisateur non connecté',
                style: TextStyle(
                  fontSize: 16,
                  color: authProvider.isLoggedIn
                      ? Colors.green
                      : Colors.red,
                ),
              ),

              const SizedBox(height: 30),

              ElevatedButton.icon(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Bienvenue !'),
                    ),
                  );
                },
                icon: const Icon(Icons.send),
                label: const Text('Nouvelle transaction'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}