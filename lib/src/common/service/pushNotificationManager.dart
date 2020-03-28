import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:skg_hagen/src/common/model/messaging.dart';
import 'package:skg_hagen/src/common/routes/routes.dart';

import 'environment.dart';

class PushNotificationsManager {
  PushNotificationsManager._();

  factory PushNotificationsManager() => _instance;

  static final PushNotificationsManager _instance =
      PushNotificationsManager._();

  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  bool _initialized = false;

  Future<void> init(BuildContext context) async {
    if (!_initialized) {
      // For iOS request permission first.
      _firebaseMessaging.requestNotificationPermissions();
      _firebaseMessaging.configure(
        onMessage: (Map<String, dynamic> message) async {
          //TODO: Show info of new notification;
        },
        onLaunch: (Map<String, dynamic> message) async {
          final Messaging messaging = Messaging.fromJson(message);
          _openScreenByRoute(messaging.data.screen, context);
        },
        onResume: (Map<String, dynamic> message) async {
          final Messaging messaging = Messaging.fromJson(message);
          _openScreenByRoute(messaging.data.screen, context);
        },
      );

      if (!Environment.isProduction()) {
        final String token = await _firebaseMessaging.getToken();
        print("FirebaseMessaging token: $token");
      }

      _initialized = true;
    }
  }

  void _openScreenByRoute(String routeName, BuildContext context) {
    if (Routes.isValid(routeName)) {
      Navigator.of(context).pushNamed(routeName);
    }
  }
}
