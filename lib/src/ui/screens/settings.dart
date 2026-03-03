import 'package:flutter/material.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Paramètres"),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0), // Padding standard [cite: 180]
        children: [
          _buildSectionTitle("Compte & Sécurité"),
          _buildSettingsItem(
            icon: Icons.lock_outline,
            title: "Modifier le code PIN",
            subtitle: "Sécurisez l'accès à vos transactions",
            onTap: () {},
          ),
          _buildSettingsItem(
            icon: Icons.fingerprint,
            title: "Authentification Biométrique",
            subtitle: "Utiliser l'empreinte digitale",
            trailing: Switch(value: true, onChanged: (val) {}),
          ),
          
          const SizedBox(height: 20),
          _buildSectionTitle("Préférences"),
          _buildSettingsItem(
            icon: Icons.notifications_none,
            title: "Notifications",
            subtitle: "Alertes de transfert et réception",
            trailing: Switch(value: false, onChanged: (val) {}),
          ),
          _buildSettingsItem(
            icon: Icons.language,
            title: "Langue",
            subtitle: "Français",
            onTap: () {},
          ),
          
          const SizedBox(height: 20),
          _buildSectionTitle("Assistance"),
          _buildSettingsItem(
            icon: Icons.help_outline,
            title: "Aide & Support",
            onTap: () {},
          ),
          _buildSettingsItem(
            icon: Icons.info_outline,
            title: "À propos",
            onTap: () {},
          ),
          
          const SizedBox(height: 40),
          // Bouton Déconnexion - Fonctionnalité obligatoire 
          ElevatedButton(
            onPressed: () => Navigator.pushReplacementNamed(context, '/login'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red[50],
              foregroundColor: Colors.red,
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12), // Radius standard [cite: 179]
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
          color: Colors.blueAccent, // Couleur primaire [cite: 172]
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
        borderRadius: BorderRadius.circular(10), // Cohérence avec le radius [cite: 179]
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