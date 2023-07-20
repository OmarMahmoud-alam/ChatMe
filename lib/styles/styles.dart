import 'package:flutter/material.dart';
import 'package:project3/module/user.dart';

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
  static int appid = 1046346516;
  static String appSign =
      '6073a55b1ebaaddeac45a4823d65231e461d6c1a4d6b0e6d3415d95c121630b7';
  static SocialUserModel? meuser;
}
