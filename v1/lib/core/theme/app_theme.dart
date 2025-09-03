import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart'; // Importação adicionada
import 'package:google_fonts/google_fonts.dart';

// --- INSTRUÇÕES ---
// Substitua o conteúdo do seu `lib/core/theme/app_theme.dart` por este código.

class AppTheme {
  static final ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    primaryColor: const Color(0xFFFFD500), // Phato Yellow
    scaffoldBackgroundColor: const Color(0xFF121212),
    cardColor: const Color(0xFF1E1E1E),

    colorScheme: const ColorScheme.dark(
      primary: Color(0xFFFFD500),
      secondary: Color(0xFF03DAC6),
      surface: Color(0xFF121212), // CORRIGIDO: de 'background' para 'surface'
      onPrimary: Colors.black,
      onSecondary: Colors.black,
      onSurface: Colors.white, // CORRIGIDO: de 'onBackground' para 'onSurface'
      onError: Colors.black,
      error: Color(0xFFCF6679),
    ),

    appBarTheme: const AppBarTheme(
      backgroundColor: Color(0xFF1E1E1E),
      elevation: 0,
      iconTheme: IconThemeData(color: Colors.white),
    ),

    textTheme: GoogleFonts.interTextTheme(
      const TextTheme(
        headlineSmall: TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
        headlineMedium: TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
        titleLarge: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        bodyMedium: TextStyle(color: Colors.white70),
        bodySmall: TextStyle(color: Colors.white54),
      ),
    ),

    cardTheme: const CardThemeData(
      // CORRIGIDO: de 'CardTheme' para 'CardThemeData'
      elevation: 2,
      color: Color(0xFF1E1E1E),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),
    ),

    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: Color(0xFF1E1E1E),
      selectedItemColor: Color(0xFFFFD500),
      unselectedItemColor: Colors.grey,
    ),

    cupertinoOverrideTheme: const CupertinoThemeData(
      // CORRIGIDO: Nome da classe
      brightness: Brightness.dark,
      primaryColor: Color(0xFFFFD500),
      barBackgroundColor: Color(0xFF1E1E1E),
      scaffoldBackgroundColor: Color(0xFF121212),
    ),
  );
}
