import 'package:ebogne_transfert/src/ui/widgets/forms/app_button/app_button.dart';
import 'package:ebogne_transfert/src/utils/my_assets/icons_assets.dart';
import 'package:flutter/material.dart';
import 'package:ebogne_transfert/src/ui/routes/route_path.dart';

class OnboardingScreens extends StatefulWidget {
  const OnboardingScreens({super.key});

  @override
  State<OnboardingScreens> createState() => _OnboardingScreensState();
}

class _OnboardingScreensState extends State<OnboardingScreens> {
  final PageController _controller = PageController();
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: PageView(
                controller: _controller,
                onPageChanged: (index) {
                  setState(() => currentIndex = index);
                },
                children: const [
                  WalletPage(),
                  TransferPage(),
                  SecurityPage(),
                ],
              ),
            ),
            AppButton(
              text: "Suivant",
              icon: const Icon(Icons.arrow_forward_ios,
                  size: 16, color: Colors.blue),
              onPressed: () {
                if (currentIndex < 2) {
                  _controller.nextPage(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                  );
                } else {
                  Navigator.pushReplacementNamed(context, login);
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}

/* ---------------- PAGE 1 : PORTEFEUILLE ---------------- */

class WalletPage extends StatelessWidget {
  const WalletPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        children: [
          const Spacer(),
          CustomPaint(
            size: const Size(140, 140),
            painter: WalletPainter(),
          ),
          const SizedBox(height: 24),
          const Text(
            "GERER VOTRE ARGENT \n FACILEMENT",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
          ),
          const SizedBox(height: 12),
          const Text(
            "Envoyer et recevez votre argent en toute simplicité où que vous soyez",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 14, color: Colors.black54),
          ),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              CircleAvatar(radius: 4, backgroundColor: Colors.black),
              SizedBox(width: 8),
              CircleAvatar(radius: 4, backgroundColor: Colors.grey),
              SizedBox(width: 8),
              CircleAvatar(radius: 4, backgroundColor: Colors.grey),
            ],
          ),
          const Spacer(),
        ],
      ),
    );
  }
}

/* ---------------- PAGE 2 : TRANSFERT ---------------- */

class TransferPage extends StatelessWidget {
  const TransferPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        children: [
          const Spacer(),
          CustomPaint(
            size: const Size(140, 140),
            painter: PaperPlanePainter(),
          ),
          const SizedBox(height: 24),
          const Text(
            "TRANSFERT INSTANTANÉS",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w900),
          ),
          const SizedBox(height: 12),
          const Text(
            "Envoyer de l’argent à vos proches\nen quelques secondes seulement",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 14, color: Colors.black54),
          ),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              CircleAvatar(radius: 4, backgroundColor: Colors.grey),
              SizedBox(width: 8),
              CircleAvatar(radius: 4, backgroundColor: Colors.black),
              SizedBox(width: 8),
              CircleAvatar(radius: 4, backgroundColor: Colors.grey),
            ],
          ),
          const Spacer(),
        ],
      ),
    );
  }
}

/* ---------------- PAGE 3 : SÉCURITÉ ---------------- */

class SecurityPage extends StatelessWidget {
  const SecurityPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        children: [
          const Spacer(),
          CustomPaint(
            size: const Size(140, 140),
            painter: ShieldPainter(),
          ),
          const SizedBox(height: 24),
          const Text(
            "SÉCURITÉ MAXIMALE",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w900),
          ),
          const SizedBox(height: 12),
          const Text(
            "Vos transactions sont protégées par\nles dernières technologies de sécurité.",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 14, color: Colors.black54),
          ),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              CircleAvatar(radius: 4, backgroundColor: Colors.grey),
              SizedBox(width: 8),
              CircleAvatar(radius: 4, backgroundColor: Colors.grey),
              SizedBox(width: 8),
              CircleAvatar(radius: 4, backgroundColor: Colors.black),
            ],
          ),
          const Spacer(),
        ],
      ),
    );
  }
}

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _controller = PageController();
  int _currentPage = 0;

  final List<Map<String, String>> _onboardingData = [
    {
      "title": "Gerer votre argent",
      "desc":
          "Envoyer et recevez votre argent en toute simplicité où que vous soyez.",
    },
    {
      "title": "Transfert instantanés",
      "desc":
          "Envoyer de l’argent à vos proches en quelques secondes seulement.",
    },
    {
      "title": "sécurité maximale",
      "desc":
          "Vos transactions sont protégés par les dernières technologies de sécurité.",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: PageView.builder(
              controller: _controller,
              onPageChanged: (value) => setState(() => _currentPage = value),
              itemCount: _onboardingData.length,
              itemBuilder: (context, index) => _buildSlide(index),
            ),
          ),
          _buildBottomControls(),
        ],
      ),
    );
  }

  Widget _buildSlide(int index) {
    return Padding(
      padding: const EdgeInsets.all(40.0), // Padding standard [cite: 49]
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.wallet, size: 100, color: Colors.blue),
          const SizedBox(height: 40),
          Text(
            _onboardingData[index]["title"]!,
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),
          Text(
            _onboardingData[index]["desc"]!,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 16, color: Colors.grey),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomControls() {
    return Padding(
      padding: const EdgeInsets.all(30.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          TextButton(
            onPressed: () => Navigator.pushReplacementNamed(context, '/login'),
            child: const Text("Passer"),
          ),
          ElevatedButton(
            onPressed: () {
              if (_currentPage == 2) {
                Navigator.pushReplacementNamed(context, '/login');
              } else {
                _controller.nextPage(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeIn,
                );
              }
            },
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: Text(_currentPage == 2 ? "Commencer" : "Suivant"),
          ),
        ],
      ),
    );
  }
}
