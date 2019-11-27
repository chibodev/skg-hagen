import 'package:skg_hagen/src/common/model/address.dart';
import 'package:skg_hagen/src/offer/model/ageRange.dart';

class Offer {
  final String title;
  final String occurrence;
  final String time;
  final String timeUntil;
  final String placeName;
  final String room;
  final String organizer;
  final String email;
  final String infoTitle;
  AgeRange ageRange;
  final int ageStart;
  final int ageEnd;
  final String schoolYear;
  Address address;
  final String name;
  final String street;
  final String houseNumber;
  final String zip;
  final String city;
  final String country;
  final String latLong;

  Offer(
      {this.title,
      this.occurrence,
      this.time,
      this.timeUntil,
      this.placeName,
      this.room,
      this.infoTitle,
      this.organizer,
      this.email,
      this.ageStart,
      this.ageEnd,
      this.schoolYear,
      this.name,
      this.street,
      this.houseNumber,
      this.zip,
      this.city,
      this.latLong,
      this.country}) {
    this.address = Address(
        name: name,
        street: street,
        houseNumber: houseNumber,
        zip: zip,
        city: city,
        country: country,
        latLong: latLong,
        room: room);

    this.ageRange = AgeRange(start: ageStart, end: ageEnd);
  }

  factory Offer.fromJson(Map<String, dynamic> json) => Offer(
        title: json['title'],
        occurrence: json['occurrence'],
        time: json["time"],
        timeUntil: json["timeUntil"],
        placeName: json["placeName"],
        room: json["room"] == "" ? null : json["room"],
        infoTitle: json["infoTitle"] == "" ? null : json["infoTitle"],
        organizer: json["organizer"] == "" ? null : json["organizer"],
        email: json["email"] == "" ? null : json["email"],
        ageStart: json['ageStart'] == "" ? null : int.parse(json['ageStart']),
        ageEnd: json['ageEnd'] == "" ? null : int.parse(json['ageEnd']),
        schoolYear: json['schoolYear'],
        name: json["name"] == null ? null : json["name"],
        street: json["street"] == null ? null : json["street"],
        houseNumber: json["houseNumber"] == null ? null : json["houseNumber"],
        zip: json["zip"] == null ? null : json["zip"],
        city: json["city"] == null ? null : json["city"],
        country: json["country"] == null ? null : json["country"],
        latLong: json["latLong"] == null ? null : json['latLong'],
      );

  String getName() => "Offene Angebote";

  String getFormattedSchoolYear() => "${schoolYear.toString()}. Schuljahr";

  String getFormattedOccurrence() {
    final String occurrenceTime =
        (time == "00:00:00") ? '--' : time.substring(0, 5);
    final String occurrenceTimeUntil =
        (timeUntil == "00:00:00" || timeUntil == null)
            ? ''
            : "- ${timeUntil.substring(0, 5)}";

    return "$occurrence | $occurrenceTime $occurrenceTimeUntil";
  }

  String getFormattedOrganiser() {
    String text;

    if (organizer != null) {
      text = infoTitle != null ? "$infoTitle: $organizer" : organizer;
    }

    return text;
  }
}
