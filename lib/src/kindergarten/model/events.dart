import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:json_annotation/json_annotation.dart';

part 'events.g.dart';

@JsonSerializable()
class Events {
  final String title;
  final DateTime date;
  final String comment;
  final String link;

  Events(this.title, this.date, this.comment, this.link);

  factory Events.fromJson(Map<String, dynamic> json) => _$EventsFromJson(json);

  Map<String, dynamic> toJson() => _$EventsToJson(this);

  String getName() => "Events";

  String getFormattedTime() {
    initializeDateFormatting('de_DE', null);
    return DateFormat("E d.M.yy", "de_DE")
        .format(date)
        .toString()
        .toUpperCase();
  }
}
