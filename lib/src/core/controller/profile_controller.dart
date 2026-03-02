import 'package:flutter/material.dart';

class ProfileController extends ChangeNotifier {
  // Données de l'utilisateur (Entité UTILISATEUR)
  String _nom = "Ebogne";
  String _prenom = "Junior";
  String _telephone = "770000000";
  String _photoUrl = "assets/images/default_avatar.png";

  // Getters pour l'UI
  String get nom => _nom;
  String get prenom => _prenom;
  String get telephone => _telephone;
  String get photoUrl => _photoUrl;

  bool _isEditing = false;
  bool get isEditing => _isEditing;

  // LOGIQUE : Basculer le mode édition
  void toggleEdit() {
    _isEditing = !_isEditing;
    notifyListeners();
  }

  // LOGIQUE MÉTIER : Mise à jour des infos (Controller Only)
  Future<String> mettreAJourProfil({
    required String nouveauNom,
    required String nouveauPrenom,
  }) async {
    if (nouveauNom.isEmpty || nouveauPrenom.isEmpty) {
      return "Les champs ne peuvent pas être vides.";
    }

    // Simulation de sauvegarde
    _nom = nouveauNom;
    _prenom = nouveauPrenom;
    _isEditing = false;

    notifyListeners();
    return "SUCCESS";
  }
}
