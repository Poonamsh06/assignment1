import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_tut/push_notification.dart/home.dart';
import 'package:firebase_tut/screens/add_data.dart';
import 'package:firebase_tut/screens/check_user.dart';
import 'package:firebase_tut/screens/cloud_firestore/sign_up2.dart';
import 'package:firebase_tut/screens/login.dart';
import 'package:firebase_tut/screens/show_data.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'screens/phone_auth.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  runApp(const MyApp());
}

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print(message.notification!.title.toString());
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
          textTheme: GoogleFonts.poppinsTextTheme(
            Theme.of(context).textTheme,
          ),
          colorScheme: ColorScheme.fromSeed(
              seedColor: const Color.fromARGB(255, 69, 29, 138)),
          useMaterial3: true,
        ),
        home: HomeP());
    //AddData());

    // CheckUser());
    //Home());
    //SignUpPage());
  }
}
