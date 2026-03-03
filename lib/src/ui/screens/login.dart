import 'package:ebogne_transfert/src/ui/widgets/forms/app_button/app_button.dart';
import 'package:ebogne_transfert/src/utils/my_assets/images_assets.dart';
import 'package:flutter/material.dart';
import 'package:ebogne_transfert/src/ui/routes/route_path.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  bool isPasswordHidden = true;
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Form(
            key: _formKey,
            child: Column(
              children: [
                Image.asset(
                  ImagesAssets.logo,
                  fit: BoxFit.cover,
                ),
                Text(
                  "Ton argent, ton rythme \n Transfert sans stress",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                ),
                SizedBox(height: 20),
                AppButton(
                  bgColor: Colors.blue,
                  text: 'Se connecter',
                  textColor: Colors.white,
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      setState(() {
                        isLoading = true;
                      });

                      await Future.delayed(Duration(seconds: 1));
                      setState(() {
                        isLoading = false;
                      });
                      Navigator.pushReplacementNamed(context, connexion);
                    }
                  },
                ),
                SizedBox(height: 10),
                AppButton(
                  text: 'Créer un compte',
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      setState(() {
                        isLoading = true;
                      });

                      await Future.delayed(Duration(seconds: 1));
                      setState(() {
                        isLoading = false;
                      });
                      Navigator.pushReplacementNamed(context, register);
                    }
                  },
                ),
              ],
            )),
      ),
    );
  }
}
