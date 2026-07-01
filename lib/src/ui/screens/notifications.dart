import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NotificationModel {
  final String id;
  final String title;
  final String message;
  final String type; // 'transaction', 'security', 'promo', 'info'
  final DateTime date;
  final bool isRead;

  NotificationModel({
    required this.id,
    required this.title,
    required this.message,
    required this.type,
    required this.date,
    this.isRead = false,
  });
}

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  List<NotificationModel> notifications = [
    NotificationModel(
      id: "1",
      title: "Transaction réussie",
      message: "Vous avez envoyé 25.000 FCFA à 77 123 45 67 via Wave.",
      type: "transaction",
      date: DateTime.now().subtract(const Duration(minutes: 30)),
      isRead: false,
    ),
    NotificationModel(
      id: "2",
      title: "Sécurité",
      message: "Votre compte a été connecté depuis un nouvel appareil.",
      type: "security",
      date: DateTime.now().subtract(const Duration(hours: 3)),
      isRead: true,
    ),
    NotificationModel(
      id: "3",
      title: "Promotion",
      message: "Profitez de 2% de bonus sur vos prochains transferts avec Orange Money.",
      type: "promo",
      date: DateTime.now().subtract(const Duration(days: 1)),
      isRead: false,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Notifications"),
        centerTitle: true,
        actions: [
          TextButton.icon(
            onPressed: () {
              setState(() {
                notifications = notifications.map((n) => NotificationModel(
                  id: n.id,
                  title: n.title,
                  message: n.message,
                  type: n.type,
                  date: n.date,
                  isRead: true,
                )).toList();
              });
            },
            icon: const Icon(Icons.done_all, color: Colors.white),
            label: const Text("Tout lire", style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
      body: notifications.isEmpty
          ? const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.notifications_off, size: 80, color: Colors.grey),
                  SizedBox(height: 16),
                  Text("Aucune notification", style: TextStyle(fontSize: 18)),
                ],
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: notifications.length,
              itemBuilder: (context, index) {
                final notif = notifications[index];
                return _buildNotificationTile(notif);
              },
            ),
    );
  }

  Widget _buildNotificationTile(NotificationModel notif) {
    final Color iconColor = _getIconColor(notif.type);
    final IconData icon = _getIcon(notif.type);

    return Dismissible(
      key: Key(notif.id),
      direction: DismissDirection.endToStart,
      background: Container(
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20),
        color: Colors.red,
        child: const Icon(Icons.delete, color: Colors.white),
      ),
      onDismissed: (direction) {
        setState(() {
          notifications.removeWhere((n) => n.id == notif.id);
        });
      },
      child: Card(
        margin: const EdgeInsets.only(bottom: 12),
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: BorderSide(color: Colors.grey[200]!),
        ),
        child: ListTile(
          contentPadding: const EdgeInsets.all(16),
          leading: CircleAvatar(
            backgroundColor: iconColor.withOpacity(0.1),
            child: Icon(icon, color: iconColor),
          ),
          title: Text(
            notif.title,
            style: TextStyle(
              fontWeight: notif.isRead ? FontWeight.normal : FontWeight.bold,
            ),
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 6),
              Text(notif.message),
              const SizedBox(height: 8),
              Text(
                DateFormat('dd MMM yyyy • HH:mm').format(notif.date),
                style: const TextStyle(fontSize: 12, color: Colors.grey),
              ),
            ],
          ),
          trailing: notif.isRead
              ? null
              : const Icon(Icons.circle, size: 10, color: Color(0xFF1D3557)),
          onTap: () {
            // Marquer comme lu
            setState(() {
              final index = notifications.indexWhere((n) => n.id == notif.id);
              if (index != -1) {
                notifications[index] = NotificationModel(
                  id: notif.id,
                  title: notif.title,
                  message: notif.message,
                  type: notif.type,
                  date: notif.date,
                  isRead: true,
                );
              }
            });

            // TODO: Navigation vers détail si nécessaire
          },
        ),
      ),
    );
  }

  IconData _getIcon(String type) {
    switch (type) {
      case 'transaction':
        return Icons.swap_horiz;
      case 'security':
        return Icons.security;
      case 'promo':
        return Icons.local_offer;
      default:
        return Icons.notifications;
    }
  }

  Color _getIconColor(String type) {
    switch (type) {
      case 'transaction':
        return Colors.blue;
      case 'security':
        return Colors.red;
      case 'promo':
        return Colors.orange;
      default:
        return Colors.grey;
    }
  }
}