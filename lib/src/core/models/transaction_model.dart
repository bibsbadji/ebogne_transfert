class Transaction {
  final String from;
  final String to;
  final double amount;
  final DateTime date;
  final String? reference;
  final String? typeTransaction;
  final String? idTransaction;
  final String? destinataire;
  final String? emetteur;
  final String? statut;
  final String?dateTransaction;
  final String? montantTransaction;
  final String? operateur;



  Transaction({
    required this.from,
    required this.to,
    required this.amount,
    required this.date,
    this.reference,
    this.typeTransaction,
    this.idTransaction,
    this.destinataire,
    this.emetteur,
    this.statut,
    this.dateTransaction,
    this.montantTransaction,
    this.operateur,
  });
}