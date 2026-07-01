import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ebogne_transfert/src/core/providers/auth_providers.dart';
import 'package:ebogne_transfert/src/ui/routes/route_path.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // État local pour gérer la visibilité du solde
  bool _isBalanceVisible = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ebogne Transfert'),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.account_circle, size: 28),
          onPressed: () {
            Navigator.pushNamed(context, '/profile');
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              context.read<AuthProviders>().logout();
              Navigator.pushNamedAndRemoveUntil(
                context,
                login,
                (route) => false,
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            
            // Carte principale : Affichage du solde interactif
            Card(
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
                child: SizedBox(
                  width: double.infinity,
                  child: Column(
                    children: [   
                      // Ligne contenant le solde et le bouton œil côte à côte
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            _isBalanceVisible ? "125 000 FCFA" : "••••••• FCFA",
                            style: const TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 1.2,
                            ),
                          ),
                          const SizedBox(width: 12),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                _isBalanceVisible = !_isBalanceVisible;
                              });
                            },
                            child: Icon(
                              _isBalanceVisible
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              color: Colors.blue.shade700,
                              size: 26, // Taille légèrement augmentée pour faciliter le clic
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                       Icon( 
                            Icons.qr_code_scanner,
                            color: Colors.blue.shade700,
                            size: 150,
                          ),
                    ],
                  ),
                ),
              ),
            ),

            const SizedBox(height: 30),
            const Text(
              "Actions rapides",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 15),

            // Grid Layout (3 colonnes)
            GridView.count(
              crossAxisCount: 3,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              mainAxisSpacing: 12,
              crossAxisSpacing: 12,
              childAspectRatio: 0.95,
              children: [
                _actionButton(
                  context,
                  Icons.send,
                  "Transfert",
                  () => Navigator.pushNamed(context, '/send-money'),
                ),
                _actionButton(
                  context,
                  Icons.payment,
                  "Paiement",
                  () => Navigator.pushNamed(context, '/receive-money'),
                ),
                _actionButton(
                  context,
                  Icons.history,
                  "Historique",
                  () => Navigator.pushNamed(context, '/historique'),
                ),
                _actionButton(
                  context,
                  Icons.account_balance_wallet,
                  "Portefeuille",
                  () => Navigator.pushNamed(context, '/Portefeuille'),
                ),
                _actionButton(
                  context,
                  Icons.settings,
                  "Paramètres",
                  () => Navigator.pushNamed(context, '/parametres'),
                ),
                _actionButton(
                  context,
                  Icons.notifications,
                  "Notifications",
                  () => Navigator.pushNamed(context, '/notifications'),
                ),
              ],
            ),

            const SizedBox(height: 30),
            const Text(
              "Transactions récentes",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 15),

            const Card(
              child: ListTile(
                leading: Icon(Icons.arrow_downward, color: Colors.green),
                title: Text("+ 15 000 FCFA"),
                subtitle: Text("Aujourd'hui"),
              ),
            ),
            const Card(
              child: ListTile(
                leading: Icon(Icons.arrow_upward, color: Colors.red),
                title: Text("- 5 000 FCFA"),
                subtitle: Text("Hier"),
              ),
            ),
            const Card(
              child: ListTile(
                leading: Icon(Icons.arrow_downward, color: Colors.green),
                title: Text("+ 20 000 FCFA"),
                subtitle: Text("Il y a 2 jours"),
              ),
            ),
            const Card(
              child: ListTile(
                leading: Icon(Icons.arrow_upward, color: Colors.red),
                title: Text("- 10 000 FCFA"),
                subtitle: Text("Il y a 3 jours"),
              ),
            ),
            const Card(
              child: ListTile(
                leading: Icon(Icons.arrow_downward, color: Colors.green),
                title: Text("+ 50 000 FCFA"),
                subtitle: Text("Il y a une semaine"),
              ),
            ),
          ],
        ),
      ),
    );
  }

  static Widget _actionButton(
    BuildContext context,
    IconData icon,
    String label,
    VoidCallback onTap,
  ) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(15),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 4),
        decoration: BoxDecoration(
          color: Colors.blue.shade50,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 28, color: Colors.blue.shade700),
            const SizedBox(height: 8),
            Text(
              label,
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}