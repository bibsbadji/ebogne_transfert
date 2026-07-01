import 'package:flutter/material.dart';

class ParametresScreen extends StatelessWidget {
  const ParametresScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Paramètres"),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          _buildSectionTitle("Compte & Sécurité"),

          // 🔥 CORRECTION : onTap FIXED
          _buildSettingsItem(
            icon: Icons.lock_outline,
            title: "Modifier le code PIN",
            subtitle: "Sécurisez l'accès à vos transactions",
            onTap: () => Navigator.pushNamed(context, '/connexion'),
          ),

          _buildSettingsItem(
            icon: Icons.fingerprint,
            title: "Authentification Biométrique",
            subtitle: "Utiliser l'empreinte digitale",
            trailing: Switch(value: true, onChanged: (val) {}),
            onTap: () => Navigator.pushNamed(context, '/biometric') ,

          ),

          const SizedBox(height: 20),
          _buildSectionTitle("Préférences"),

          _buildSettingsItem(
            icon: Icons.notifications_none,
            title: "Notifications",
            subtitle: "Alertes de transfert et réception",
            trailing: Switch(value: false, onChanged: (val) {}),
            onTap: () => Navigator.pushNamed(context, '/notifications'),
          ),

          _buildSettingsItem(
            icon: Icons.language,
            title: "Langue",
            subtitle: "Français",
            onTap: () => Navigator.pushNamed(context, '/language'),
          ),

          const SizedBox(height: 20),
          _buildSectionTitle("Assistance"),

          _buildSettingsItem(
            icon: Icons.help_outline,
            title: "Aide & Support",
            onTap: () => Navigator.pushNamed(context, '/help'),
          ),
          _buildSettingsItem(
            icon: Icons.info_outline,
            title: "À propos",
            onTap: () => Navigator.pushNamed(context, '/about'),
          ),

          const SizedBox(height: 40),

          // 🔥 Déconnexion propre
          ElevatedButton(
            onPressed: () => Navigator.pushReplacementNamed(context, '/login'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red[50],
              foregroundColor: Colors.red,
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: const Text("Déconnexion"),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: Colors.blueAccent,
        ),
      ),
    );
  }

  Widget _buildSettingsItem({
    required IconData icon,
    required String title,
    String? subtitle,
    Widget? trailing,
    VoidCallback? onTap,
  }) {
    return Card(
      elevation: 0,
      margin: const EdgeInsets.symmetric(vertical: 4),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      color: Colors.grey[50],
      child: ListTile(
        leading: Icon(icon, color: Colors.black87),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.w500)),
        subtitle: subtitle != null ? Text(subtitle) : null,
        trailing: trailing ?? const Icon(Icons.chevron_right),
        onTap: onTap,
      ),
    );
  }
}
