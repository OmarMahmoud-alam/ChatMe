import 'package:flutter/material.dart';

class Style {
  static Color textColor = const Color(0xFF222939);

  static const height25 = SizedBox(
    height: 25,
  );

  static String logo = 'assets/images/logo.png';

  static TextStyle f14blackLetterSpacing2 = TextStyle(
      fontSize: 14, fontFamily: 'Poppins', color: textColor, letterSpacing: 2);

  static TextStyle f16white =
      const TextStyle(color: Colors.white, fontFamily: 'Poppins', fontSize: 16);

  static TextStyle f24whitebold = const TextStyle(
      fontSize: 24,
      fontFamily: 'Poppins',
      color: Colors.white,
      fontWeight: FontWeight.bold);

  static BoxDecoration f42Rwhitebold =
      BoxDecoration(borderRadius: BorderRadius.circular(8), color: textColor);
}

class Comman {
  static String knodebox = 'Nodes';
}
