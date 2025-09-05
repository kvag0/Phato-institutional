import 'package:flutter/cupertino.dart';
import 'package:phato_prototype/core/theme/app_theme.dart';
import 'package:phato_prototype/screens/home_screen.dart';
import 'package:phato_prototype/screens/login_screen.dart';
import 'package:phato_prototype/screens/registration_chat_screen.dart';
import 'package:phato_prototype/screens/splash_screen.dart';

void main() {
  runApp(const PhatoApp());
}

class PhatoApp extends StatelessWidget {
  const PhatoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      title: 'Phato News App',
      theme: AppTheme.themeData,
      home: const SplashScreen(),
      routes: {
        '/home': (context) => const HomeScreen(),
        '/register': (context) => const RegistrationChatScreen(),
        '/login': (context) => const LoginScreen(),
      },
    );
  }
}
