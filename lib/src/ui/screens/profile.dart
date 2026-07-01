import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final _formKey = GlobalKey<FormState>();

  // Contrôleurs pour la modification (Exigence : Modifier informations)
  late TextEditingController _nomController;
  late TextEditingController _emailController;
  late TextEditingController _phoneController;

  @override
  void initState() {
    super.initState();
    // Simulation de récupération de données depuis le Provider ou la DB
    _nomController = TextEditingController(text: "Mariama Ndiaye");
    _emailController = TextEditingController(text: "mariama.ndiaye@yopmail.com");
    _phoneController = TextEditingController(text: "771234567");
  }

  void _saveProfile() {
    if (_formKey.currentState!.validate()) {
      // Logique pour mettre à jour dans SQLite/Provider
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Profil mis à jour avec succès")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Mon Profil"),
        actions: [
          IconButton(
            icon: Icon(Icons.check),
            onPressed: _saveProfile,
          )
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              // Avatar (Aspect UI High Fidelity)
              CircleAvatar(
                radius: 50,
                backgroundColor: Colors.blue.shade100,
                child: Icon(Icons.person, size: 50, color: Colors.blue),
              ),
              SizedBox(height: 30),

              // Champ Nom Complet (Entité UTILISATEUR)
              TextFormField(
                controller: _nomController,
                decoration: InputDecoration(
                  labelText: "Nom Complet",
                  prefixIcon: Icon(Icons.person_outline),
                  border: OutlineInputBorder(),
                ),
                validator: (value) =>
                    value!.isEmpty ? "Champ obligatoire" : null,
              ),
              SizedBox(height: 20),

              // Champ Email
              TextFormField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  labelText: "Email",
                  prefixIcon: Icon(Icons.email_outlined),
                  border: OutlineInputBorder(),
                ),
                validator: (value) =>
                    !value!.contains("@") ? "Email invalide" : null,
              ),
              SizedBox(height: 20),

              // Champ Téléphone (Clé de l'application)
              TextFormField(
                controller: _phoneController,
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                  labelText: "Téléphone",
                  prefixIcon: Icon(Icons.phone_android),
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 30),

              // Bouton de Déconnexion (Exigence 6)
              OutlinedButton.icon(
                onPressed: () {
                  // Logique de déconnexion : retour au Login
                  Navigator.pushReplacementNamed(context, '/login');
                },
                icon: Icon(Icons.logout, color: Colors.red),
                label:
                    Text("Se déconnecter", style: TextStyle(color: Colors.red)),
                style: OutlinedButton.styleFrom(
                    side: BorderSide(color: Colors.red)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
