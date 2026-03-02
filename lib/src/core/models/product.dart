class Product {
  final int idUtilisateur ;
  final String nom;
  final String prenom;
  final String telephone;
  final String email;
  final double solde;
  final String pin;
  final String dateCreation;

  
  Product({
    required this.idUtilisateur,
    required this.nom,
    required this.prenom,
    required this.telephone,
    required this.email,
    required this.solde,
    required this.pin,
    required this.dateCreation,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      idUtilisateur: json['idUtilisateur'] as int,
      nom: json['nom'] as String,
      prenom: json['prenom'] as String,
      telephone: json['telephone'] as String,
      email: json['email'] as String,
      solde: json['solde'] as double,
      pin: json['pin'] as String,
      dateCreation: json['dateCreation'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'idUtilisateur': idUtilisateur,
      'nom': nom,
      'prenom': prenom,
      'telephone': telephone,
      'email': email,
      'solde': solde,
      'pin': pin,
      'dateCreation': dateCreation
    };
  }
}
