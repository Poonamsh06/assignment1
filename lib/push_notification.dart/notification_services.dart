import 'dart:math';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_tut/push_notification.dart/home.dart';
import 'package:firebase_tut/push_notification.dart/message.dart';
import 'package:firebase_tut/screens/add_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationServices {
  FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  FirebaseMessaging messaging = FirebaseMessaging.instance;

  void requestNotification() async {
    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      sound: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print("User granted permission");
    } else if (settings.authorizationStatus ==
        AuthorizationStatus.provisional) {
      print("User granted provisional permission");
    } else {
      print("User denied permission");
    }
  }

  void initLocalNotification(
      BuildContext context, RemoteMessage message) async {
    var androidInitializationSettings =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    var initializationSettings =
        InitializationSettings(android: androidInitializationSettings);
    await _flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onDidReceiveNotificationResponse: (payload) {
      handleMessage(context, message);
    });
  }

  void firebaseInit(
    BuildContext context,
  ) async {
    FirebaseMessaging.onMessage.listen((message) {
      print(message.notification?.title ?? '');
      print(message.notification?.body ?? '');
      print(message.data.toString());
      print(message.data['id']);
      print(message.data['type']);

      initLocalNotification(context, message);

      showNotification(message);
    });
  }

  Future<void> showNotification(RemoteMessage message) async {
    AndroidNotificationChannel channel = AndroidNotificationChannel(
        'high_importance_channel', // Consistent channel ID
        'High Importance Notifications',
        importance: Importance.max);

    AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails(channel.id, channel.name,
            channelDescription: 'Your Channel Description',
            importance: Importance.high,
            priority: Priority.high,
            ticker: 'ticker');

    NotificationDetails notificationDetails =
        NotificationDetails(android: androidNotificationDetails);

    await _flutterLocalNotificationsPlugin.show(
        0,
        message.notification?.title ?? '',
        message.notification?.body ?? '',
        notificationDetails);
  }

  Future<String?> getDeviceToken() async {
    String? token = await messaging.getToken();
    return token;
  }

  void isTokenRefresh() async {
    messaging.onTokenRefresh.listen((event) {
      print("Token refreshed: $event");
    });
  }

  void handleMessage(BuildContext context, RemoteMessage message) async {
    if (message.data['type'] == 'chat') {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => MessagePage(
                    id: message.data['id'],
                  )));
    }
  }
}
