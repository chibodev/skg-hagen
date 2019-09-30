import 'package:json_annotation/json_annotation.dart';
import 'package:skg_hagen/src/kindergarten/model/events.dart';
import 'package:skg_hagen/src/kindergarten/model/news.dart';

part 'kindergarten.g.dart';

@JsonSerializable(explicitToJson: true)
class Kindergarten {
  final List<Events> events;
  final List<News> news;

  Kindergarten(this.events, this.news);

  factory Kindergarten.fromJson(Map<String, dynamic> json) =>
      _$KindergartenFromJson(json);

  Map<String, dynamic> toJson() => _$KindergartenToJson(this);
}
