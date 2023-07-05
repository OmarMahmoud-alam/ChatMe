import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:project3/addnotecubit/addnote_cubit.dart';
import 'package:project3/controller/notecontroller.dart';
import 'package:project3/controller/signcontroller.dart';
import 'package:project3/learn/screens/scroll.dart';
import 'package:project3/view/note.dart';
import 'package:project3/view/signin/emailsign.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await Hive.initFlutter();
  await Hive.openBox('testBox');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AddnoteCubit(),
        ),
      ],
      child: MultiProvider(
          //ChangeNotifierProvider(
          //create: (context) => CounterModel(),
          providers: [
            ChangeNotifierProvider(create: (context) => UserProvider()),
            ChangeNotifierProvider(create: (context) => Noteprovider()),
          ],
          builder: (context, child) {
            final provide = Provider.of<UserProvider>(context);

            return MaterialApp(
              title: 'Flutter Demo',
              debugShowCheckedModeBanner: false,
              //  theme: provide.theme,
              home: const Notehome(),
            );
          }),
    );
  }
}
