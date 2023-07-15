import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:project3/controller/zegoconfig.dart';
import 'package:project3/module/user.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:project3/view/chat%20details/mainchat.dart';
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';

import '../widget/sharedwidget.dart';

class UserProvider extends ChangeNotifier {
  User? user;
  SocialUserModel? meAsUser;

  int eee = 0;
  String email = 'error';
  final db = FirebaseFirestore.instance;
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController usernamecontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();
  TextEditingController passwordcontroller2 = TextEditingController();

  ZegoUIKitPrebuiltCallController? callController;

  void getCurrentUserInfo() async {
    user = auth.currentUser;
    email = user!.email.toString();

    FirebaseFirestore.instance
        .collection('users')
        .where("uId", isEqualTo: user!.uid)
        .get()
        .then((value) {
      if (value.docs.isEmpty) {
        log('errorin getCurrentUserInfo line 74');
      } else {
        meAsUser = SocialUserModel.fromJson(value.docs[0].data());
      }
    }).catchError((e) {
      toast(txt: 'is empty $e');
      log('is empty   $e');
    });

    meAsUser = SocialUserModel(
        uId: user!.uid,
        name: user!.displayName,
        email: user!.email,
        phone: user!.phoneNumber);

    onUserLogin(meAsUser!);
    //log('repeat alot ${++eee}');
    //log(user == null ? 'error' : user!.email.toString());
    //toast(txt: user!.email.toString());
  }

  //late final idToken;

  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore storage = FirebaseFirestore.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: <String>[
      'email',
      'https://www.googleapis.com/auth/contacts.readonly'
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
        // log(userCredential.user.toString());

        getCurrentUserInfo();
        adduserdata(
            email: userCredential.user!.email, uId: userCredential.user!.uid);
        notifyListeners();
        navigateto(context: context, widget: const HomeChat());
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
      log('Signed in as ${user!.displayName} (${user!.uid})');
    } catch (e) {
      log('Error signing in with Google: $e');

      makemassege(msg: e.toString());
    }
  }

  void logout() async {
    try {
      await FirebaseAuth.instance.signOut();
      await _googleSignIn.signOut();

      if (auth.currentUser != null) {
        log('omar     tt- ${auth.currentUser!.email.toString()}');
      }
      clearUser();
      // Navigate to the sign in page after successful sign out
    } catch (e) {
      // Handle sign out errors, if any
      log('Error signing out: $e');
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
        log(userCredential.user!.uid);
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

  void usersignup(context, GlobalKey<FormState> formKey) {
    String email = emailcontroller.text;
    String password = passwordcontroller.text;
    if (formKey.currentState!.validate()) {
      FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((value) {
        log('done');
        toast(txt: value.user!.uid);
        adduserdata(
            uId: value.user!.uid,
            name: usernamecontroller.text,
            email: value.user!.email,
            phone: value.user!.phoneNumber);
        navigateto(context: context, widget: const HomeChat());
      }).catchError((e) {
        log(e.toString());
        toast(txt: e.toString(), color: Colors.red);
      });
      notifyListeners();
    }
  }

//put user data from firebase
  void adduserdata(
      {required uId, name = "omar", required email, phone = "01021212121"}) {
    FirebaseFirestore.instance
        .collection('users')
        .where("uId", isEqualTo: uId)
        .get()
        .then((value) {
      if (value.docs.isEmpty) {
        //toast(txt: 'is empty');
        log('is empty');
        adduser(uId: uId, name: name, email: email, phone: phone);
      }
    }).catchError((e) {
      toast(txt: 'is empty $e');
      log('is empty   $e');
    });
  }

  void adduser({required uId, required name, required email, required phone}) {
    SocialUserModel user1 =
        SocialUserModel(name: name, uId: uId, email: email, phone: phone);

    storage.collection('users').doc(uId).set(user1.toMap()).then((value) {
      //   toast(txt: 'Done');
      notifyListeners();
    }).catchError((e) {
      // log(e.toString());
      toast(txt: e.toString(), color: Colors.red).then((value) {
        //notifyListeners();
      });
    });
  }

  String? Password_validation(String s) {
    /*RegExp passvalid =
        RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');*/
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

    if (emailValid.hasMatch(email) && password.length > 4) {
      FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password)
          .then((value) {
        // log(value.user!.uid);
      }).catchError((e) {
        log(e.toString());
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

  /*void setUser(User user) {
    _user = user;
    notifyListeners();
  }

void met(){
  db.collection("users").where("id", isNotEqualTo: user!.uid).withConverter
  (fromFirestore: , toFirestore: toFirestore);
}*/
//  String? verificatId;
  /*void phone_autho(String number) async {
    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: number,
      verificationCompleted: (PhoneAuthCredential credential) {},
      verificationFailed: (FirebaseAuthException e) {
        log("the error is");
      },
      codeSent: (String verificationId, int? resendToken) async {
        verificatId = verificationId;
      },
      codeAutoRetrievalTimeout: (String verificationId) {},
    );
  }
*/
  /*void sendcode(String smsCode) async {
    // Create a PhoneAuthCredential with the code
    toast(txt: '1');
    try {
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
          verificationId: verificatId!, smsCode: smsCode);

      // Sign the user in (or link) with the credential
      await auth.signInWithCredential(credential).then((value) {
        toast(txt: 'sign in success');
      });
    } catch (e) {
      toast(txt: e.toString());
      log(e.toString());
    }
  }
*/