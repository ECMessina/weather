import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SigColors {
  static const darkTheme = Colors.blue;
  static const medTheme = Color.fromARGB(255, 100, 181, 246);
  static const lightTheme = Color.fromARGB(255, 187, 222, 251);
}

class TextStyles {
  static final mainTextStyle = GoogleFonts.merriweather(
    color: SigColors.darkTheme,
    fontSize: 25,
    fontWeight: FontWeight.bold,
  );
}
