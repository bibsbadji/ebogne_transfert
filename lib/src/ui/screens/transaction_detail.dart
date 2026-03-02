import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; 
import 'package:ebogne_transfert/src/core/controller/transfert_controller.dart';

class TransactionDetailScreen extends StatelessWidget {
  final TransactionModel transaction;

  const TransactionDetailScreen({super.key, required this.transaction});

  @override
  Widget build(BuildContext context) {
    // Vérification du type pour la couleur (Phase 1.3)
    final bool isEnvoi = transaction.typeTransaction == "Envoi";
    final Color statusColor =
        transaction.statut == "Succès" ? Colors.green : Colors.red;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Détails de la transaction"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            // Icône et Montant Principal
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.grey[50],
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                children: [
                  Icon(
                    isEnvoi ? Icons.arrow_upward : Icons.arrow_downward,
                    size: 50,
                    color: isEnvoi ? Colors.orange : Colors.green,
                  ),
                  const SizedBox(height: 15),
                  Text(
                    "${isEnvoi ? '-' : '+'} ${transaction.montant} FCFA",
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: isEnvoi ? Colors.black : Colors.green,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    transaction.statut,
                    style: TextStyle(
                        color: statusColor, fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),

            // Détails structurés (Attributs du MCD)
            _buildDetailCard([
              _detailItem("Référence", transaction.reference),
              _detailItem(
                  "Date",
                  DateFormat('dd/MM/yyyy HH:mm')
                      .format(transaction.dateTransaction)),
              _detailItem("Type", transaction.typeTransaction),
              _detailItem("ID Transaction", transaction.idTransaction),
              _detailItem("Destinataire/Émetteur", "77 000 00 00"), // Exemple
            ]),

            const SizedBox(height: 40),

            // Actions de partage ou téléchargement (Optionnel mais recommandé pour le rapport)
            Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () {},
                    icon: const Icon(Icons.share),
                    label: const Text("Partager Reçu"),
                    style: OutlinedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                    ),
                  ),
                ),
                const SizedBox(width: 15),
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.check),
                    label: const Text("Fermer"),
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailCard(List<Widget> children) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        side: BorderSide(color: Colors.grey[200]!),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(children: children),
      ),
    );
  }

  Widget _detailItem(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(color: Colors.grey, fontSize: 14)),
          Flexible(
            child: Text(
              value,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
              textAlign: TextAlign.right,
            ),
          ),
        ],
      ),
    );
  }
}
