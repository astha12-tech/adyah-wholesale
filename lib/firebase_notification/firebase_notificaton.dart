// ignore_for_file: depend_on_referenced_packages

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class FirebaseNotifications {
  FlutterLocalNotificationsPlugin? fltNotification;
  void pushFCMtoken() async {
    String? token = await FirebaseMessaging.instance.getToken();
    debugPrint("***====== fcmtoken is here ======*** $token\n");
  }

  void initMessaging() {
    var androiInit = const AndroidInitializationSettings('@mipmap/ic_launcher');
    var iosInit = const DarwinInitializationSettings();
    var initSetting = InitializationSettings(android: androiInit, iOS: iosInit);
    fltNotification = FlutterLocalNotificationsPlugin();
    fltNotification!.initialize(initSetting);
    var androidDetails = const AndroidNotificationDetails('1', 'channelName',
        playSound: true,
        importance: Importance.max,
        priority: Priority.high,
        sound: RawResourceAndroidNotificationSound('sound1'));
    var iosDetails = const DarwinNotificationDetails();
    var generalNotificationDetails =
        NotificationDetails(android: androidDetails, iOS: iosDetails);
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification notification = message.notification!;
      AndroidNotification? android = message.notification?.android;
      if (android != null) {
        fltNotification!.show(notification.hashCode, notification.title,
            notification.body, generalNotificationDetails);
      }
    });
  }
}

FirebaseNotifications firebaseNotifications = FirebaseNotifications();
