import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:project3/module/user.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:project3/view/home.dart';

import '../widget/sharedwidget.dart';

class UserProvider extends ChangeNotifier {
  User? user;
  String email = 'error';

  TextEditingController emailcontroller = TextEditingController();
  TextEditingController usernamecontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();
  TextEditingController passwordcontroller2 = TextEditingController();

  /*void setUser(User user) {
    _user = user;
    notifyListeners();
  }
*/
  void getCurrentUserInfo() async {
    user = auth.currentUser;
    email = user!.email.toString();
    notifyListeners();
    print('repeat alot');
    //print(user == null ? 'error' : user!.email.toString());
    toast(txt: user!.email.toString());
  }

  late final idToken;

  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore storage = FirebaseFirestore.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: <String>[
      'email',
    ],
  );

  Future<void> google_SignIn(context) async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      // toast(txt: 'sad');
      final GoogleSignInAuthentication googleAuth =
          await googleUser!.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      // makemassege(msg: 'dddd');
      try {
        final UserCredential userCredential =
            await auth.signInWithCredential(credential);
        print(userCredential.user.toString());
        getCurrentUserInfo();
        notifyListeners();
        navigateto(context: context, widget: const HomePage());
      } on FirebaseAuthException catch (e) {
        toast(txt: e.code.toString());
        if (e.code == 'user-not-found') {
          makemassege(msg: 'userNotFound');
        } else if (e.code == 'wrong-password') {
          makemassege(msg: 'wrong password');
        } else {
          makemassege(msg: e.toString());
        }
      } catch (e) {
        makemassege(msg: e.toString());
      }
      print('Signed in as ${user!.displayName} (${user!.uid})');
    } catch (e) {
      print('Error signing in with Google: $e');

      makemassege(msg: e.toString());
    }
  }

  Future<void> google_SignIn2() async {
    if (FirebaseAuth.instance.currentUser == null) {
      toast(txt: 'b1');
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      toast(txt: 'b2');
      final GoogleSignInAuthentication googleAuth =
          await googleUser!.authentication;
      toast(txt: 'b3');
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      user =
          (await FirebaseAuth.instance.signInWithCredential(credential)).user;
    } else {
      user = FirebaseAuth.instance.currentUser;
    }
  }

  void logout() async {
    try {
      await FirebaseAuth.instance.signOut();
      await _googleSignIn.signOut();
      if (auth.currentUser != null) {
        print('omar     tt- ${auth.currentUser!.email.toString()}');
      }
      clearUser();
      // Navigate to the sign in page after successful sign out
    } catch (e) {
      // Handle sign out errors, if any
      print('Error signing out: $e');
    }
  }

//check for sign in
  Future<void> formcheck(GlobalKey<FormState> formKey) async {
    //makemassege(msg: 'start');
    if (formKey.currentState!.validate()) {
      //  makemassege(msg: formKey.currentState!.toString());
      try {
        UserCredential userCredential = await auth.signInWithEmailAndPassword(
          email: emailcontroller.text,
          password: passwordcontroller.text,
        );
        print(userCredential.user!.uid);
        getCurrentUserInfo();
        notifyListeners();
        makemassege(msg: 'done');
        toast(txt: userCredential.user!.uid, color: Colors.deepOrange);
      } on FirebaseAuthException catch (e) {
        if (e.code == 'user-not-found') {
          makemassege(msg: 'userNotFound');
        } else if (e.code == 'wrong-password') {
          makemassege(msg: 'wrong password');
        }
      } catch (e) {
        makemassege(msg: e.toString());
      }
    }
  }

  void clearUser() {
    user = null;
    notifyListeners();
  }

  String? email_validation(String s) {
    //makemassege(msg: 'dasda');
    RegExp emailValid = RegExp(
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
    if (!emailValid.hasMatch(s)) {
      return 'something is wrong in email pls check again';
    }
    return null;
  }

  void usersignup(GlobalKey<FormState> formKey) {
    String email = emailcontroller.text;
    String password = passwordcontroller.text;
    if (formKey.currentState!.validate()) {
      FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((value) {
        print('done');
        toast(txt: value.user!.uid);
      }).catchError((e) {
        print(e.toString());
        toast(txt: e.toString(), color: Colors.red);
      });
      notifyListeners();
    }
  }

//put user data from firebase
  void userdata({required uid, required name, required email, required phone}) {
    SocialUserModel user1 =
        SocialUserModel(name: name, uId: uid, email: email, phone: phone);
    storage.collection('users').doc(uid).set(user1.toMap()).then((value) {
      toast(txt: 'saved');
    }).catchError((e) {
      print(e.toString());
      toast(txt: e.toString(), color: Colors.red).then((value) {
        notifyListeners();
      });
    });
  }

  String? Password_validation(String s) {
    RegExp passvalid =
        RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');
    if (s.length < 5) {
      return 'something is wrong in password pls check again';
    }
    return null;
  }

  String? age_validation(String s) {
    int? age = int.tryParse(s);

    if (age == null) {
      return 'something is wrong in password pls check again';
    } else if (age > 120 || age < 10) {
      return 'age must be in rage 10 to 120 ';
    }
    return null;
  }

  Future<void> userLogin() async {
    String email = emailcontroller.text.trim();
    String password = passwordcontroller.text.trim();
    RegExp emailValid = RegExp(
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");

    RegExp passvalid =
        RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');

    if (emailValid.hasMatch(email) && password.length > 4) {
      FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password)
          .then((value) {
        print(value.user!.uid);
      }).catchError((e) {
        print(e.toString());
      });
    } else {
      makemassege(msg: "something wrong in password or name");
    }
  }

  void makemassege({required String msg}) {
    Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0);
  }
}
