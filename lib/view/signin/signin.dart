import 'package:flutter/material.dart';
import 'package:project3/controller/signcontroller.dart';
import 'package:project3/view/signin/register.dart';
import 'package:project3/widget/googlelog.dart';
import 'package:project3/widget/sharedwidget.dart';
import 'package:project3/widget/widgets.dart';
import 'package:provider/provider.dart';

class SignIn extends StatelessWidget {
  const SignIn({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<UserProvider>(context);
    final formKey = GlobalKey<FormState>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign In'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: formInput(formKey: formKey, provider: provider),
      ),
    );
  }
}

class formInput extends StatelessWidget {
  const formInput({
    super.key,
    required this.formKey,
    required this.provider,
  });

  final GlobalKey<FormState> formKey;
  final UserProvider provider;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            inputdata(
              controller: provider.emailcontroller,
              label: 'email',
              validation: (s) {
                return provider.email_validation(s!);
              },
            ),
            const SizedBox(height: 16),
            inputdata(
              controller: provider.passwordcontroller,
              label: ' password',
              validation: (s) {
                return provider.Password_validation(s!);
              },
            ),
            const SizedBox(height: 16),
            Center(
              child: Container(
                width: 100,
                // padding: EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                    borderRadius: (BorderRadius.circular(100.0))),
                child: ElevatedButton(
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                        side: const BorderSide(
                            width: 1,
                            color: Color.fromARGB(255, 201, 76, 76)),
                      ),
                    ),
                  ),
                  child: const Text('Sign In'),
                  onPressed: () => provider.formcheck(formKey),
                ),
              ),
            ),
            Center(
              child: IconButton(
                onPressed: () {
                  provider.google_SignIn(context);
                },
                icon: const GoogleLogo(size: 200),
              ),
            ),
            Center(
              child: TextButton(
                  onPressed: () {
                    navigateto(context: context, widget: const register());
                  },
                  child: const Text('i don\'t have account create one')),
            ),
          ],
        ),
      ),
    );
  }
}
