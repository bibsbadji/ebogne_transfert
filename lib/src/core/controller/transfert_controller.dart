import 'package:flutter/material.dart';

class TransfertController extends ChangeNotifier {
  // --- ÉTAT (STATE) ---
  
  // Solde fictif initial (lié à l'entité UTILISATEUR du MCD)
  double _soldeDisponible = 250000.0;
  double get soldeDisponible => _soldeDisponible;

  // Liste des transactions (lié à l'entité TRANSACTION du MCD)
  final List<TransactionModel> _historique = [];
  List<TransactionModel> get historique => _historique;

  // État de chargement pour l'interface
  bool _isProcessing = false;
  bool get isProcessing => _isProcessing;

  bool? get isLoading => null;

  // --- LOGIQUE MÉTIER (BUSINESS LOGIC) ---

  /// Fonction pour effectuer un transfert (Fonctionnalité 6 du sujet)
  Future<String> initierTransfert({
    required String telephoneDestinataire,
    required double montant,
  }) async {
    _isProcessing = true;
    notifyListeners();

    // Simulation d'un délai de traitement (Appel API ou DB)
    await Future.delayed(const Duration(seconds: 2));

    // 1. SÉCURITÉ MINIMALE : Interdiction montant négatif ou nul
    if (montant <= 0) {
      _isProcessing = false;
      notifyListeners();
      return "Erreur : Le montant doit être supérieur à zéro.";
    }

    // 2. SÉCURITÉ MINIMALE : Vérification solde suffisant
    if (montant > _soldeDisponible) {
      _isProcessing = false;
      notifyListeners();
      return "Erreur : Solde insuffisant (Solde actuel : $_soldeDisponible F).";
    }

    try {
      // 3. MISE À JOUR DES SOLDES (Phase 6.2)
      _soldeDisponible -= montant;

      // 4. CRÉATION DE LA TRANSACTION (Respect des attributs du MCD Page 4)
      final nouvelleTransaction = TransactionModel(
        idTransaction: "TRX-${DateTime.now().millisecondsSinceEpoch}",
        montant: montant,
        dateTransaction: DateTime.now(),
        typeTransaction: "Envoi", // Type : Envoi
        statut: "Succès",        // Statut : Succès
        reference: "REF-${_generateReference()}",
      );

      // 5. AJOUT À L'HISTORIQUE (Phase 6.3)
      _historique.insert(0, nouvelleTransaction);

      _isProcessing = false;
      notifyListeners();
      return "SUCCESS";
    } catch (e) {
      _isProcessing = false;
      notifyListeners();
      return "Une erreur technique est survenue lors du transfert.";
    }
  }

  // Générateur de référence unique (Attribut obligatoire du MCD)
  String _generateReference() {
    return DateTime.now().ticks.toString().substring(10);
  }

  Future<dynamic> effectuerTransfert({required String numeroDestinataire, required double montant}) async {}
}

extension on DateTime {
  get ticks => millisecondsSinceEpoch;
}

class TransactionModel {
  final String idTransaction;
  final double montant;
  final DateTime dateTransaction;
  final String typeTransaction;
  final String statut;
  final String reference;

  TransactionModel({
    required this.idTransaction,
    required this.montant,
    required this.dateTransaction,
    required this.typeTransaction,
    required this.statut,
    required this.reference,
  });
}