import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:json_annotation/json_annotation.dart';

part 'news.g.dart';

@JsonSerializable()
class News {
  final String title;
  final DateTime date;
  final String content;

  News(this.title, this.date, this.content);

  factory News.fromJson(Map<String, dynamic> json) => _$NewsFromJson(json);

  Map<String, dynamic> toJson() => _$NewsToJson(this);

  String getFormattedTime() {
    initializeDateFormatting('de_DE', null);
    return DateFormat("E d.M.yy", "de_DE")
        .format(date)
        .toString()
        .toUpperCase();
  }

  String getFormattedDate() {
    initializeDateFormatting('de_DE', null);
    return DateFormat("d.M.yy", "de_DE")
        .format(date)
        .toString()
        .toUpperCase();
  }

  String getName() => "Mitteilungen";
}
