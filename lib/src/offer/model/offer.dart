import 'package:json_annotation/json_annotation.dart';
import 'package:skg_hagen/src/common/model/address.dart';
import 'package:skg_hagen/src/offer/model/ageRange.dart';

part 'offer.g.dart';

@JsonSerializable(explicitToJson: true)
class Offer {
  final String title;
  final String date;
  final String time;
  final Address address;
  final String organizer;
  final String email;
  @JsonKey(name: 'age')
  final AgeRange ageRange;
  @JsonKey(name: 'school_year')
  final int schoolYear;

  Offer(this.title, this.date, this.time, this.address, this.organizer,
      [this.email, this.ageRange, this.schoolYear]);

  factory Offer.fromJson(Map<String, dynamic> json) => _$OfferFromJson(json);

  Map<String, dynamic> toJson() => _$OfferToJson(this);

  String getName() => "Angebote";

  String getFormattedSchoolYear() => schoolYear.toString() + ' Schuljahr';

  String getFormatted() => date + " | " + time;
}
