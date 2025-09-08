import 'package:flutter/cupertino.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'core/theme/app_theme.dart';
import 'screens/home_screen.dart';
import 'screens/login_screen.dart';
import 'screens/registration_chat_screen.dart';
import 'screens/splash_screen.dart';

void main() async {
  // Garante que os widgets Flutter estão prontos antes de executar a app.
  WidgetsFlutterBinding.ensureInitialized();
  // Inicializa a formatação de datas para Português (Brasil).
  await initializeDateFormatting('pt_BR', null);

  runApp(const PhatoApp());
}

class PhatoApp extends StatelessWidget {
  const PhatoApp({super.key});

  @override
  Widget build(BuildContext context) {
    // (CORRIGIDO) Substituído MaterialApp por CupertinoApp para consistência.
    return CupertinoApp(
      title: 'Phato App Prototype',
      // Aplica o nosso tema Cupertino personalizado.
      theme: AppTheme.cupertinoTheme,
      // A tela inicial da aplicação.
      home: const SplashScreen(),
      // Define as rotas nomeadas para navegação.
      routes: {
        '/home': (context) => const HomeScreen(),
        '/register': (context) => const RegistrationChatScreen(),
        '/login': (context) => const LoginScreen(),
      },
    );
  }
}
