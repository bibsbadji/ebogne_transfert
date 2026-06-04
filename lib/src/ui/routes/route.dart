import 'package:ebogne_transfert/src/ui/routes/route_path.dart';
import 'package:ebogne_transfert/src/ui/screens/home/home.dart';
import 'package:ebogne_transfert/src/ui/screens/splash/splash.dart';
import 'package:flutter/material.dart';
import 'package:ebogne_transfert/src/ui/screens/login/login.dart';
class Routes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case splash:
        return MaterialPageRoute(builder: (_) => const SplashScreen());
      case login:
        return MaterialPageRoute(builder: (_) => const LoginScreen());
      case home:
      return MaterialPageRoute(builder: (_) => const HomeScreen());
      default:
        return MaterialPageRoute(builder: (_) => const LoginScreen());
    }
  }
}
