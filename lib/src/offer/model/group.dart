import 'package:skg_hagen/src/common/model/address.dart';

class Group {
  final String title;
  final String occurrence;
  final String time;
  final String timeUntil;
  final String placeName;
  final String room;
  final String organizer;
  final String email;
  Address address;
  final String name;
  final String street;
  final String houseNumber;
  final String zip;
  final String city;
  final String country;
  final String latLong;

  Group(
      {this.title,
      this.occurrence,
      this.time,
      this.timeUntil,
      this.placeName,
      this.room,
      this.organizer,
      this.email,
      this.address,
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
  }

  factory Group.fromJson(Map<String, dynamic> json) => Group(
        title: json['title'],
        occurrence: json['occurrence'],
        time: json["time"],
        timeUntil: json["timeUntil"],
        placeName: json["placeName"],
        room: json["room"] == "" ? null : json["room"],
        organizer: json["organizer"] == "" ? null : json["organizer"],
        email: json["email"] == "" ? null : json["email"],
        name: json["name"] == null ? null : json["name"],
        street: json["street"] == null ? null : json["street"],
        houseNumber: json["houseNumber"] == null ? null : json["houseNumber"],
        zip: json["zip"] == null ? null : json["zip"],
        city: json["city"] == null ? null : json["city"],
        country: json["country"] == null ? null : json["country"],
        latLong: json["latLong"] == null ? null : json['latLong'],
      );

  String getName() => "Gruppen und Kreise";

  String getFormattedOrganiser() =>
      organizer != null ? "Infos: $organizer" : organizer;

  String getFormattedOccurrence() {
    final String occurrenceTime =
        (time == "00:00:00") ? '--' : time.substring(0, 5);
    final String occurrenceTimeUntil =
        (timeUntil == "00:00:00" || timeUntil == null) ? '' : "- ${timeUntil.substring(0, 5)}";

    return "$occurrence | $occurrenceTime $occurrenceTimeUntil";
  }
}
