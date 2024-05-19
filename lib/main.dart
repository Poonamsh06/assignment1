import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_tut/screens/add_data.dart';
import 'package:firebase_tut/screens/check_user.dart';
import 'package:firebase_tut/screens/login.dart';
import 'package:firebase_tut/screens/show_data.dart';
import 'package:flutter/material.dart';

import 'screens/phone_auth.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
              seedColor: const Color.fromARGB(255, 69, 29, 138)),
          useMaterial3: true,
        ),
        home: AddData());

    // CheckUser());
    //Home());
    //SignUpPage());
  }
}
