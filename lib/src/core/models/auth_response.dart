import 'package:ebogne_transfert/src/core/models/user.dart';


class AuthResponse {
  final String acces_token;
  final User user;

  AuthResponse({required this.acces_token, required this.user});

  factory AuthResponse.fromJson(Map<String, dynamic> json) {
    return AuthResponse(
      acces_token: json['acces_token'],
      user: User.fromJson(json['user']),
    );
  }
}