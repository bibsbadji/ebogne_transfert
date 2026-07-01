
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class ApiService {
   static String get baseUrl {
    if(kIsWeb){
      return 'http://127.0.0.1:8000/api/';
    } else {
      return 'http://10.0.2.2:8000/api/';
    }
  }

 Future<Map<String, dynamic>> login({
    required String email,
    required String password,
  }) async {
    final response = await http.post(
      Uri.parse('$baseUrl/login'),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'email': email,
        'password': password,
      }),
    );

    final data = jsonDecode(response.body);

    if (response.statusCode == 200) {
      return data;
    }

    throw Exception(data['message'] ?? 'Erreur de connexion');
  }
}

class AuthProviders extends ChangeNotifier {
  final LoginService _loginService = LoginService();

  bool _isLoggedIn = false;
  bool _isLoading = false;
  String? _errorMessage;

  bool get isLoggedIn => _isLoggedIn;
  bool get isLoading => _isLoading;
  String? get error => _errorMessage;

  Future<void> login(String email, String password) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      await _loginService.login(
        email: email,
        password: password,
      );

      _isLoggedIn = true;
    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}

class LoginService {
  Future<void> login({
    required String email,
    required String password,
  }) async {
    await Future.delayed(const Duration(seconds: 2));

    if (email == '' && password == '') {
      // Simulate a successful login
    } else {
      throw Exception('Email ou mot de passe incorrect');
    }
  }
}

