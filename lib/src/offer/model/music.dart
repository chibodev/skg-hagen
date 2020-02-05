import 'package:skg_hagen/src/common/model/address.dart';

class Music {
  static const int URL_MIN = 7;

  final String title;
  final String description;
  final String imageUrl;
  final String email;
  Address address;
  final String organizer;
  final String occurrence;
  final String time;
  final String timeUntil;
  final String placeName;
  final String room;
  final String name;
  final String street;
  final String houseNumber;
  final String zip;
  final String city;
  final String country;
  final String latLong;

  Music(
      {this.title,
      this.description,
      this.imageUrl,
      this.email,
      this.organizer,
      this.occurrence,
      this.time,
      this.timeUntil,
      this.placeName,
      this.room,
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

  factory Music.fromJson(Map<String, dynamic> json) => Music(
        title: json['title'],
        description: json['description'],
        imageUrl: json['imageUrl'].toString().length > URL_MIN
            ? json['imageUrl']
            : null,
        email: json['email'],
        organizer: json["organizer"] == "" ? null : json["organizer"],
        occurrence: json['occurrence'],
        time: json["time"],
        timeUntil: json["timeUntil"],
        placeName: json["placeName"],
        room: json["room"] == "" ? null : json["room"],
        name: json["name"] == null ? null : json["name"],
        street: json["street"] == null ? null : json["street"],
        houseNumber: json["houseNumber"] == null ? null : json["houseNumber"],
        zip: json["zip"] == null ? null : json["zip"],
        city: json["city"] == null ? null : json["city"],
        country: json["country"] == null ? null : json["country"],
        latLong: json["latLong"] == null ? null : json['latLong'],
      );

  String getName() => "Musik";

  String getFormattedOccurrence() {
    final String occurrenceTime =
        (time == "00:00:00") ? '--' : time.substring(0, 5);
    return "$occurrence | $occurrenceTime";
  }
}
