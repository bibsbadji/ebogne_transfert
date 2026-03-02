import 'package:flutter/material.dart';
import '../../core/controller/profile_controller.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});
  
  get Provider => null;

  @override
  Widget build(BuildContext context) {
    // On écoute le contrôleur
    final controller = Provider.of<ProfileController>(context);
    
    final TextEditingController nomEdit = TextEditingController(text: controller.nom);
    final TextEditingController prenomEdit = TextEditingController(text: controller.prenom);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Mon Profil"),
        actions: [
          IconButton(
            icon: Icon(controller.isEditing ? Icons.save : Icons.edit),
            onPressed: () async {
              if (controller.isEditing) {
                // Le contrôleur décide si la mise à jour est valide
                final res = await controller.mettreAJourProfil(
                  nouveauNom: nomEdit.text, 
                  nouveauPrenom: prenomEdit.text
                );
                if (res != "SUCCESS") {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(res)));
                }
              } else {
                controller.toggleEdit();
              }
            },
          )
        ],
      ),
      body: Column(
        children: [
          const SizedBox(height: 20),
          CircleAvatar(radius: 50, backgroundImage: AssetImage(controller.photoUrl)),
          const SizedBox(height: 20),
          
          // Affichage conditionnel géré par le contrôleur
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: controller.isEditing 
              ? Column(
                  children: [
                    TextField(controller: nomEdit, decoration: const InputDecoration(labelText: "Nom")),
                    TextField(controller: prenomEdit, decoration: const InputDecoration(labelText: "Prénom")),
                  ],
                )
              : ListTile(
                  title: Text("${controller.prenom} ${controller.nom}"),
                  subtitle: Text(controller.telephone),
                  leading: const Icon(Icons.person),
                ),
          ),
        ],
      ),
    );
  }
}