import 'package:flutter/material.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firstscreen/notification.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationService {
  static final FlutterLocalNotificationsPlugin
      _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  static Future initialize() async {
    final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
        FlutterLocalNotificationsPlugin();

    AndroidInitializationSettings androidInitializationSettings =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    InitializationSettings initializationSettings =
        InitializationSettings(android: androidInitializationSettings);

    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      // onSelectNotification: doSomething(),
    );
  }

  static Future showNotification(RemoteMessage message) async {
    debugPrint("show notification ____");
    AndroidNotificationDetails androidDetails = AndroidNotificationDetails(
      "default_notification_channel_id",
      "channel",
      channelDescription: 'description',
      icon: '@mipmap/ic_launcher',
      enableLights: true,
      enableVibration: true,
      priority: Priority.high,
      importance: Importance.max,
      // largeIcon: DrawableResourceAndroidBitmap("@mipmap/ic_launcher"),
      styleInformation: MediaStyleInformation(
        htmlFormatContent: true,
        htmlFormatTitle: true,
      ),
      playSound: true,
    );

    await _flutterLocalNotificationsPlugin.show(
        message.data.hashCode,
        message.notification?.title,
        message.notification?.body,
        /* message.data['title'] ?? 'Default Title',
        message.data['text'] ?? 'Default Text',*/
        NotificationDetails(
          android: androidDetails,
        ));
  }

  Future<String?> _getDevToken() async {
    String? token = await FirebaseMessaging.instance.getToken();
    print("DEV TOKEN FIREBASE CLOUD MESSAGING -> $token");
    return token;
  }
}
