import 'dart:async';
import 'package:flutter/material.dart';

class OtpScreen extends StatefulWidget {
  final String phone;
  final Function(String code) onVerify;

  const OtpScreen({
    super.key,
    required this.phone,
    required this.onVerify,
  });

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final List<TextEditingController> _controllers =
      List.generate(4, (_) => TextEditingController());

  int _remaining = 60;
  Timer? _timer;
  bool _canResend = false;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  @override
  void dispose() {
    for (var c in _controllers) {
      c.dispose();
    }
    _timer?.cancel();
    super.dispose();
  }

  void _startTimer() {
    _timer?.cancel();
    _remaining = 60;
    _canResend = false;

    _timer = Timer.periodic(const Duration(seconds: 1), (t) {
      if (_remaining == 0) {
        setState(() {
          _canResend = true;
        });
        t.cancel();
      } else {
        setState(() {
          _remaining--;
        });
      }
    });
  }

  void _onChanged(int index, String value) {
    if (value.isNotEmpty && index < 3) {
      FocusScope.of(context).nextFocus();
    }

    // Vérification automatique lorsque les 4 chiffres sont remplis
    String code = _controllers.map((c) => c.text).join();
    if (code.length == 4) {
      widget.onVerify(code);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Vérification OTP"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 25),
            Text(
              "Code envoyé à ${widget.phone}",
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: List.generate(
                4,
                (i) => _OtpBox(
                  controller: _controllers[i],
                  onChanged: (v) => _onChanged(i, v),
                ),
              ),
            ),
            const SizedBox(height: 25),
            Text(
              _canResend
                  ? "Renvoyer le code"
                  : "Renvoyer dans $_remaining secondes",
              style: TextStyle(
                color: _canResend ? Colors.blue : Colors.grey,
                fontSize: 15,
              ),
            ),
            const Spacer(),
            ElevatedButton(
              onPressed: () {
                String code = _controllers.map((c) => c.text).join();
                widget.onVerify(code);
              },
              child: const Text("Valider"),
            )
          ],
        ),
      ),
    );
  }
}

class _OtpBox extends StatelessWidget {
  final TextEditingController controller;
  final Function(String) onChanged;

  const _OtpBox({
    required this.controller,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 60,
      child: TextField(
        controller: controller,
        maxLength: 1,
        onChanged: onChanged,
        style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        keyboardType: TextInputType.number,
        textAlign: TextAlign.center,
        decoration: const InputDecoration(
          counterText: "",
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.blue, width: 2),
          ),
        ),
      ),
    );
  }
}
