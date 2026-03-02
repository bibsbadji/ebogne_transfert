import 'package:flutter/material.dart';

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
