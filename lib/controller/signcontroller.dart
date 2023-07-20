import 'dart:developer';
import 'dart:isolate';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:project3/module/user.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:project3/styles/styles.dart';
import 'package:project3/util/firebasehelper.dart';
import 'package:project3/view/Chat/Home.dart';
import 'package:project3/zegofunctionality/zego.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import '../widget/sharedwidget.dart';

class UserProvider extends ChangeNotifier {
  User? user;

  String email = 'error';
  final db = FirebaseFirestore.instance;
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController usernamecontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();
  TextEditingController passwordcontroller2 = TextEditingController();
  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore storage = FirebaseFirestore.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: <String>[
      'email',
      'https://www.googleapis.com/auth/contacts.readonly'
    ],
  );
  bool ispassword = false;
  void changevisiblepassword() {
    ispassword = !ispassword;
    notifyListeners();
  }

  Isolate? myIsolate;

  Future<void> startIsolate(String id) async {
    myIsolate = await Isolate.spawn(FirebaseHelper.startUpdatingLastSeen, id);
  }

  void stopIsolate() async {
    if (myIsolate != null) {
      myIsolate!.kill(priority: Isolate.immediate);
      print("Isolate stopped");
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
  String? verificatId;
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

  void sendcode(String smsCode) async {
    // Create a PhoneAuthCredential with the code
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

  bool isclosing = true;
  void getCurrentUserInfo() async {
    user = auth.currentUser;
    if (user != null && isclosing) {
      startIsolate(user!.uid);
      print('tototototootot');
      FirebaseHelper.token = await FirebaseMessaging.instance.getToken();
      //print(' FirebaseHelper.token');
      toast(txt: FirebaseHelper.token ?? 'emmpttttt');
      FirebaseFirestore.instance
          .collection('users')
          .where("uId", isEqualTo: user!.uid)
          .get()
          .then((value) async {
        if (value.docs.isEmpty) {
          adduser(
            email: email,
            uId: user!.uid,
            phone: "01202202202",
            name: user!.displayName ?? 'anoyanas',
          );
          Comman.meuser = SocialUserModel(
              lastseen: -1,
              bio: 'Bio',
              email: email,
              uId: user!.uid,
              phone: "01202202202",
              name: user!.displayName ?? 'anoyanas',
              token: [FirebaseHelper.token],
              cover:
                  'https://firebasestorage.googleapis.com/v0/b/fir-chat-406cc.appspot.com/o/share%2FAnonymity.jpg?alt=media&token=9afc2715-fa3d-4bf8-9438-1d9b35d5ad06');
        } else {
          //  print(value.docs[0].data()['token'].runtimeType);

          Comman.meuser = SocialUserModel.fromJson(value.docs[0].data());

          onUserLogin(Comman.meuser!);
        }
        await FirebaseFirestore.instance
            .collection('users')
            .doc(user!.uid)
            .update({
          'token': FieldValue.arrayUnion([FirebaseHelper.token]),
        });
      }).catchError((e) {
        toast(txt: 'is empty 11 $e');
        // print('is empty   $e');
      });
    }
  }

  String convertToLastseen(int lastSeen) {
    DateTime lastSeenDateTime = DateTime.fromMillisecondsSinceEpoch(lastSeen);

    final now = DateTime.now();
    final difference = now.difference(lastSeenDateTime);

    if (difference.inMinutes <= 10) {
      return 'is active now';
    }

    // If the last seen datetime is today, return the time
    if (now.year == lastSeenDateTime.year &&
        now.month == lastSeenDateTime.month &&
        now.day == lastSeenDateTime.day) {
      return 'Last seen ${DateFormat.jm().format(lastSeenDateTime)}';
    }

    // Otherwise, return the date
    if (difference.inDays < 7) {
      return 'Last seen ${DateFormat('EEEE').format(lastSeenDateTime)}';
    } else {
      return 'Last seen ${DateFormat('MMM d, y').format(lastSeenDateTime)}';
    }
  }

  Future<void> logoutLastseen() async {
    final now = DateTime.now().millisecondsSinceEpoch;
    await FirebaseFirestore.instance
        .collection('users')
        .doc(Comman.meuser!.uId)
        .update({'lastseen': now});
  }

  Future<void> deletetoken() async {
    await FirebaseFirestore.instance.collection('users').doc(user!.uid).update({
      'token': FieldValue.arrayRemove([FirebaseHelper.token]),
    });
    FirebaseHelper.token = null;
  }

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
          name: userCredential.user!.displayName,
          email: userCredential.user!.email,
          uId: userCredential.user!.uid,
          cover: userCredential.user!.photoURL,
        );
        notifyListeners();
        navigateto(context: context, widget: const HomeChat());
      } on FirebaseAuthException catch (e) {
        if (e.code == 'user-not-found') {
          makemassege(msg: 'userNotFound');
        } else if (e.code == 'wrong-password') {
          makemassege(msg: 'wrong password');
        } else {
          makemassege(msg: 'ttt2$e');
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

  Future<void> logout() async {
    try {
      //await deletetoken();
      //عايزين نشيل التوكن لما نقفل
      // await FirebaseMessaging.instance.deleteToken();
      stopIsolate();
      clearUser();
      await logoutLastseen();
      await _googleSignIn.signOut();
      await FirebaseAuth.instance.signOut();
      await onUserLogout();

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
        toast(txt: 'ttt3${userCredential.user!.uid}', color: Colors.deepOrange);
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
    isclosing = false;
    notifyListeners();
  }

  void pagelogin() {
    isclosing = true;
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
        adduserdata(
            uId: value.user!.uid,
            name: usernamecontroller.text,
            email: value.user!.email,
            phone: value.user!.phoneNumber);
        navigateto(context: context, widget: const HomeChat());
      }).catchError((e) {
        log(e.toString());
        toast(txt: 'ttt5$e', color: Colors.red);
      });
      notifyListeners();
    }
  }

//put user data from firebase
  void adduserdata(
      {required uId,
      name = "anayonmas",
      required email,
      phone = "01021212121",
      String? cover}) {
    FirebaseFirestore.instance
        .collection('users')
        .where("uId", isEqualTo: uId)
        .get()
        .then((value) {
      if (value.docs.isEmpty) {
        //toast(txt: 'is empty');
        log('is empty');
        adduser(uId: uId, name: name, email: email, phone: phone, cover: cover);
      }
    }).catchError((e) {
      toast(txt: 'is empty $e');
      log('is empty   $e');
    });
  }

  void adduser(
      {required uId,
      required name,
      required email,
      required phone,
      cover =
          'https://firebasestorage.googleapis.com/v0/b/fir-chat-406cc.appspot.com/o/share%2FAnonymity.jpg?alt=media&token=9afc2715-fa3d-4bf8-9438-1d9b35d5ad06'}) async {
    String? token = await FirebaseMessaging.instance.getToken();

    SocialUserModel user1 = SocialUserModel(
      lastseen: -1,
      bio: 'Bio',
      name: name,
      uId: uId,
      email: email,
      phone: phone,
      token: [token],
      cover: cover,
    );

    storage.collection('users').doc(uId).set(user1.toMap()).then((value) {
      //   toast(txt: 'Done');
      notifyListeners();
    }).catchError((e) {
      // log(e.toString());
      toast(txt: 'ttt1$e', color: Colors.red).then((value) {
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
