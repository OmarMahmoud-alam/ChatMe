import 'package:flutter/material.dart';
import 'package:project3/controller/signcontroller.dart';
import 'package:project3/view/signin/signin.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<UserProvider>(context);

    return Scaffold(
      body: SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(provider.email),
            const SizedBox(
              height: 10,
            ),
            ElevatedButton(
                onPressed: () {
                  provider.logout();
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (BuildContext context) => const SignIn()));
                },
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.red)),
                child: const Text('log out'))
          ],
        ),
      ),
      //  body: Center(child: Text('error')),
    );
  }
}
