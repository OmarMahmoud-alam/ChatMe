// Flutter imports:
/*
import 'package:flutter/material.dart';
import 'package:project3/module/user.dart';
import 'package:project3/view/chat%20details/mainchat.dart';
import 'package:project3/view/chat/personchat.dart';
import 'package:project3/view/signin/emailsign.dart';

// Project imports:

class PageRouteNames {
  static const String login = '/login';
  static const String home = '/home_page';
  static const String chatwith = '/chatwith';
}

const TextStyle textStyle = TextStyle(
  color: Colors.black,
  fontSize: 13.0,
  decoration: TextDecoration.none,
);

Map<String, WidgetBuilder> routes = {
  PageRouteNames.login: (context) => const email(),
  PageRouteNames.home: (context) => const HomeChat(),
  PageRouteNames.chatwith: (context) {
    final user =;
    ChatDetails(user: user);
  },
};

class UserInfo {
  String id = '';
  String name = '';

  UserInfo({
    required this.id,
    required this.name,
  });

  bool get isEmpty => id.isEmpty;

  UserInfo.empty();
}

UserInfo currentUser = UserInfo.empty();
const String cacheUserIDKey = 'cache_user_id_key';
*/