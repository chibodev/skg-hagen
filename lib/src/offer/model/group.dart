import 'package:skg_hagen/src/common/model/address.dart';

class Group {
  final String title;
  final String occurrence;
  final String time;
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

  Group(
      {this.title,
      this.occurrence,
      this.time,
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
      this.country}) {
    this.address = Address(
        name: name,
        street: street,
        houseNumber: houseNumber,
        zip: zip,
        city: city,
        country: country,
        room: room);
  }

  factory Group.fromJson(Map<String, dynamic> json) => Group(
        title: json['title'],
        occurrence: json['occurrence'],
        time: json["time"],
        placeName: json["placeName"],
        room: json["room"],
        organizer: json["organizer"] == null ? null : json["organizer"],
        email: json["email"] == null ? null : json["email"],
        name: json["name"] == null ? null : json["name"],
        street: json["street"] == null ? null : json["street"],
        houseNumber: json["houseNumber"] == null ? null : json["houseNumber"],
        zip: json["zip"] == null ? null : json["zip"],
        city: json["city"] == null ? null : json["city"],
        country: json["country"] == null ? null : json["country"],
      );

  String getName() => "Gruppen und Kreisen";

  String getFormattedOccurrence() => occurrence + " | " + time.substring(0,5);
}
