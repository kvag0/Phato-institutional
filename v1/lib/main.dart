import 'package:flutter/cupertino.dart';
import 'package:phato_prototype/core/theme/app_theme.dart';
import 'package:phato_prototype/screens/splash_screen.dart';
import 'package:intl/date_symbol_data_local.dart'; // 1. Importe o pacote de inicialização

void main() async {
  // 2. Transforme o main em assíncrono
  WidgetsFlutterBinding
      .ensureInitialized(); // Garante que o Flutter está pronto
  await initializeDateFormatting(
      'pt_BR', null); // 3. Inicialize os dados de local para pt_BR

  runApp(const PhatoApp());
}

class PhatoApp extends StatelessWidget {
  const PhatoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      title: 'Phato News Prototype',
      theme: AppTheme.themeData,
      home: const SplashScreen(),
    );
  }
}
