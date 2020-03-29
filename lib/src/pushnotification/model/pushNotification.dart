import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:skg_hagen/src/common/routes/routes.dart';

class PushNotification {
  final String title;
  final String body;
  final String screen;
  final DateTime validUntil;

  PushNotification({
    this.title,
    this.body,
    this.screen,
    this.validUntil,
  });

  factory PushNotification.fromJson(Map<String, dynamic> json) =>
      PushNotification(
        title: json['title'],
        body: json['body'],
        screen: (json['screen'] != '' || json['screen'] != null)
            ? json['screen']
            : null,
        validUntil: DateTime.parse(json["validUntil"]),
      );

  String getFormattedValidUntil() {
    initializeDateFormatting('de_DE', null);
    return "Gültig bis ${DateFormat("E d.M.yy", "de_DE").format(this.validUntil).toLowerCase().toUpperCase()}";
  }

  String getCategory() {
    return Routes.MAPPING.containsKey(screen) ? Routes.MAPPING[screen] : null;
  }
}
