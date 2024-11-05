import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ThemeDataCustom {
  ThemeData light() {
    final baseTheme = ThemeData(
      brightness: Brightness.light,
      colorScheme: ColorScheme.fromSeed(
        seedColor: const Color(0xFF004a97),
      ).copyWith(
        primary: const Color(0xFF004a97),
        brightness: Brightness.light,
      ),
      useMaterial3: true,
    );

    return baseTheme.copyWith(
      textTheme: GoogleFonts.poppinsTextTheme(baseTheme.textTheme),
    );
  }

  ThemeData dark() {
    final baseTheme = ThemeData(
      brightness: Brightness.dark,
      colorScheme: ColorScheme.fromSeed(
        seedColor: const Color.fromARGB(255, 0, 102, 211),
        brightness: Brightness.dark,
      ).copyWith(
        primary: const Color.fromARGB(255, 0, 102, 211),
      ),
      useMaterial3: true,
    );

    return baseTheme.copyWith(
      textTheme: GoogleFonts.poppinsTextTheme(baseTheme.textTheme),
    );
  }
}
