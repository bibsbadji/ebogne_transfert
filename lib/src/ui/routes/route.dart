import 'package:ebogne_transfert/src/ui/screens/otp.dart';
import 'package:ebogne_transfert/src/ui/screens/receive.dart';
import 'package:ebogne_transfert/src/ui/screens/send_money.dart';
import 'package:ebogne_transfert/src/ui/screens/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:ebogne_transfert/src/ui/routes/route_path.dart';
import '../screens/dashboard.dart';
import '../screens/history.dart';
import '../screens/login.dart';
import '../screens/onboarding.dart';
import '../screens/profile.dart';
import '../screens/register.dart';
import '../screens/connexion.dart';
import 'package:ebogne_transfert/src/ui/screens/settings.dart';

class Routes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case setting:
      return MaterialPageRoute( 
        builder: (_) => SettingScreen( ));
      
      case connexion:
        return MaterialPageRoute(
            builder: (_) => ConnexionScreen(onSuccess: () {}));
      case splash:
        return MaterialPageRoute(builder: (_) => const SplashScreen());
      case onboarding:
        return MaterialPageRoute(builder: (_) => const OnboardingScreens());
      case login:
        return MaterialPageRoute(builder: (_) => const LoginScreen());
      case OtpScreenState:
        return MaterialPageRoute(
            builder: (_) => OtpScreen(
                  phone: '',
                  onVerify: (String code) {},
                ));
      case receiveMoney:
        return MaterialPageRoute(builder: (_) => const ReceiveMoneyScreen());
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
