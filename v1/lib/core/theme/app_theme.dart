import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';

// Classe estática para centralizar todas as constantes de tema da aplicação.
class AppTheme {
  // Cores Primárias
  static const Color phatoYellow = Color(0xFFffbc59);
  static const Color phatoBlack = Color(0xFF0d0d0d);
  static const Color phatoGray = Color(0xFF3d3d3d);
  static const Color phatoCardGray = Color(0xFF2a2a2a);
  static const Color phatoLightGray = Color(0xFFE0E0E0);
  static const Color phatoTextGray = Color(0xFFa3a3a3);

  // Estilos de Texto Principais
  static final TextStyle logoStyle = GoogleFonts.anton(
    fontSize: 24,
    fontWeight: FontWeight.w400,
    color: phatoYellow,
  );

  static final TextStyle headlineStyle = GoogleFonts.leagueSpartan(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    color: phatoLightGray,
  );

  static final TextStyle greetingStyle = GoogleFonts.leagueSpartan(
    fontSize: 28,
    fontWeight: FontWeight.bold,
    color: phatoLightGray,
  );

  static final TextStyle bodyTextStyle = GoogleFonts.quicksand(
    fontSize: 16,
    fontWeight: FontWeight.w500,
    color: phatoLightGray,
  );

  static final TextStyle secondaryTextStyle = GoogleFonts.quicksand(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: phatoTextGray,
  );

  // Tema Cupertino para toda a aplicação.
  static final CupertinoThemeData cupertinoTheme = CupertinoThemeData(
    brightness: Brightness.dark,
    primaryColor: phatoYellow,
    scaffoldBackgroundColor: phatoBlack,
    barBackgroundColor: phatoBlack,
    textTheme: CupertinoTextThemeData(
      primaryColor: phatoYellow,
      textStyle: bodyTextStyle,
      navTitleTextStyle: headlineStyle.copyWith(fontSize: 18),
      navLargeTitleTextStyle: headlineStyle,
      pickerTextStyle: bodyTextStyle,
      dateTimePickerTextStyle: bodyTextStyle,
    ),
  );
}
