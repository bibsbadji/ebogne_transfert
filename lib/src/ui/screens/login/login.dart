import 'package:ebogne_transfert/src/core/providers/auth_providers.dart';
import 'package:ebogne_transfert/src/ui/routes/route_path.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailCtrl = TextEditingController();
  final _passCtrl = TextEditingController();
  final _focusEmail = FocusNode();
  final _focusPass = FocusNode();

  @override
  void dispose() {
    _emailCtrl.dispose();
    _passCtrl.dispose();
    _focusEmail.dispose();
    _focusPass.dispose();
    super.dispose();
  }

  void _handleLogin(BuildContext ctx) {
    if (_formKey.currentState!.validate()) {
      context
          .read<AuthProviders>()
          .login(_emailCtrl.text.trim(), _passCtrl.text.trim())
          .then((_) {
        if (!ctx.mounted) return;
        final auth = context.read<AuthProviders>();
        if (auth.errorMessage != null) {
          ScaffoldMessenger.of(ctx).showSnackBar(
            SnackBar(
              content: Text(auth.errorMessage!),
              backgroundColor: Colors.redAccent,
            ),
          );
        } else {
          Navigator.pushReplacementNamed(context, home);
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background décoratif
          Positioned(
            top: -100,
            right: -100,
            child: Container(
              width: 300,
              height: 300,
              decoration: BoxDecoration(
                color: const Color(0xFF457B9D).withOpacity(0.1),
                borderRadius: BorderRadius.circular(150),
              ),
            ),
          ),
          Positioned(
            bottom: -50,
            left: -50,
            child: Container(
              width: 200,
              height: 200,
              decoration: BoxDecoration(
                color: const Color(0xFFA8DADC).withOpacity(0.15),
                borderRadius: BorderRadius.circular(100),
              ),
            ),
          ),
          SafeArea(
            child: Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const Text(
                      'Ebogne Transfert',
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF1D3557),
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Accédez à votre espace financier',
                      style: TextStyle(fontSize: 15, color: Colors.grey),
                    ),
                    const SizedBox(height: 40),
                    Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          TextFormField(
                            controller: _emailCtrl,
                            focusNode: _focusEmail,
                            keyboardType: TextInputType.emailAddress,
                            decoration: const InputDecoration(
                              labelText: 'Email',
                              prefixIcon: Icon(Icons.email_outlined),
                            ),
                            validator: (v) =>
                                v == null || v.isEmpty ? 'Email requis' : null,
                          ),
                          const SizedBox(height: 16),
                          TextFormField(
                            controller: _passCtrl,
                            focusNode: _focusPass,
                            obscureText: true,
                            decoration: const InputDecoration(
                              labelText: 'Mot de passe',
                              prefixIcon: Icon(Icons.lock_outline),
                            ),
                            validator: (v) => v == null || v.isEmpty
                                ? 'Mot de passe requis'
                                : null,
                          ),
                          const SizedBox(height: 8),
                          Align(
                            alignment: Alignment.centerRight,
                            child: TextButton(
                              onPressed: () {},
                              child: const Text(
                                'Mot de passe oublié ?',
                                style: TextStyle(color: Color(0xFF457B9D)),
                              ),
                            ),
                          ),
                          const SizedBox(height: 24),
                          Consumer<AuthProviders>(
                            builder: (ctx, auth, _) => auth.isLoading
                                ? const Center(
                                    child: CircularProgressIndicator(),
                                  )
                                : ElevatedButton(
                                    onPressed: () => _handleLogin(context),
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: const Color(
                                        0xFF1D3557,
                                      ),
                                      padding: const EdgeInsets.symmetric(
                                        vertical: 16,
                                      ),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(16),
                                      ),
                                      elevation: 4,
                                    ),
                                    child: const Text(
                                      'Se connecter',
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 32),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("Pas encore de compte ?"),
                        TextButton(
                          onPressed: () => Navigator.pushNamed(context, home),
                          child: const Text(
                            "S'inscrire",
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF457B9D),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
