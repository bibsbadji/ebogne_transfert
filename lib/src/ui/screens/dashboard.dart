import 'package:ebogne_transfert/src/ui/routes/route_path.dart';
import 'package:flutter/material.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: const Icon(Icons.menu),
              onPressed: () {
                Navigator.pushReplacementNamed(context, setting);
              },
            );
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.person),
            onPressed: () {
              Navigator.pushReplacementNamed(context, profile);
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0), // Padding standard [source 49]
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Section Solde (Entité UTILISATEUR - solde) [source 70]
            _buildBalanceCard(),
            const SizedBox(height: 25),

            // Actions rapides (TRANSFERT) [source 93]
            const Text(
              "Actions rapides",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildActionButton(
                    context, "Envoyer", Icons.send, '/send_money'),
                _buildActionButton(
                    context, "Recevoir", Icons.qr_code, '/receive_money'),
                _buildActionButton(
                    context, "Historique", Icons.history, '/history'),
                _buildActionButton(context, "Plus", Icons.more_horiz, null),
              ],
            ),
            const SizedBox(height: 30),

            // Section Historique (Aperçu) [source 99]
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Dernières transactions",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                TextButton(
                  onPressed: () => Navigator.pushNamed(context, '/history'),
                  child: const Text("Voir tout"),
                ),
              ],
            ),
            _buildRecentTransactions(),
          ],
        ),
      ),
    );
  }

  // Widget : Carte du solde
  Widget _buildBalanceCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.blueAccent, // Couleur primaire [source 41]
        borderRadius: BorderRadius.circular(20), // Radius standard [source 48]
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10, // Ombres [source 50]
            offset: const Offset(0, 5),
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Text("Solde actuel", style: TextStyle(color: Colors.white70)),
          SizedBox(height: 10),
          Text(
            "250 000 FCFA",
            style: TextStyle(
              color: Colors.white,
              fontSize: 32,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  // Widget : Bouton d'action
  Widget _buildActionButton(
      BuildContext context, String label, IconData icon, String? route) {
    return Column(
      children: [
        GestureDetector(
          onTap: () =>
              route != null ? Navigator.pushNamed(context, route) : null,
          child: Container(
            padding: const Offset(0, 0) == const Offset(0, 0)
                ? const EdgeInsets.all(15)
                : null,
            decoration: BoxDecoration(
              color: Colors.grey[200],
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: Colors.blueAccent),
          ),
        ),
        const SizedBox(height: 8),
        Text(label, style: const TextStyle(fontSize: 12)),
      ],
    );
  }

  // Widget : Liste factice des transactions récentes
  Widget _buildRecentTransactions() {
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: 3,
      separatorBuilder: (context, index) => const Divider(),
      itemBuilder: (context, index) {
        return ListTile(
          leading:
              const CircleAvatar(child: Icon(Icons.arrow_upward, size: 18)),
          title: const Text("Transfert vers 77xxx"),
          subtitle: const Text("Aujourd'hui, 14:20"),
          trailing: const Text(
            "- 5 000 F",
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.red),
          ),
        );
      },
    );
  }
}
