import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:skg_hagen/src/common/model/address.dart';

class Appointment {
  Address address;
  final String title;
  final DateTime occurrence;
  final String time;
  final String placeName;
  final String room;
  final String infoTitle;
  final String organizer;
  final String email;
  final String name;
  final String street;
  final String houseNumber;
  final String zip;
  final String city;
  final String country;
  final String latLong;

  Appointment({
    this.title,
    this.occurrence,
    this.time,
    this.placeName,
    this.room,
    this.infoTitle,
    this.organizer,
    this.email,
    this.name,
    this.street,
    this.houseNumber,
    this.zip,
    this.city,
    this.country,
    this.latLong
  }) {
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

  factory Appointment.fromJson(Map<String, dynamic> json) {
    return Appointment(
      title: json["title"],
      occurrence: DateTime.parse(json["occurrence"]),
      time: json["time"],
      placeName: json["placeName"],
      room: json["room"],
        infoTitle: json["infoTitle"] == "" ? null : json["infoTitle"],
      organizer: json["organizer"],
      email: json["email"] == "" ? null : json["email"],
      name: json["name"] == null ? null : json["name"],
      street: json["street"] == null ? null : json["street"],
      houseNumber: json["houseNumber"] == null ? null : json["houseNumber"],
      zip: json["zip"] == null ? null : json["zip"],
      city: json["city"] == null ? null : json["city"],
      country: json["country"] == null ? null : json["country"],
      latLong: json["latLong"] == null ? null : json['latLong']
    );
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        "title": title,
        "occurrence":
            "${occurrence.year.toString().padLeft(4, '0')}-${occurrence.month.toString().padLeft(2, '0')}-${occurrence.day.toString().padLeft(2, '0')}",
        "time": time,
        "placeName": placeName,
        "room": room,
        "organizer": organizer,
        "email": email,
        "name": name,
        "street": street,
        "houseNumber": houseNumber,
        "zip": zip,
        "city": city,
        "country": country,
      };

  String getFormattedTime() {
    initializeDateFormatting('de_DE', null);
    final List<String> timeSplit = time.split(':');
    final DateTime dateTime = DateTime(occurrence.year, occurrence.month,
        occurrence.day, int.parse(timeSplit[0]), int.parse(timeSplit[1]));
    return DateFormat("E d.M.yy | HH:mm", "de_DE")
        .format(dateTime)
        .toString()
        .toUpperCase();
  }

  String getFormattedOrganiser() {
    String text;

    if (organizer != null) {
      text = infoTitle != null ? "$infoTitle: $organizer" : organizer;
    }

    return text;
  }
}
