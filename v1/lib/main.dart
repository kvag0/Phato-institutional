import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:ios/core/theme/app_theme.dart';
import 'package:ios/screens/feed_screen.dart';
import 'package:ios/screens/phatobot_screen.dart';
import 'package:ios/screens/profile_screen.dart';
import 'package:ios/screens/splash_screen.dart';

// --- INSTRUÇÕES ---
// 1. Substitua o conteúdo do seu `lib/main.dart` por este código para garantir que a estrutura principal está correta.
// 2. PARE o app e EXECUTE-O NOVAMENTE do zero.

void main() {
  runApp(const PhatoApp());
}

class PhatoApp extends StatelessWidget {
  const PhatoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Phato Prototype',
      theme: AppTheme.darkTheme,
      debugShowCheckedModeBanner: false,
      home: const SplashScreen(), // A entrada do app continua sendo a Splash
    );
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    return CupertinoTabScaffold(
      tabBar: CupertinoTabBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.home),
            label: 'Feed',
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.search),
            label: 'Buscar',
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.conversation_bubble),
            label: 'PhatoBot',
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.person),
            label: 'Perfil',
          ),
        ],
      ),
      tabBuilder: (BuildContext context, int index) {
        switch (index) {
          case 0:
            return CupertinoTabView(builder: (context) => FeedScreen());
          case 1:
            return CupertinoTabView(
              builder: (context) => const PlaceholderScreen(title: 'Busca'),
            );
          case 2:
            return CupertinoTabView(
              builder: (context) => const PhatoBotScreen(),
            );
          case 3:
            return CupertinoTabView(
              builder: (context) => const ProfileScreen(),
            );
          default:
            return CupertinoTabView(builder: (context) => FeedScreen());
        }
      },
    );
  }
}

class PlaceholderScreen extends StatelessWidget {
  final String title;
  const PlaceholderScreen({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: Center(
        child: Text(
          '$title - Em Construção',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
      ),
    );
  }
}
