import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:project3/controller/signcontroller.dart';
import 'package:project3/util/absorve.dart';
import 'package:project3/util/firebasehelper.dart';
import 'package:project3/view/signin/emailsign.dart';

import 'package:provider/provider.dart';

import 'firebase_options.dart';
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';
import 'package:zego_uikit_signaling_plugin/zego_uikit_signaling_plugin.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  final observer = LifecycleObserver();

  // Add the observer to the WidgetsBinding
  WidgetsBinding.instance.addObserver(observer);

  await FirebaseHelper.start();
  final navigatorKey = GlobalKey<NavigatorState>();

  await LocalNotificationService.initialize();

  /// 1.1.2: set navigator key to ZegoUIKitPrebuiltCallInvitationService
  ZegoUIKitPrebuiltCallInvitationService().setNavigatorKey(navigatorKey);

  ZegoUIKit().initLog().then((value) {
    ///  Call the `useSystemCallingUI` method
    ZegoUIKitPrebuiltCallInvitationService().useSystemCallingUI(
      [ZegoUIKitSignalingPlugin()],
    );

    runApp(MyApp(navigatorKey: navigatorKey));
  });
}

class MyApp extends StatefulWidget {
  const MyApp({super.key, required this.navigatorKey});
  final GlobalKey<NavigatorState> navigatorKey;
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        //ChangeNotifierProvider(                 //we use that if one provider
        //create: (context) => CounterModel(),
        providers: [
          ChangeNotifierProvider(create: (context) => UserProvider()),
        ],
        builder: (context, child) {
          // final provide = Provider.of<UserProvider>(context);

          return MaterialApp(
            navigatorKey: widget.navigatorKey,
            debugShowCheckedModeBanner: false,
            home: const email(),
          );
        });
  }
}
