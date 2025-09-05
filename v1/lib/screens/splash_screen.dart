import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:phato_mvp/screens/auth_checker.dart'; // Importe o AuthChecker

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2), // Duração da animação
    );

    // Animação de opacidade para um fade-in
    _animation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeIn,
      ),
    );

    _controller.forward(); // Inicia a animação

    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        // Quando a animação terminar, navega para a tela principal (AuthChecker)
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const AuthChecker()),
        );
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose(); // Libera o controller da animação
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor, // Fundo preto do app
      body: Center(
        child: FadeTransition( // Aplica a animação de fade-in
          opacity: _animation,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Phato',
                style: GoogleFonts.anton(
                  fontSize: 60, // Tamanho maior para o logo no splash
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.primary, // Amarelo Phato
                ),
              ),
              const SizedBox(height: 16),
              CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Theme.of(context).colorScheme.primary), // Cor do spinner
              ),
            ],
          ),
        ),
      ),
    );
  }
}