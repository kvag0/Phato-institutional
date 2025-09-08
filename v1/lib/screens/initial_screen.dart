import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:phato_prototype/core/theme/app_theme.dart';
import 'package:phato_prototype/screens/home_screen.dart';
import 'package:phato_prototype/screens/login_screen.dart';
import 'package:phato_prototype/screens/registration_chat_screen.dart';

class InitialScreen extends StatelessWidget {
  const InitialScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: AppTheme.phatoYellow, // Fundo amarelo Phato
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Logo "Phato"
            Text(
              'Phato.',
              style: GoogleFonts.anton(
                fontSize: 80,
                fontWeight: FontWeight.bold,
                color: AppTheme.phatoBlack,
              ),
            ),
            const SizedBox(height: 100),

            // Botão "Criar Conta"
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.8,
              child: CupertinoButton(
                color: AppTheme.phatoYellow,
                onPressed: () {
                  Navigator.of(context).push(
                    CupertinoPageRoute(
                        builder: (context) => const RegistrationChatScreen()),
                  );
                },
                child: Text(
                  'CRIAR CONTA',
                  style: AppTheme.bodyTextStyle.copyWith(
                    fontWeight: FontWeight.bold,
                    color: AppTheme.phatoBlack,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Botão "Entrar"
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.8,
              child: CupertinoButton(
                color: AppTheme.phatoBlack,
                onPressed: () {
                  Navigator.of(context).push(
                    CupertinoPageRoute(
                        builder: (context) => const LoginScreen()),
                  );
                },
                child: Text('ENTRAR', style: AppTheme.headlineStyle),
              ),
            ),
            const SizedBox(height: 32),

            // Link "Entrar como Visitante"
            CupertinoButton(
              onPressed: () {
                // Navega diretamente para a home
                Navigator.of(context).pushReplacement(
                  CupertinoPageRoute(builder: (context) => const HomeScreen()),
                );
              },
              child: Text(
                'Entrar como Visitante',
                style: AppTheme.bodyTextStyle.copyWith(
                  color: AppTheme.phatoBlack.withOpacity(0.8),
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
