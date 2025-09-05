import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';

// Classe para centralizar o tema do aplicativo
class AppTheme {
  // Paleta de Cores Phato
  static const Color phatoYellow = Color(0xFFffbc59);
  static const Color phatoRed = Color(0xFFdc2727);
  static const Color phatoBlack = Color(0xFF0d0d0d);
  static const Color phatoGray = Color(0xFF3d3d3d);
  static const Color phatoLightGray = Color(0xFFE0E0E0);
  static const Color phatoCardGray = Color(0xFF2a2a2a);
  static const Color phatoTextGray = Color(0xFFb3b3b3);

  // Tema Cupertino
  static final CupertinoThemeData themeData = CupertinoThemeData(
    brightness: Brightness.dark,
    primaryColor: phatoYellow,
    primaryContrastingColor: phatoBlack,
    barBackgroundColor: phatoBlack,
    scaffoldBackgroundColor: phatoBlack,
    textTheme: CupertinoTextThemeData(
      textStyle: bodyTextStyle,
      actionTextStyle: GoogleFonts.quicksand(
        color: phatoYellow,
        fontSize: 17,
        fontWeight: FontWeight.w400,
      ),
      navTitleTextStyle: logoStyle,
      navLargeTitleTextStyle: headlineStyle.copyWith(fontSize: 34),
    ),
  );

  // Estilos de Texto reutilizáveis
  static final TextStyle logoStyle = GoogleFonts.leagueSpartan(
    color: phatoLightGray,
    fontSize: 24,
    fontWeight: FontWeight.bold,
  );

  static final TextStyle headlineStyle = GoogleFonts.leagueSpartan(
    color: phatoLightGray,
    fontSize: 28,
    fontWeight: FontWeight.w600,
  );

  static final TextStyle bodyTextStyle = GoogleFonts.quicksand(
    color: phatoLightGray,
    fontSize: 16,
    fontWeight: FontWeight.w400,
  );

  static final TextStyle secondaryTextStyle = GoogleFonts.quicksand(
    color: phatoTextGray,
    fontSize: 15,
    fontWeight: FontWeight.w400,
  );
}
