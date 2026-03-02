import 'package:flutter/material.dart';

class LoginController extends ChangeNotifier {
  // État de l'utilisateur (Entité UTILISATEUR du MCD)
  bool _isLoggedIn = false;
  bool get isLoggedIn => _isLoggedIn;

  String? _currentUserPhone;
  String? get currentUserPhone => _currentUserPhone;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  // --- ACTIONS ---

  /// Fonction de Connexion (Phase 6)
  Future<String> login(String phone, String pin) async {
    _isLoading = true;
    notifyListeners();

    // Simulation d'un délai de vérification (ex: vérification base SQLite)
    await Future.delayed(const Duration(seconds: 2));

    // SÉCURITÉ MINIMALE (Phase 9) : Vérification des identifiants
    // Dans un cas réel, on compare avec les données du MPD (SQLite)
    if (phone == "770000000" && pin == "1234") {
      _isLoggedIn = true;
      _currentUserPhone = phone;
      _isLoading = false;
      notifyListeners();
      return "SUCCESS";
    } else {
      _isLoading = false;
      notifyListeners();
      return "Téléphone ou code PIN incorrect.";
    }
  }

  /// Fonction d'Inscription (Phase 6)
  Future<String> register({
    required String nom,
    required String prenom,
    required String phone,
    required String pin,
  }) async {
    _isLoading = true;
    notifyListeners();

    // Simulation d'inscription et génération OTP (Phase 1.1)
    await Future.delayed(const Duration(seconds: 2));

    // Ici on ajouterait l'utilisateur dans la table UTILISATEUR du MPD
    _isLoading = false;
    notifyListeners();
    return "SUCCESS"; // Rediriger vers l'écran OTP
  }

  /// Fonction de Déconnexion (Phase 6)
  void logout() {
    _isLoggedIn = false;
    _currentUserPhone = null;
    notifyListeners();
  }
  
}