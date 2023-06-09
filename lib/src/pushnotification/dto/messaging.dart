import 'data.dart';
import 'notification.dart';

class Messaging {
  Notification notification;
  Data data;

  Messaging({
    required this.notification,
    required this.data,
  });

  factory Messaging.fromJson(Map<String, dynamic> json) => Messaging(
        notification:
            Notification.fromJson(json['notification'] ?? json['aps']['alert']),
        data: Data.fromJson(json["data"] ?? json),
      );

  Map<String, dynamic> toJson() => <String, dynamic>{
        "notification": notification.toJson(),
        "data": data.toJson(),
      };
}
