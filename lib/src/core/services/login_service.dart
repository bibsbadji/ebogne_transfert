import 'dart:convert';
import 'package:flutter/services.dart';
import '../models/user.dart';

class LoginService {
  Future<List<User>> _loadUsers() async {
    final response = await rootBundle.loadString('assets/users.json');
    final List<dynamic> data = json.decode(response);
    return data.map((e) => User.fromJson(e)).toList();
  }

  Future<User?> login(String username, String password) async {
    final users = await _loadUsers();
    try {
      return users.firstWhere(
          (user) => user.telephone == username && user.pin == password);
    } catch (_) {
      return null;
    }
  }
}