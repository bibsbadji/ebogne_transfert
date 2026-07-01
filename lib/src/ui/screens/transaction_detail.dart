import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ebogne_transfert/src/core/models/transaction_model.dart';
// import 'package:share_plus/share_plus.dart'; // Si vous implémentez le partage

class TransactionDetailScreen extends StatelessWidget {
  final Transaction transaction;

  const TransactionDetailScreen({
    super.key,
    required this.transaction,
  });

  @override
  Widget build(BuildContext context) {
    final bool isEnvoi = transaction.typeTransaction?.toLowerCase() == "envoi";
    final Color statusColor = transaction.statut?.toLowerCase() == "succès" 
        ? Colors.green 
        : Colors.red;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Détails de la transaction"),
        centerTitle: true,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            // En-tête montant + statut
            _buildHeader(isEnvoi, statusColor),

            const SizedBox(height: 30),

            // Détails
            _buildDetailCard([
              _detailItem("Référence", transaction.reference ?? '-'),
              const Divider(height: 1),
              _detailItem(
                "Date",
                DateFormat('dd/MM/yyyy à HH:mm').format(transaction.date),
              ),
              const Divider(height: 1),
              _detailItem("Type", transaction.typeTransaction ?? '-'),
              const Divider(height: 1),
              _detailItem("ID Transaction", transaction.idTransaction ?? '-'),
              const Divider(height: 1),
              _detailItem(
                isEnvoi ? "Destinataire" : "Émetteur",
                transaction.destinataire ?? transaction.emetteur ?? "Non renseigné",
              ),
            ]),

            const SizedBox(height: 40),

            // Actions
            _buildActions(context),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(bool isEnvoi, Color statusColor) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.grey[200]!),
      ),
      child: Column(
        children: [
          Icon(
            isEnvoi ? Icons.arrow_upward : Icons.arrow_downward,
            size: 56,
            color: isEnvoi ? Colors.orange : Colors.green,
          ),
          const SizedBox(height: 16),
          Text(
            "${isEnvoi ? '-' : '+'} ${transaction.montantTransaction ?? transaction.montantTransaction} FCFA",
            style: const TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            transaction.statut ?? 'Inconnu',
            style: TextStyle(
              color: statusColor,
              fontWeight: FontWeight.w600,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailCard(List<Widget> children) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        side: BorderSide(color: Colors.grey[200]!),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        child: Column(children: children),
      ),
    );
  }

  Widget _detailItem(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 14),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 2,
            child: Text(
              label,
              style: TextStyle(color: Colors.grey[600], fontSize: 14),
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              value,
              style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
              textAlign: TextAlign.right,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActions(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: OutlinedButton.icon(
            onPressed: () {
              // SharePlus example :
              // Share.share('Transaction ${transaction.reference} - ${transaction.montant} FCFA');
            },
            icon: const Icon(Icons.share_outlined),
            label: const Text("Partager"),
            style: OutlinedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: ElevatedButton.icon(
            onPressed: () => Navigator.of(context).pop(),
            icon: const Icon(Icons.check_circle),
            label: const Text("Fermer"),
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 16),
              backgroundColor: const Color(0xFF1D3557),
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
        ),
      ],
    );
  }
}