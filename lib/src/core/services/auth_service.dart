import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:ebogne_transfert/src/core/models/auth_response.dart';
import 'package:ebogne_transfert/src/ui/constantes/apiconstant.dart';

class AuthService {
  final http.Client _client;

  AuthService({http.Client? client}) : _client = client ?? http.Client();

  Future<AuthResponse> login(String email, String password) async {
    final response = await _client.post(
      Uri.parse('${apiUrl}login'),
      body: {'email': email, 'password': password},
    );

    final body = jsonDecode(response.body) as Map<String, dynamic>;

    if (response.statusCode == 200) {
      return AuthResponse.fromJson(body);
    } else {
      throw Exception(body['message'] ?? 'Login failed');
    }
  }
  Future<AuthResponse> register(
  String name,
  String email,
  String password,
  String phone,
  String code,
) async {
  final response = await _client.post(
    Uri.parse('${apiUrl}register'),
    body: {
      'name': name,
      'email': email,
      'password': password,
      'phone': phone,
      'code': code,
    },
  );

  final body = jsonDecode(response.body) as Map<String, dynamic>;

  if (response.statusCode == 200 || response.statusCode == 201) {
    return AuthResponse.fromJson(body);
  } else {
    throw Exception(body['message'] ?? 'Registration failed');
  }
}
}
