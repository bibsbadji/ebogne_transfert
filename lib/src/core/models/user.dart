// les attributs de la classe User
class User {
  final int id;
  final String name;
  final String email;
  final String phone;
  final String code;

// constructeur de la classe User
  User({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.code,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      phone: json['phone'],
      code: json['code'],
    );
  }
}
