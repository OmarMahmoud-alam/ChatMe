import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:project3/controller/signcontroller.dart';
import 'package:project3/view/home.dart';
import 'package:project3/widget/register.dart';
import 'package:project3/widget/sharedwidget.dart';
import 'package:project3/widget/signin.dart';
import 'package:provider/provider.dart';

class email extends StatelessWidget {
  const email({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<UserProvider>(context);

    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (BuildContext context, AsyncSnapshot<User?> snapshot) {
          if (User == null) {
            print(
                'dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd');
            return SignIn();
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            // Show a loading spinner if the stream is not ready yet
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasData) {
            provider.getCurrentUserInfo();
            // If the user is signed in, show the home page
            return HomePage();
          } else {
            // If the user is not signed in, show the sign in page
            return SignIn();
          }
        },
      ),
    );
  }
}
