import 'package:skg_hagen/src/pushnotification/model/pushNotification.dart';

class PushNotifications {
  static const String NAME = 'Benachrichtigung';
  static const String IMAGE = 'assets/images/push.jpg';

  List<PushNotification> pushNotification;

  PushNotifications({
    this.pushNotification,
  });

  factory PushNotifications.fromJson(Map<String, dynamic> json) =>
      PushNotifications(
        pushNotification: List<PushNotification>.from(
          json["push_notification"].map(
            (dynamic x) => PushNotification.fromJson(x),
          ),
        ),
      );
}
