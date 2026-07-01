import 'package:flutter/material.dart';

// Screens
import 'package:ebogne_transfert/src/ui/screens/splash/splash.dart';
import 'package:ebogne_transfert/src/ui/screens/login/login.dart';
import 'package:ebogne_transfert/src/ui/screens/register/register.dart';
import 'package:ebogne_transfert/src/ui/screens/dashboard.dart';
import 'package:ebogne_transfert/src/ui/screens/home/home.dart';
import 'package:ebogne_transfert/src/ui/screens/profile.dart';
import 'package:ebogne_transfert/src/ui/screens/historique.dart';
import 'package:ebogne_transfert/src/ui/screens/portefeuille.dart';
import 'package:ebogne_transfert/src/ui/screens/parametres.dart';
import 'package:ebogne_transfert/src/ui/screens/notifications.dart';

// Route paths
import 'package:ebogne_transfert/src/ui/routes/route_path.dart';

class Routes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      // Auth & Onboarding
      case splash:
        return MaterialPageRoute(builder: (_) => const SplashScreen());

      case login:
        return MaterialPageRoute(builder: (_) => const LoginScreen());

      case register:
        return MaterialPageRoute(builder: (_) => RegisterPage());

      
      case dashboard: // alias accepté
        return MaterialPageRoute(builder: (_) => const DashboardScreen());

      // Main App
      case home:
        return MaterialPageRoute(builder: (_) => const HomeScreen());

      case profile:
        return MaterialPageRoute(builder: (_) => ProfileScreen());

      case historique:
        return MaterialPageRoute(builder: (_) => const HistoriqueScreen());

      case portefeuille:
        return MaterialPageRoute(builder: (_) => const PortefeuilleScreen());

      case parametres:
        return MaterialPageRoute(builder: (_) => const ParametresScreen());

      case notifications:
        return MaterialPageRoute(builder: (_) => const NotificationsScreen());

      // Route par défaut améliorée
      default:
        return MaterialPageRoute(
          builder: (_) => const Scaffold(
            body: Center(
              child: Text(
                'Page non trouvée',
                style: TextStyle(fontSize: 18),
              ),
            ),
          ),
        );
    }
  }
}