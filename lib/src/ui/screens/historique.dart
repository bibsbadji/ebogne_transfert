import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ebogne_transfert/src/core/models/transaction_model.dart';

class TransactionDetailScreen extends StatelessWidget {
  final Transaction transaction;
  const TransactionDetailScreen({required this.transaction});
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Détails")),
      body: Center(child: Text("Transaction: ${transaction.reference}")),
    );
  }
}


class HistoriqueScreen extends StatefulWidget {
  const HistoriqueScreen({super.key});

  @override
  State<HistoriqueScreen> createState() => _HistoriqueScreenState();
}

class _HistoriqueScreenState extends State<HistoriqueScreen> {
  // Simulation de données (à remplacer par un provider ou repository plus tard)
  List<Transaction> transactions = [
    Transaction(
      idTransaction: "TRX001",
      reference: "REF-987654",
      amount: 25000,
      typeTransaction: "Envoi",
      statut: "Succès",
      dateTransaction: DateTime.now().subtract(const Duration(hours: 2)).toIso8601String(),
      date: DateTime.now().subtract(const Duration(hours: 2)),
      destinataire: "77 123 45 67",
      operateur: "Wave",
      from: "78 000 00 00",
      to: "77 123 45 67",
    ),
    Transaction(
      idTransaction: "TRX002",
      reference: "REF-123456",
      amount: 15000,
      typeTransaction: "Reception",
      statut: "Succès",
      dateTransaction: DateTime.now().subtract(const Duration(days: 1)).toIso8601String(),
      date: DateTime.now().subtract(const Duration(days: 1)),
      emetteur: "78 987 65 43",
      operateur: "Orange Money",
      from: "78 987 65 43",
      to: "77 000 00 00",
    ),
    // Ajoutez d'autres transactions pour tester
  ];

  String filter = "Tout"; // Tout, Envoi, Reception, Succès

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Historique"),
        centerTitle: true,
        elevation: 0,
      ),
      body: Column(
        children: [
          // Filtres
          _buildFilters(),
          
          const Divider(height: 1),

          // Liste des transactions
          Expanded(
            child: transactions.isEmpty
                ? const Center(
                    child: Text(
                      "Aucune transaction trouvée",
                      style: TextStyle(fontSize: 16, color: Colors.grey),
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: transactions.length,
                    itemBuilder: (context, index) {
                      final tx = transactions[index];
                      return _buildTransactionTile(tx);
                    },
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilters() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: ["Tout", "Envoi", "Réception", "Succès"].map((f) {
            final bool isSelected = filter == f;
            return Padding(
              padding: const EdgeInsets.only(right: 8),
              child: FilterChip(
                label: Text(f),
                selected: isSelected,
                onSelected: (selected) {
                  setState(() => filter = f);
                  // TODO: Appliquer le filtre réel
                },
                backgroundColor: Colors.grey[100],
                selectedColor: const Color(0xFF1D3557),
                labelStyle: TextStyle(
                  color: isSelected ? Colors.white : Colors.black87,
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }

  Widget _buildTransactionTile(Transaction tx) {
    final bool isEnvoi = tx.typeTransaction?.toLowerCase() == "envoi";
    final Color amountColor = isEnvoi ? Colors.red : Colors.green;

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: Colors.grey[200]!),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        leading: CircleAvatar(
          backgroundColor: isEnvoi ? Colors.orange[50] : Colors.green[50],
          child: Icon(
            isEnvoi ? Icons.arrow_upward : Icons.arrow_downward,
            color: isEnvoi ? Colors.orange : Colors.green,
          ),
        ),
        title: Text(
          isEnvoi ? "Envoi" : "Réception",
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(
          tx.dateTransaction != null
              ? DateFormat('dd MMM yyyy • HH:mm')
                  .format(DateTime.parse(tx.dateTransaction!))
              : '',
          style: const TextStyle(fontSize: 13),
        ),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              "${isEnvoi ? '-' : '+'} ${tx.amount.toStringAsFixed(0)} FCFA",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: amountColor,
                fontSize: 15,
              ),
            ),
            Text(
              tx.statut ?? '',
              style: TextStyle(
                color: (tx.statut ?? '') == "Succès" ? Colors.green : Colors.orange,
                fontSize: 12,
              ),
            ),
          ],
        ),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => TransactionDetailScreen(transaction: tx),
            ),
          );
        },
      ),
    );
  }
}