import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:skg_hagen/src/common/dto/address.dart';

class Appointment {
  static const String NAME = 'Termine';
  static const String PAGE_NAME = 'Konfi-Termine';

  Address address;
  final String title;
  final DateTime occurrence;
  final String time;
  final DateTime endOccurrence;
  final String endTime;
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

  Appointment(
      {this.title,
      this.occurrence,
      this.time,
      this.endOccurrence,
      this.endTime,
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
      this.latLong}) {
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
        endOccurrence: json["endtime"] == "00:00:00"
            ? null
            : DateTime.parse(json["endoccurrence"]),
        endTime: json["endtime"] == "00:00:00" ? null : json["endtime"],
        placeName: json["placeName"],
        room: json["room"],
        infoTitle: json["infoTitle"] == "" ? null : json["infoTitle"],
        organizer: json["organizer"] == null || json["organizer"] == ""
            ? null
            : json["organizer"],
        email: json["email"] == "" ? null : json["email"],
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

  DateTime getFormattedTime() {
    return _convertToDateTime(this.occurrence, this.time);
  }

  DateTime getFormattedClosingTime() {
    return _convertToDateTime(this.endOccurrence, this.endTime);
  }

  String getFormattedTimeAsString() {
    initializeDateFormatting('de_DE', null);
    String formattedTime = '';

    if (this.endOccurrence != null) {
      formattedTime = this.endOccurrence == this.occurrence
          ? "${_getDateFormat('E d.M.yy | HH:mm', getFormattedTime())} - ${_getDateFormat('HH:mm', getFormattedClosingTime())}"
          : "${_getDateFormat("E d.M.yy | HH:mm", getFormattedTime())} - ${_getDateFormat("E d.M.yy | HH:mm", getFormattedClosingTime())}";
    } else {
      formattedTime = _getDateFormat("E d.M.yy | HH:mm", getFormattedTime());
    }

    return formattedTime;
  }

  String getFormattedOrganiser() {
    String text;

    if (organizer != null) {
      text = infoTitle != null ? "$infoTitle: $organizer" : organizer;
    }

    return text;
  }

  DateTime _convertToDateTime(DateTime occurrence, String time) {
    initializeDateFormatting('de_DE', null);
    final List<String> timeSplit = time.split(':');
    return DateTime(occurrence.year, occurrence.month, occurrence.day,
        int.parse(timeSplit[0]), int.parse(timeSplit[1]));
  }

  String _getDateFormat(String format, DateTime dateTime) {
    return DateFormat("$format", "de_DE")
        .format(dateTime)
        .toString()
        .toUpperCase();
  }
}
