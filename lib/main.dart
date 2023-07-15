import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:project3/controller/signcontroller.dart';
import 'package:project3/view/signin/emailsign.dart';

import 'package:provider/provider.dart';
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';
import 'package:zego_uikit_signaling_plugin/zego_uikit_signaling_plugin.dart';

import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  // final navigatorKey = GlobalKey<NavigatorState>();

  /// 2/5: set navigator key to ZegoUIKitPrebuiltCallInvitationService
  // ZegoUIKitPrebuiltCallInvitationService().setNavigatorKey(navigatorKey);

  ZegoUIKit().initLog().then((value) {
    ZegoUIKitPrebuiltCallInvitationService().useSystemCallingUI(
      [ZegoUIKitSignalingPlugin()],
    );

    runApp(MyApp());
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => UserProvider()),
        ],
        builder: (context, child) {
          // final provide = Provider.of<UserProvider>(context);

          return const MaterialApp(
            // navigatorKey: navigatorKey,
            debugShowCheckedModeBanner: false,

            /*  builder: (BuildContext context, Widget? child) {
              return Stack(
                children: [
                  child ??
                      Container(
                        color: Colors.red,
                        width: 100,
                        height: 100,
                      ),
                  email(),

                  /// support minimizing
                  /* ZegoUIKitPrebuiltCallMiniOverlayPage(
                    contextQuery: () {
                      return navigatorKey.currentState!.context;
                    },
                  ),*/
                ],
              );
            },*/
            home: const email(),
          );
        });
  }
}
