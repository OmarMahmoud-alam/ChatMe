import 'package:flutter/material.dart';
import 'package:project3/module/user.dart';
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';
import 'package:zego_uikit_signaling_plugin/zego_uikit_signaling_plugin.dart';
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
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
   // static ZegoUIKitPrebuiltCallInvitationService().setNavigatorKey(navigatorKey);

static const appid=1046346516;
static const appSign='6073a55b1ebaaddeac45a4823d65231e461d6c1a4d6b0e6d3415d95c121630b7';
  /// 1.1.2: set navigator key to ZegoUIKitPrebuiltCallInvitationService
void onUserLogin(SocialUserModel currentUser) {
  /// 1.2.1. initialized ZegoUIKitPrebuiltCallInvitationService
  /// when app's user is logged in or re-logged in
  /// We recommend calling this method as soon as the user logs in to your app.
  ZegoUIKitPrebuiltCallInvitationService().init(
    appID:  appid,
    appSign:  appSign,
    userID: currentUser.uId,
    userName: currentUser.name??'anayonmus',
    plugins: [ZegoUIKitSignalingPlugin()],
  );
}

/// on App's user logout
void onUserLogout() {
  /// 1.2.2. de-initialization ZegoUIKitPrebuiltCallInvitationService
  /// when app's user is logged out
  ZegoUIKitPrebuiltCallInvitationService().uninit();
}
}
