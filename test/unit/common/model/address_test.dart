import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:skg_hagen/src/common/model/address.dart';

void main() {
  Address subject;
  String name;
  String street;
  String houseNumber;
  String zip;
  String city;
  String country;
  String json;

  setUpAll(() {
    name = 'Test';
    street = 'Street';
    houseNumber = '23A';
    zip = '67896';
    city = 'Testy';
    country = 'TE';
    json =
        '{"name": "Markuskirche","street": "Rheinstraße","houseNumber": "26","zip": "58097","city": "Hagen","country": "DE","room": "Jugendcontainer"}';

    subject = Address(
        name: name,
        street: street,
        houseNumber: houseNumber,
        zip: zip,
        city: city,
        country: country);
  });

  test('Address gets correct formatted property', () {
    expect(subject.getZipAndCity(), '$zip $city');
  });

  test('Address successfully converts json string', () {
    final Address subjectJson = Address.fromJson(jsonDecode(json));

    expect(subjectJson.name, 'Markuskirche');
    expect(subjectJson.street, 'Rheinstraße');
    expect(subjectJson.houseNumber, '26');
    expect(subjectJson.zip, '58097');
    expect(subjectJson.city, 'Hagen');
    expect(subjectJson.country, 'DE');
    expect(subjectJson.room, 'Jugendcontainer');
  });

  test('Address successfully converts to json string', () {
    final Map<String, dynamic> payload = subject.toJson();
    final String jsonPayload = jsonEncode(payload);

    expect(payload['name'], 'Test');
    expect(payload['street'], 'Street');
    expect(payload['houseNumber'], '23A');
    expect(payload['zip'], '67896');
    expect(payload['city'], 'Testy');
    expect(payload['country'], 'TE');
    expect(payload['room'], null);

    expect(jsonPayload,
        '{"name":"Test","street":"Street","houseNumber":"23A","zip":"67896","city":"Testy","country":"TE","room":null}');
  });
}
