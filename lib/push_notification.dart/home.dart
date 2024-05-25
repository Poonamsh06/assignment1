import 'package:firebase_tut/push_notification.dart/notification_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class HomeP extends StatefulWidget {
  const HomeP({super.key});

  @override
  State<HomeP> createState() => _HomePState();
}

class _HomePState extends State<HomeP> {
  NotificationServices notificationServices = NotificationServices();
  @override
  void initState() {
    // TODO: implement initState

    super.initState();
    notificationServices.requestNotification();
    notificationServices.firebaseInit(context);
    //notificationServices.isTokenRefresh();
    notificationServices.getDeviceToken().then((value) {
      print("Device Token:");
      print(value);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("Hi"),
      ),
    );
  }
}
