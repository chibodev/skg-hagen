import 'package:skg_hagen/src/common/dto/address.dart';

class Contact {
  static const int URL_MIN = 7;
  static const String NAME = 'Kontakte';

  String title;
  String surname;
  String firstname;
  String role;
  String phone;
  String email;
  String? imageUrl;
  int administration;
  String opening;
  String? name;
  String street;
  String houseNumber;
  String zip;
  String city;
  String country;
  late Address address;

  Contact({
    required this.title,
    required this.surname,
    required this.firstname,
    required this.role,
    required this.phone,
    required this.email,
    this.imageUrl,
    required this.administration,
    required this.opening,
    this.name,
    required this.street,
    required this.houseNumber,
    required this.zip,
    required this.city,
    required this.country,
  }) {
    this.address = Address(
        name: name,
        street: street,
        houseNumber: houseNumber,
        zip: zip,
        city: city,
        country: country);
  }

  factory Contact.fromJson(Map<String, dynamic> json) => Contact(
        title: json["title"],
        surname: json["surname"],
        firstname: json["firstname"],
        role: json["role"],
        phone: json["phone"],
        email: json["email"],
        imageUrl: json['imageUrl'].toString().length > URL_MIN
            ? json['imageUrl']
            : null,
        administration: int.parse(json["administration"]),
        opening: json["opening"],
        name:
            (json["name"] == "--" || json["name"] == "") ? null : json["name"],
        street: json["street"],
        houseNumber: json["houseNumber"],
        zip: json["zip"],
        city: json["city"],
        country: json["country"],
      );

  String getContactName() {
    return title == "" ? "$firstname $surname" : "$firstname $surname ($title)";
  }
}
