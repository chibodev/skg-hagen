import 'dart:convert';
import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:skg_hagen/src/common/dto/default.dart';
import 'package:skg_hagen/src/common/routes/routes.dart';
import 'package:skg_hagen/src/common/service/environment.dart';
import 'package:skg_hagen/src/pushnotification/dto/data.dart';
import 'package:skg_hagen/src/pushnotification/dto/messaging.dart';

class PushNotificationsManager {
  PushNotificationsManager._();

  factory PushNotificationsManager() => _instance;

  static final PushNotificationsManager _instance =
      PushNotificationsManager._();

  /* check if token exists in list (endpoint that return list or empty)
   1. If empty - subscribe to list
   2. if not empty and deactivated, subscribe to topic
   3. if not empty and not deactivated ignore
   */

  BuildContext _buildContext;
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  bool _initialized = false;
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  void _configLocalNotification() {
    final AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('notification_icon');
    final IOSInitializationSettings initializationSettingsIOS =
        IOSInitializationSettings();
    final InitializationSettings initializationSettings =
        InitializationSettings(
            android: initializationSettingsAndroid,
            iOS: initializationSettingsIOS);
    flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: onSelectNotification);
  }

  Future<void> init(BuildContext context) async {
    _buildContext = context;
    if (!_initialized) {
      // For iOS request permission first.
      _firebaseMessaging.requestNotificationPermissions();
      _configLocalNotification();
      _firebaseMessaging.configure(
        onMessage: (Map<String, dynamic> message) async {
          final Messaging messaging = Messaging.fromJson(message);
          _showNotification(messaging);
        },
        onLaunch: _openScreen,
        onResume: _openScreen,
      );

      if (!Environment.isProduction()) {
        final String token = await _firebaseMessaging.getToken();
        print("FirebaseMessaging token: $token");
      }

      _initialized = true;
    }
  }

  Future<void> _openScreen(Map<String, dynamic> message) async {
    final Messaging messaging = Messaging.fromJson(message);
    _openScreenByRoute(messaging.data.screen);
  }

  void _openScreenByRoute(String routeName) {
    if (Routes.isValid(routeName)) {
      Navigator.of(_buildContext).pushNamed(routeName);
    }
  }

  Future<void> onSelectNotification(String payload) async {
    final Data data = Data.fromJson(jsonDecode(payload));
    _openScreenByRoute(data.screen);
  }

  void _showNotification(Messaging message) async {
    final AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
            Platform.isAndroid ? 'de.skg_hagen' : 'de.skghagen.app',
            'skg Hagen',
            'notification',
            playSound: true,
            enableVibration: true,
            importance: Importance.max,
            priority: Priority.high,
            color: Color(Default.COLOR_GREEN));
    final IOSNotificationDetails iOSPlatformChannelSpecifics =
        IOSNotificationDetails();
    final NotificationDetails platformChannelSpecifics = NotificationDetails(
        android: androidPlatformChannelSpecifics,
        iOS: iOSPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.show(0, message.notification.title,
        message.notification.body, platformChannelSpecifics,
        payload: json.encode(message.data.toJson()));
  }
}
