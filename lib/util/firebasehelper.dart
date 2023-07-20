import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:http/http.dart' as http;
import 'package:project3/widget/sharedwidget.dart';

class FirebaseHelper {
  static FirebaseMessaging messaging = FirebaseMessaging.instance;
  static late NotificationSettings settings;
  static String? token;

  static Future<void> start() async {
    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    await InitNotinfication();
    print('User granted permission: ${settings.authorizationStatus}');
  }

  static final FlutterLocalNotificationsPlugin flutterLocalNotiPlugin =
      FlutterLocalNotificationsPlugin();
  static Future<void> InitNotinfication() async {
    await messaging.requestPermission();
    await messaging.setAutoInitEnabled(true);
    await messaging.setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
    FirebaseMessaging.onBackgroundMessage(handlebackgroundmessage);

    FirebaseMessaging.onMessage
        .listen(handleforegroundmessage, onError: (e) {}, onDone: () {});
  }

  static Future<void> handlebackgroundmessage(RemoteMessage message) async {}
  static Future<void> handleforegroundmessage(RemoteMessage message) async {
    //message.data.forEach((k, v) => print('${k ?? 'keynull'}: ${v ?? 'tttt'}'));
    if (message.notification != null) {
      LocalNotificationService.display(message);
    } else {
      toast(txt: 'error404');
    }
  }

  static Future<void> sendPushNotification(
      String token, String title, String body) async {
    const String messageKey =
        'AAAALvuZKNs:APA91bFStvcjPUCfEHScI3OxmbRaPvI5WJHwPAFoRM2803czq4EoV4SdqzMKNmpRdORa4Lqg4HqBunqrMOO4DO2AVDFwb3MM7lMPgJXbxafB5XX3l1bHU7WGKW6ZLbluOn9qGmDXA_yg';
    try {
      http.Response response = await http.post(
        Uri.parse('https://fcm.googleapis.com/fcm/send'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'key=$messageKey',
        },
        body: jsonEncode(
          <String, dynamic>{
            'notification': <String, dynamic>{
              'body': body,
              'title': title,
            },
            'priority': 'high',
            'data': <String, dynamic>{
              'click_action': 'FLUTTER_NOTIFICATION_CLICK',
              'id': '5',
              'status': 'done'
            },
            'to': token,
          },
        ),
      );
      response;
      print('done100');
    } catch (e) {
      print('errrrrrrr' + e.toString());
      toast(txt: '' + e.toString());
    }
  }
}

class LocalNotificationService {
  // Instance of Flutternotification plugin
  static final FlutterLocalNotificationsPlugin _notificationsPlugin =
      FlutterLocalNotificationsPlugin();
  static Future<void> initialize() async {
    // Initialization  setting for android
    const InitializationSettings initializationSettingsAndroid =
        InitializationSettings(
            android: AndroidInitializationSettings("@mipmap/ic_launcher"));
    await _notificationsPlugin.initialize(
      initializationSettingsAndroid,
      // to handle event when we receive notification
      onDidReceiveNotificationResponse: (details) {
        if (details.input != null) {}
      },
    );
  }

  static Future<void> display(RemoteMessage message) async {
    // To display the notification in device
    try {
      print('notification staet');
      //print(message.notification!.android!.sound);
      final id = DateTime.now().millisecondsSinceEpoch ~/ 1000;
      NotificationDetails notificationDetails = NotificationDetails(
        android: AndroidNotificationDetails(
            message.notification!.android!.sound ?? "Channel Id",
            message.notification!.android!.sound ?? "Main Channel",
            groupKey: "gfg",
            color: Colors.green,
            importance: Importance.max,
            //   sound: const RawResourceAndroidNotificationSound(
            //   message.notification!.android!.sound ??
            //  "notificationSound.mp3"),

            // different sound for
            // different notification
            playSound: true,
            priority: Priority.high),
      );
      await _notificationsPlugin.show(id, message.notification?.title,
          message.notification?.body, notificationDetails,
          payload: message.data['route']);
    } catch (e) {
      print(e.toString());
    }
  }
}
