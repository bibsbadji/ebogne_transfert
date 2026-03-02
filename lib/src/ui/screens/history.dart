import 'package:flutter/material.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Historique des transactions"), // [source 27]
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0), // Padding standard [source 49]
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Toutes vos activités",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 15),
            Expanded(
              child: ListView.builder(
                itemCount: 10, // Simulation de la liste des transactions [source 100]
                itemBuilder: (context, index) {
                  return _buildTransactionItem(context);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTransactionItem(BuildContext context) {
    // Simulation des données de l'entité TRANSACTION [source 73]
    final isEnvoi = true; // typeTransaction [source 78]
    
    return Card(
      elevation: 2,
      margin: const EdgeInsets.symmetric(vertical: 8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12), // Radius standard [source 48]
      ),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Colors.red[50],
          child: Icon(
            Icons.arrow_outward,
            color: Colors.red,
          ),
        ),
        title: Text(
          "Envoi d'argent",
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: const Text("24 Fév 2026 - 10:15"), // dateTransaction [source 77]
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              "${isEnvoi ? '-' : '+'} 25 000 F", // montant [source 76]
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: isEnvoi ? Colors.black : Colors.green,
                fontSize: 16,
              ),
            ),
            const Text(
              "Succès", // statut [source 78]
              style: TextStyle(fontSize: 12, color: Colors.grey),
            ),
          ],
        ),
        onTap: () {
          // Navigation vers "Détails d'une transaction" [source 28, 101]
          _showTransactionDetails(context);
        },
      ),
    );
  }

  void _showTransactionDetails(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => Container(
        padding: const EdgeInsets.all(24),
        height: 300,
        child: Column(
          children: [
            const Text("Détails de la transaction", 
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const Divider(),
            _detailRow("Référence", "REF-9928374"), // reference [source 79]
            _detailRow("Type", "Envoi"),
            _detailRow("Montant", "25 000 FCFA"),
            _detailRow("Statut", "Confirmé"),
            const Spacer(),
            ElevatedButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Fermer"),
            )
          ],
        ),
      ),
    );
  }

  Widget _detailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(color: Colors.grey)),
          Text(value, style: const TextStyle(fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }
}