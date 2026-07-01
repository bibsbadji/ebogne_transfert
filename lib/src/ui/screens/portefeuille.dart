import 'package:flutter/material.dart';
import 'package:ebogne_transfert/src/core/models/transaction_model.dart';

class PortefeuilleScreen extends StatefulWidget {
  const PortefeuilleScreen({super.key});

  @override
  State<PortefeuilleScreen> createState() => _PortefeuilleScreenState();
}

class _PortefeuilleScreenState extends State<PortefeuilleScreen> {
  double soldePrincipal = 145250.75;
  double soldeBonus = 5250.0;

  final List<Map<String, dynamic>> services = [
    {'icon': Icons.send, 'title': 'Envoyer', 'color': Colors.orange},
    {'icon': Icons.receipt_long, 'title': 'Retirer', 'color': Colors.green},
    {'icon': Icons.payment, 'title': 'Payer', 'color': Colors.blue},
    {'icon': Icons.swap_horiz, 'title': 'Convertir', 'color': Colors.purple},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Portefeuille"),
        centerTitle: true,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Carte Solde Principal
            _buildSoldeCard(),

            const SizedBox(height: 24),

            // Actions rapides
            const Text(
              "Actions rapides",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            _buildQuickActions(),

            const SizedBox(height: 32),

            // Soldes secondaires
            const Text(
              "Autres soldes",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            _buildSecondaryBalances(),

            const SizedBox(height: 32),

            // Dernières transactions
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Dernières transactions",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                TextButton(
                  onPressed: () => Navigator.pushNamed(context, '/historique'),
                  child: const Text("Voir tout"),
                ),
              ],
            ),
            const SizedBox(height: 12),
            _buildLastTransactions(),
          ],
        ),
      ),
    );
  }

  Widget _buildSoldeCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF1D3557), Color(0xFF2A4A7A)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Solde disponible",
            style: TextStyle(color: Colors.white70, fontSize: 16),
          ),
          const SizedBox(height: 8),
          Text(
            "${soldePrincipal.toStringAsFixed(2)} FCFA",
            style: const TextStyle(
              color: Colors.white,
              fontSize: 32,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              const Icon(Icons.trending_up, color: Colors.greenAccent, size: 20),
              const SizedBox(width: 6),
              const Text(
                "Bonus : ",
                style: TextStyle(color: Colors.white70),
              ),
              Text(
                "+ ${soldeBonus.toStringAsFixed(0)} FCFA",
                style: const TextStyle(
                  color: Colors.greenAccent,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildQuickActions() {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
      ),
      itemCount: services.length,
      itemBuilder: (context, index) {
        final service = services[index];
        return GestureDetector(
          onTap: () {
            // TODO: Navigation selon le service
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text("Ouverture : ${service['title']}")),
            );
          },
          child: Container(
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  backgroundColor: service['color'].withOpacity(0.1),
                  child: Icon(service['icon'], color: service['color']),
                ),
                const SizedBox(height: 8),
                Text(
                  service['title'],
                  style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildSecondaryBalances() {
    return Column(
      children: [
        _balanceTile("Orange Money", "45,780 FCFA", Colors.orange),
        const SizedBox(height: 10),
        _balanceTile("Wave", "78,450 FCFA", Colors.purple),
        const SizedBox(height: 10),
        _balanceTile("Free Money", "21,020 FCFA", Colors.blue),
      ],
    );
  }

  Widget _balanceTile(String name, String amount, Color color) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey[200]!),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              CircleAvatar(backgroundColor: color.withOpacity(0.1), radius: 18),
              const SizedBox(width: 12),
              Text(name, style: const TextStyle(fontWeight: FontWeight.w600)),
            ],
          ),
          Text(
            amount,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  Widget _buildLastTransactions() {
    // Simulation de 3 dernières transactions
    final List<Transaction> lastTx = [
      // Vous pouvez utiliser de vraies données ici
    ];

    if (lastTx.isEmpty) {
      return const Center(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Text("Aucune transaction récente"),
        ),
      );
    }

    return const SizedBox(); // Remplacer par une liste réelle
  }
}