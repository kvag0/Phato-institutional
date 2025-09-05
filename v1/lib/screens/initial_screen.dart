import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart'; // Para a fonte Anton
import 'package:phato_mvp/services/auth_service.dart'; // Para autenticação de visitante
import 'package:phato_mvp/screens/login_screen.dart'; // Para navegar para Login
import 'package:phato_mvp/screens/registration_chat_screen.dart'; // ADICIONE ESTA LINHA

class InitialScreen extends ConsumerWidget {
  const InitialScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authService = ref.read(authServiceProvider);

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary, // Fundo amarelo Phato
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Logo "Phato"
            Text(
              'Phato',
              style: GoogleFonts.anton( // Fonte Anton
                fontSize: 80, // Tamanho grande
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.onPrimary, // Cor preta Phato
              ),
            ),
            const SizedBox(height: 100), // Espaçamento entre logo e botões

            // Botão "Criar Conta"
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.8,
              child: OutlinedButton(
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  side: BorderSide(color: Theme.of(context).colorScheme.onPrimary, width: 2),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  // Remova a linha foregroundColor: Theme.of(context).colorScheme.onPrimary, se quiser que a cor seja definida diretamente no Text
                ),
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => const RegistrationChatScreen()), // MUDE AQUI
                  );
                },
                child: Text(
                  'CRIAR CONTA',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.onPrimary, // AJUSTE AQUI: Garante que o texto seja preto Phato
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Botão "Entrar"
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.8, // 80% da largura da tela
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  backgroundColor: Theme.of(context).colorScheme.onPrimary, // Fundo preto
                  foregroundColor: Theme.of(context).colorScheme.primary, // Texto amarelo
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30), // Bordas arredondadas
                  ),
                ),
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => LoginScreen()), // Leva para a tela de login
                  );
                },
                child: Text(
                  'ENTRAR',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 32),

            // Link "Entrar como Visitante"
            TextButton(
              onPressed: () async {
                try {
                  await authService.signInAnonymously();
                  // Após o login anônimo, o AuthChecker deve redirecionar para a HomeScreen
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Erro ao entrar como visitante: ${e.toString().split('] ').last}')),
                  );
                }
              },
              child: Text(
                'Entrar como Visitante',
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: Theme.of(context).colorScheme.onPrimary.withOpacity(0.8), // Texto preto com opacidade
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