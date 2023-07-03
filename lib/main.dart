import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:project3/controller/signcontroller.dart';
import 'package:project3/learn/screens/scroll.dart';
import 'package:project3/view/emailsign.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        //ChangeNotifierProvider(
        //create: (context) => CounterModel(),
        providers: [
          ChangeNotifierProvider(create: (context) => UserProvider()),
        ],
        builder: (context, child) {
          final provide = Provider.of<UserProvider>(context);

          return MaterialApp(
            title: 'Flutter Demo',
            debugShowCheckedModeBanner: false,
            //  theme: provide.theme,
            home: const email(),
          );
        });
  }
}
