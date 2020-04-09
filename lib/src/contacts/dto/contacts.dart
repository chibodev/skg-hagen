import 'package:skg_hagen/src/common/dto/address.dart';
import 'package:skg_hagen/src/contacts/dto/contact.dart';
import 'package:skg_hagen/src/contacts/dto/social.dart';

class Contacts {
  List<Address> address;
  List<Contact> contact;
  List<Social> social;
  static const String NAME = 'Kontakte';
  static const String IMAGE = 'assets/images/kontakte.jpg';

  Contacts({
    this.address,
    this.contact,
    this.social,
  });

  factory Contacts.fromJson(Map<String, dynamic> json) => Contacts(
        address: List<Address>.from(
          json["address"].map(
            (dynamic x) => Address.fromJson(x),
          ),
        ),
        contact: List<Contact>.from(
          json["contact"].map(
            (dynamic x) => Contact.fromJson(x),
          ),
        ),
        social: List<Social>.from(
          json["social"].map(
            (dynamic x) => Social.fromJson(x),
          ),
        ),
      );
}
