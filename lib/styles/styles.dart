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

  static TextStyle headertexttheme = const TextStyle(
      fontSize: 18,
      fontFamily: 'Mulish',
      fontStyle: FontStyle.normal,
      color: Colors.black,
      fontWeight: FontWeight.bold);
  static TextStyle nametext = const TextStyle(
      fontSize: 16,
      fontFamily: 'Mulish',
      fontStyle: FontStyle.normal,
      color: Colors.black,
      fontWeight: FontWeight.bold);
  static TextStyle timetext = const TextStyle(
      fontSize: 12,
      fontFamily: 'Mulish',
      fontStyle: FontStyle.normal,
      color: Colors.black,
      fontWeight: FontWeight.bold);
  static String grey = "#F7F7FC";
  static String white = "#FFFFFF";
  static String moregrey = "#ADB5BD";
  static final Color bordercolor = Color(intconverter(moregrey));
  static final Color whitecolor = Color(intconverter(white));
  static final Color messagegrey = Color(intconverter(grey));
  static final TextStyle masege = TextStyle(
      fontSize: 12,
      fontFamily: 'Mulish',
      fontStyle: FontStyle.normal,
      color: bordercolor,
      fontWeight: FontWeight.bold);

  static BoxDecoration f42Rwhitebold =
      BoxDecoration(borderRadius: BorderRadius.circular(8), color: textColor);

  static int intconverter(String hexColor) {
    return int.parse(hexColor.substring(1, 7), radix: 16) + 0xFF000000;
  }
}

class Comman {
  static String knodebox = 'Nodes';
  static String CALL_COLLECTION = 'call';
  static const appid = "bce4506496e44fd6966eff0c2ad0d9fc";
  static const token =
      "007eJxTYEheu23L67h68dM2DuV9GafzH+mbaAsazDp2dvvJol06dwoUGJKSU01MDcxMLM1STUzSUswszcxS09IMko0SUwxSLNOSfbQ2pDQEMjK8uyjFyMgAgSA+K0NRfn6uIQMDALiMIOg=";
}
