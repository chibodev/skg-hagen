import 'package:json_annotation/json_annotation.dart';

part 'ageRange.g.dart';

@JsonSerializable()
class AgeRange {
  final int start;
  final int end;

  AgeRange(this.start, this.end);

  factory AgeRange.fromJson(Map<String, dynamic> json) =>
      _$AgeRangeFromJson(json);

  Map<String, dynamic> toJson() => _$AgeRangeToJson(this);

  String getFormatted() {
    final List<int> ageRange = <int>[start, end];
    return ageRange.join(" - ");
  }
}
