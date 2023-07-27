import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:project3/controller/signcontroller.dart';
import 'package:project3/styles/styles.dart';
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

    return Center(
      child: Form(
        key: formKey,
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Log in'.toUpperCase(),
                  style: Theme.of(context)
                      .textTheme
                      .headline3!
                      .copyWith(fontWeight: FontWeight.bold, fontSize: 40.0),
                ),
                const SizedBox(
                  height: 10.0,
                ),
                Text(
                  'Log in to our browser the hot offers ',
                  style: Theme.of(context)
                      .textTheme
                      .headline3!
                      .copyWith(fontSize: 20.0),
                ),
                const SizedBox(
                  height: 30.0,
                ),
                defaultFormField(
                  controller: provider.emailcontroller,
                  label: 'email',
                  prefix: const Icon(Icons.email_outlined),
                  validate: (s) {
                    return provider.email_validation(s!);
                  },
                  type: TextInputType.text,
                ),
                const SizedBox(height: 16),
                defaultFormField(
                  controller: provider.passwordcontroller,
                  label: ' password',
                  validate: (s) {
                    return provider.Password_validation(s!);
                  },
                  isPassword: provider.ispassword,
                  prefix: const Icon(Icons.lock_outline),
                  suffix: provider.ispassword
                      ? Icons.visibility_outlined
                      : Icons.visibility_off_outlined,
                  suffixPressed: provider.changevisiblepassword,
                  type: TextInputType.visiblePassword,
                ),
                const SizedBox(height: 20),
                DefaultButton(
                    function: () {
                      provider.formcheck(formKey);
                    },
                    text: 'LOG IN'),
                /* Center(
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
                ),*/
                /*  Row(
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
                ),*/

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Don\'t have an account?'),
                    TextButton(
                        onPressed: () {
                          navigateto(
                              context: context, widget: const register());
                        },
                        child: const Text('Registe now'))
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        height: 2,
                        color: Style.bordercolor,
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.0),
                      child: Text(
                        'Or',
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        height: 2,
                        color: Style.bordercolor,
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  width: 20,
                ),
                /* OutlinedButton.icon(
                  onPressed: () => provider.google_SignIn(context),
                  icon: const Icon(Icons.login, color: Colors.red),
                  label: const Text(
                    'Sign in with Google',
                    style: TextStyle(
                      color: Colors.red,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
             */
                const SizedBox(
                  height: 10,
                ),
                Center(
                  child: OutlinedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.white),
                      shape: MaterialStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(40),
                        ),
                      ),
                    ),
                    onPressed: () => provider.google_SignIn(context),
                    child: const Padding(
                      padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          GoogleLogo(
                            size: 20,
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 10),
                            child: Text(
                              'Sign in with Google',
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.black54,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
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