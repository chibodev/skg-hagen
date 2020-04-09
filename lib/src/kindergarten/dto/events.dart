import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:skg_hagen/src/common/dto/address.dart';

class Events {
  static const String NAME = 'Events';

  final String title;
  final DateTime occurrence;
  final String time;
  final String comment;
  final String placeName;
  Address address;
  final String name;
  final String street;
  final String houseNumber;
  final String zip;
  final String city;
  final String country;
  final String latLong;

  Events(
      {this.title,
      this.occurrence,
      this.time,
      this.comment,
      this.placeName,
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
        latLong: latLong,
        country: country);
  }

  factory Events.fromJson(Map<String, dynamic> json) => Events(
      title: json['title'],
      occurrence: DateTime.parse(json['occurrence']),
      time: json["time"],
      comment: json["comment"] == null ? "" : json["comment"],
      placeName: json["placeName"],
      name: json["name"] == null || json["name"] == "" ? null : json["name"],
      street: json["street"] == null || json["street"] == ""
          ? null
          : json["street"],
      houseNumber: json["houseNumber"] == null || json["houseNumber"] == ""
          ? null
          : json["houseNumber"],
      zip: json["zip"] == null || json["zip"] == "" ? null : json["zip"],
      city: json["city"] == null || json["city"] == "" ? null : json["city"],
      country: json["country"] == null || json["country"] == ""
          ? null
          : json["country"],
      latLong: json["latLong"] == null || json["latLong"] == ""
          ? null
          : json['latLong']);

  String getFormattedOccurrence() {
    initializeDateFormatting('de_DE', null);
    final List<String> timeSplit =
        this.time == "00:00:00" ? null : this.time.split(':');
    if (timeSplit == null) {
      return DateFormat("E d.M.yy", "de_DE")
          .format(this.occurrence)
          .toLowerCase()
          .toUpperCase();
    }

    final DateTime dateTime = DateTime(
        this.occurrence.year,
        this.occurrence.month,
        this.occurrence.day,
        int.parse(timeSplit[0]),
        int.parse(timeSplit[1]));

    return DateFormat("E d.M.yy | HH:mm", "de_DE")
        .format(dateTime)
        .toString()
        .toUpperCase();
  }
}
