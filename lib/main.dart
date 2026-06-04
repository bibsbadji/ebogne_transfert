
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ebogne_transfert/src/ui/routes/route.dart';
import 'package:ebogne_transfert/src/ui/routes/route_path.dart';
import 'package:ebogne_transfert/src/core/providers/auth_providers.dart';

void main() {
  runApp(const AppProviders());
}

class AppProviders extends StatelessWidget {
  const AppProviders({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => TransactionController(),
        ),

        ChangeNotifierProvider(
          create: (_) => AuthProviders(),
        ),
      ],
      child: const MyApp(),
    );
  }
}

class TransactionController extends ChangeNotifier {
  final List<Map<String, String>> _transactions = [];

  List<Map<String, String>> get transactions => _transactions;

  void addTransaction(
    String type,
    String amount,
    String date,
  ) {
    _transactions.add({
      'type': type,
      'amount': amount,
      'date': date,
    });

    notifyListeners();
  }

  void clearTransactions() {
    _transactions.clear();
    notifyListeners();
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Ebogne Transfert',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      initialRoute: splash, 
      onGenerateRoute: Routes.generateRoute,
      
      
    );
  }
}