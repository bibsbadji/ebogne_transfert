import 'package:ebogne_transfert/src/ui/routes/route_path.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'src/core/controller/login_controller.dart';
import 'src/core/controller/transfert_controller.dart';
import 'src/ui/routes/route.dart';
void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => LoginController()),
        ChangeNotifierProvider(create: (_) => TransfertController()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue),
      onGenerateRoute: Routes.generateRoute,
      initialRoute: splash,
    );
  }
}
