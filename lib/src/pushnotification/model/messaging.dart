import 'data.dart';
import 'notification.dart';

class Messaging {
  Notification notification;
  Data data;

  Messaging({
    this.notification,
    this.data,
  });

  factory Messaging.fromJson(Map<String, dynamic> json) => Messaging(
        notification: Notification.fromJson(json['notification']),
        data: Data.fromJson(json["data"] ?? json),
      );

  Map<String, dynamic> toJson() => <String, dynamic>{
        "notification": notification.toJson(),
        "data": data.toJson(),
      };
}
