import 'package:flutter/material.dart';
// Imports des écrans
import 'package:ebogne_transfert/src/ui/screens/splash_screen.dart';
import 'package:ebogne_transfert/src/ui/screens/onboarding.dart';
import 'package:ebogne_transfert/src/ui/screens/login.dart';
import 'package:ebogne_transfert/src/ui/screens/register.dart';
import 'package:ebogne_transfert/src/ui/screens/dashboard.dart';
import 'package:ebogne_transfert/src/ui/screens/send_money.dart';
import 'package:ebogne_transfert/src/ui/screens/history.dart';
import 'package:ebogne_transfert/src/ui/screens/profile.dart';

class AppRouter {
  // Définition des noms de routes comme constantes pour éviter les erreurs de frappe
  static const String splash = '/';
  static const String onboarding = '/onboarding';
  static const String login = '/login';
  static const String register = '/register';
  static const String dashboard = '/dashboard';
  static const String sendMoney = '/send_money';
  static const String history = '/history';
  static const String profile = '/profile';
  static const String settings = '/settings';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case splash:
        return MaterialPageRoute(builder: (_) => const SplashScreen());
      case onboarding:
        return MaterialPageRoute(builder: (_) => const OnboardingScreen());
      case login:
        return MaterialPageRoute(builder: (_) => LoginScreen());
      case register:
        return MaterialPageRoute(builder: (_) => const RegisterScreen());
      case dashboard:
        return MaterialPageRoute(builder: (_) => const DashboardScreen());
      case sendMoney:
        return MaterialPageRoute(builder: (_) => SendMoneyScreen());
      case history:
        return MaterialPageRoute(builder: (_) => const HistoryScreen());
      case profile:
        return MaterialPageRoute(builder: (_) => const ProfileScreen());
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('Pas de route définie pour ${settings.name}'),
            ),
          ),
        );
    }
  }
}
