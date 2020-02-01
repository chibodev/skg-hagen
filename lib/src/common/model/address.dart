import 'package:skg_hagen/src/common/model/default.dart';

class Address {
  static const String MAP_IMAGE_JOHANNISKIRCHE = 'assets/images/johanniskirche.jpg';
  static const String MAP_IMAGE_MARKUSKIRCHE = 'assets/images/markuskirche.jpg';
  static const String NAME = 'Adresse';

  final String name;
  final String street;
  final String houseNumber;
  final String zip;
  final String city;
  final String country;
  final String room;
  final String latLong;

  Address(
      {this.name,
      this.street,
      this.houseNumber,
      this.zip,
      this.city,
      this.country,
      this.room,
      this.latLong});

  factory Address.fromJson(Map<String, dynamic> json) => Address(
        name: json["name"] == null ? null : json['name'],
        street: json["street"] == null ? null : json['street'],
        houseNumber: json["houseNumber"] == null ? null : json['houseNumber'],
        zip: json["zip"] == null ? null : json['zip'],
        city: json["city"] == null ? null : json['city'],
        country: json["country"] == null ? null : json['country'],
        latLong: json["latLong"] == null ? null : json['latLong'],
        room: json["room"] == null ? null : json['room'],
      );

  Map<String, dynamic> toJson() => <String, dynamic>{
        'name': name == null ? null : this.name,
        'street': street == null ? null : this.street,
        'houseNumber': houseNumber == null ? null : this.houseNumber,
        'zip': zip == null ? null : this.zip,
        'city': city == null ? null : this.city,
        'country': country == null ? null : this.country,
        'room': room == null ? null : this.room,
      };

  String getStreetAndNumber() {
    return '$street $houseNumber';
  }

  String getZipAndCity() {
    return '$zip $city';
  }

  String getCapitalizedAddressName() {
    return (name == '' || name == null) ? '' : Default.capitalize(name);
  }
}
