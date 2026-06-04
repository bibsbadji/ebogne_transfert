import 'package:ebogne_transfert/src/core/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:ebogne_transfert/src/core/models/user.dart';

class AuthProviders extends ChangeNotifier {
  final AuthService _authService;
  bool _isLoggedIn = false;
  bool _isLoading = false;
  String? _errorMessage;

  String? token;
  User? user;

  bool get isLoggedIn => _isLoggedIn;
  bool get isLoading => _isLoading;
  String? get getErrorMessage => _errorMessage;

  AuthProviders({AuthService? authService})
    : _authService = authService ?? AuthService();

  get errorMessage => null;

  Future<void> login(String email, String password) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      if (email.isEmpty || password.isEmpty) {
        throw 'Email and password cannot be empty';
      }

      final response = await _authService.login(email, password);
      print(response);

      _isLoggedIn = true;
      _isLoading = false;
    } catch (error) {
      _errorMessage = error.toString();
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> register(
    String name,
    String email,
    String password,
    String phone,
    String code,
  ) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      if (email.isEmpty || password.isEmpty || phone.isEmpty || code.isEmpty) {
        throw 'All fields are required';
      }
      _isLoggedIn = true;
      _isLoading = false;
    } catch (error) {
      _errorMessage = error.toString();
      _isLoading = false;
      notifyListeners();
    }
  }
  void logout() {
  _isLoggedIn = false;
  notifyListeners();
}
}


// creation des services et appels des apis (login et register).