import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:skg_hagen/src/common/model/address.dart';

part 'group.g.dart';

@JsonSerializable(explicitToJson: true)
class Group {
  final String title;
  final String date;
  final String time;
  final Address address;
  final String organizer;

  Group(this.title, this.date, this.time, this.address, [this.organizer]);

  factory Group.fromJson(Map<String, dynamic> json) => _$GroupFromJson(json);

  Map<String, dynamic> toJson() => _$GroupToJson(this);

  String getName() => "Gruppen und Kreisen";

  String getFormatted() => date + " | " + time;
}
