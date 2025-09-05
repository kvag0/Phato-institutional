import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
/* import 'package:phato_mvp/screens/registration_chat_screen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'firebase_options.dart';
import 'screens/home_screen.dart';
import 'screens/login_screen.dart';
import 'screens/auth_checker.dart';
import 'screens/splash_screen.dart'; */

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    const ProviderScope(
      child: PhatoApp(),
    ),
  );
}

class PhatoApp extends StatelessWidget {
  const PhatoApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Definição da Paleta de Cores do Phato
    const Color phatoYellow = Color(0xFFffbc59);
    // const Color phatoDarkBlue = Color(0xFF011627); // REMOVIDO: Variável não utilizada
    const Color phatoRed = Color(0xFFdc2727);
    const Color phatoBlack = Color(0xFF0d0d0d);
    const Color phatoGray = Color(0xFF3d3d3d);
    const Color phatoLightGray = Color(0xFFE0E0E0);

    return MaterialApp(
      title: 'Phato News App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        primaryColor: phatoYellow,
        canvasColor: phatoBlack,
        scaffoldBackgroundColor: phatoBlack,
        brightness: Brightness.dark,

        appBarTheme: const AppBarTheme(
          color: phatoBlack,
          elevation: 0,
          foregroundColor: phatoLightGray,
          centerTitle: true,
        ),

        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          backgroundColor: phatoBlack,
          selectedItemColor: phatoYellow,
          unselectedItemColor: phatoGray,
          type: BottomNavigationBarType.fixed,
          elevation: 0,
        ),

        // AJUSTE: CardTheme para CardThemeData
        cardTheme: CardThemeData(
          // MUDADO: CardTheme para CardThemeData
          color: phatoGray,
          elevation: 3,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),

        textTheme: TextTheme(
          displayLarge: GoogleFonts.leagueSpartan(
              fontSize: 96, fontWeight: FontWeight.w300, color: phatoLightGray),
          displayMedium: GoogleFonts.leagueSpartan(
              fontSize: 60, fontWeight: FontWeight.w300, color: phatoLightGray),
          displaySmall: GoogleFonts.leagueSpartan(
              fontSize: 48, fontWeight: FontWeight.w400, color: phatoLightGray),
          headlineMedium: GoogleFonts.leagueSpartan(
              fontSize: 34, fontWeight: FontWeight.w400, color: phatoLightGray),
          headlineSmall: GoogleFonts.leagueSpartan(
              fontSize: 24, fontWeight: FontWeight.w400, color: phatoLightGray),
          titleLarge: GoogleFonts.leagueSpartan(
              fontSize: 20, fontWeight: FontWeight.w500, color: phatoLightGray),
          bodyLarge: GoogleFonts.quicksand(
              fontSize: 16, fontWeight: FontWeight.w400, color: phatoLightGray),
          bodyMedium: GoogleFonts.quicksand(
              fontSize: 14, fontWeight: FontWeight.w400, color: phatoLightGray),
          labelLarge: GoogleFonts.quicksand(
              fontSize: 14, fontWeight: FontWeight.w500, color: phatoLightGray),
          bodySmall: GoogleFonts.quicksand(
              fontSize: 12, fontWeight: FontWeight.w400, color: phatoLightGray),
        ),

        visualDensity: VisualDensity.adaptivePlatformDensity,
        colorScheme:
            ColorScheme.fromSwatch(primarySwatch: Colors.blue).copyWith(
          primary: phatoYellow,
          secondary: phatoRed,
          surface: phatoBlack, // AJUSTE: background mudado para surface
          onPrimary: phatoBlack,
          onSecondary: Colors.white,
          onSurface:
              phatoLightGray, // AJUSTE: onBackground mudado para onSurface
          brightness: Brightness.dark, // ADICIONE ESTA LINHA AQUI
        ),
      ),
      home: const SplashScreen(),
      routes: {
        '/home': (context) => HomeScreen(),
        '/register': (context) => RegistrationChatScreen(),
        '/login': (context) => LoginScreen(),
      },
    );
  }
}
