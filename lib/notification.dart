import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firstscreen/foreground_notification.dart';
import 'package:flutter/material.dart';

class PushNotification {
  final FirebaseMessaging _fcm = FirebaseMessaging.instance;

  Future initialize() async {
    final FirebaseMessaging _fcm = FirebaseMessaging.instance;
    debugPrint("notification initialized");

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('Got a message whilst in the foreground! $message');
      print('Message data: ${message.data.toString()}');
      NotificationService.showNotification(message);
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;
      debugPrint("2___ ${message.data.toString()}");
      if (notification != null && android != null) {
        debugPrint("if $notification and $android");
        NotificationService.showNotification(message);
      } else {
        debugPrint("else $notification and $android");
      }
      print('Message clicked!');
    });
    FirebaseMessaging.instance
        .getInitialMessage()
        .then((RemoteMessage? message) {
      if (message?.notification != null) {
        debugPrint("3___ ${message.toString()}");
      }
    });

    FirebaseMessaging.onBackgroundMessage(_backgroundHandler);
    final token = await _getDevToken();
  }

  static Future<void> _backgroundHandler(RemoteMessage message) async {
    print('Handling a background message ${message.messageId}');
  }

  Future<String?> _getDevToken() async {
    String? token = await _fcm.getToken();
    print('DEV TOKEN FIREBASE CLOUD MESSAGING -> $token');
    return token;
  }
}
