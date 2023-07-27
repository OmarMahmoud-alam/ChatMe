// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyDH_TfOZ5oCkYqoqsazewUx5JsEgB0Tjos',
    appId: '1:201789614299:web:2b1215a917db9e75a584fe',
    messagingSenderId: '201789614299',
    projectId: 'fir-chat-406cc',
    authDomain: 'fir-chat-406cc.firebaseapp.com',
    storageBucket: 'fir-chat-406cc.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCJmIj-yt81k2qi7D1U-hPuSwL85XWaOsM',
    appId: '1:201789614299:android:1fa38fb566636e88a584fe',
    messagingSenderId: '201789614299',
    projectId: 'fir-chat-406cc',
    storageBucket: 'fir-chat-406cc.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBqcs9HQLP7SU9sY2QNKBijylUHu13lXP8',
    appId: '1:201789614299:ios:7843a2846852a084a584fe',
    messagingSenderId: '201789614299',
    projectId: 'fir-chat-406cc',
    storageBucket: 'fir-chat-406cc.appspot.com',
    iosClientId: '201789614299-ron66k0nk9dqlq15ilo7ce55n380om2q.apps.googleusercontent.com',
    iosBundleId: 'com.example.project3',
  );
}
