import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:project3/controller/signcontroller.dart';
import 'package:project3/widget/sharedwidget.dart';
import 'package:project3/view/signin/signin.dart';
import 'package:project3/widget/widgets.dart';
import 'package:provider/provider.dart';

class register extends StatelessWidget {
  register({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<UserProvider>(context);
    final formKey = GlobalKey<FormState>();

    return Scaffold(
      appBar: AppBar(
        title: Text('register'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Form(
          key: formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                inputdata(
                  Controller: provider.usernamecontroller,
                  label: 'UserName',
                  validation: (s) {
                    if (s!.isEmpty || s == null) {
                      return 'Username can\'t be empty';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                inputdata(
                  Controller: provider.emailcontroller,
                  label: 'email',
                  validation: (s) {
                    return provider.email_validation(s!);
                  },
                ),
                const SizedBox(height: 16),
                inputdata(
                  Controller: provider.passwordcontroller,
                  label: ' password',
                  validation: (s) {
                    return provider.Password_validation(s!);
                  },
                ),
                const SizedBox(height: 16),
                inputdata(
                  Controller: provider.passwordcontroller2,
                  label: ' password',
                  validation: (s) {
                    if (provider.passwordcontroller.text != s) {
                      return 'two password must be same';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                /*   inputdata(
                  Controller: provider.passwordcontroller,
                  label: ' phone',
                  validation: (s) {
                    return provider.Password_verificaton(s!);
                  },
                ),
                const SizedBox(height: 16),
                */
                /*  inputdata(
                  Controller: provider.passwordcontroller,
                  label: ' age',
                  validation: (s) {
                    return provider.age_verificaton(s!);
                  },
                ),
              */
                SizedBox(height: 16),
                Center(
                  child: Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                        borderRadius: (BorderRadius.circular(100.0))),
                    child: ElevatedButton(
                      style: ButtonStyle(
                        shape: MaterialStateProperty.all(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5.0),
                            side: BorderSide(
                                width: 1,
                                color: Color.fromARGB(255, 201, 76, 76)),
                          ),
                        ),
                      ),
                      child: Text('registe '),
                      onPressed: () => provider.usersignup(formKey),
                    ),
                  ),
                ),
                Center(
                  child: TextButton(
                      onPressed: () {
                        navigateto(context: context, widget: SignIn());
                      },
                      child: Text('have already account')),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
