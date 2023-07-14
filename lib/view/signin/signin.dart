import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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

class CustomBottomappbar extends StatelessWidget {
  const CustomBottomappbar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const BottomAppBar(
        notchMargin: 5.0,
        child: SizedBox(
          height: 70,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              BottomAppBaritem(
                icon: Icon(Icons.home),
                label: 'Home',
              ),
              BottomAppBaritem(
                icon: Icon(Icons.info),
                label: 'About',
              ),
              BottomAppBaritem(
                icon: Icon(Icons.business),
                label: 'Services',
              ),
              BottomAppBaritem(
                icon: Icon(Icons.contact_mail),
                label: 'Contact',
              ),
            ],
          ),
        ));
  }
}

class BottomAppBaritem extends StatelessWidget {
  const BottomAppBaritem({
    super.key,
    required this.label,
    required this.icon,
  });
  final String label;
  final Icon icon;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Column(children: [
        icon,
        const Text('Home'),
      ]),
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
    final TextEditingController controlle = TextEditingController();
    final TextEditingController controlle2 = TextEditingController();

    /*AlertDialog alert2 = AlertDialog(
      title: Text("My title"),
      content: Text("enter the sms"),
      actions: [
        inputdata(controller: controlle2),
        ElevatedButton(
            onPressed: () async {
              provider.sendcode(controlle2.text);
            },
            child: Text('entered the code')),
      ],
    );*/
    /* AlertDialog alert = AlertDialog(
      title: Text("My title"),
      content: Text("enter the phone number"),
      actions: [
        inputdata(controller: controlle),
        ElevatedButton(
            onPressed: () async {
              provider.phone_autho("+2${controlle.text}");
              Navigator.of(context).pop();
             showDialog(
                context: context,
                builder: (BuildContext context) {
                  return alert2;
                },
              );
            },
            child: Text('sign in')),
      ],
    );*/

    return AutofillGroup(
      child: Form(
        key: formKey,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              inputdata(
                controller: provider.emailcontroller,
                autofillHint: const [AutofillHints.email],
                label: 'email',
                validation: (s) {
                  return provider.email_validation(s!);
                },
                textInputAction: TextInputAction.next,
              ),
              const SizedBox(height: 16),
              inputdata(
                onEditingComplete: () => TextInput.finishAutofillContext(),
                controller: provider.passwordcontroller,
                autofillHint: const [AutofillHints.password],
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
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    child: IconButton(
                      onPressed: () {
                        provider.google_SignIn(context);
                      },
                      icon: const GoogleLogo(size: 200),
                    ),
                  ),
                  const SizedBox(
                    width: 7,
                  ),
                ],
              ),
              SizedBox(
                height: 7,
              ),
              IconButton(
                  onPressed: () {
                    /*showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return alert;
                      },
                    );*/
                  },
                  icon: Icon(Icons.phone_android)),
              SizedBox(
                height: 7,
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
      ),
    );
  }
}
 /*floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.add_a_photo),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked2,
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.blueGrey,
        currentIndex: 1,
        onTap: (int index) {},
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.info),
            label: 'About',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.business),
            label: 'Services',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.contact_mail),
            label: 'Contact',
          ),
        ],
      ),*/