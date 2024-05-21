import 'dart:developer';

import 'package:firebase_messaging/firebase_messaging.dart';

Future<void> BackgroundHandler(RemoteMessage remoteMessage) async {
  log("${remoteMessage.notification!.title}");
}

class NotificationsService {
  static Future<void> initilize() async {
    NotificationSettings notificationSettings =
        await FirebaseMessaging.instance.requestPermission();
    if (notificationSettings.authorizationStatus ==
        AuthorizationStatus.authorized) {
      FirebaseMessaging.onBackgroundMessage(BackgroundHandler);
      FirebaseMessaging.onMessage.listen((message) {
        log("${message.notification!.title}");
      });
      log("Message Authorized");
    }
  }
}
