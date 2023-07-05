import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:project3/controller/signcontroller.dart';
import 'package:project3/view/home.dart';
import 'package:project3/view/signin/register.dart';
import 'package:project3/widget/sharedwidget.dart';
import 'package:project3/view/signin/signin.dart';
import 'package:provider/provider.dart';

class email extends StatelessWidget {
  const email({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<UserProvider>(context);

    provider.getCurrentUserInfo();
    if (provider.user != null) {
      provider.getCurrentUserInfo();
      return HomePage();
    } else {
      // If the user is not signed in, show the sign in page
      return SignIn();
    }
  }
}
