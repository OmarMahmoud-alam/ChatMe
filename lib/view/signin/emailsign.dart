import 'package:flutter/material.dart';
import 'package:project3/controller/signcontroller.dart';
import 'package:project3/view/chat%20details/mainchat.dart';
import 'package:project3/view/signin/signin.dart';
import 'package:provider/provider.dart';

class email extends StatelessWidget {
  const email({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<UserProvider>(context);

    provider.getCurrentUserInfo();
    if (provider.user != null) {
      return const HomeChat();
    } else {
      // If the user is not signed in, show the sign in page
      return const SignIn();
    }
  }
}
