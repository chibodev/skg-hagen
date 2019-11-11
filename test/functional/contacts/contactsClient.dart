import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:skg_hagen/src/common/service/client/dioHttpClient.dart';
import 'package:skg_hagen/src/common/service/network.dart';
import 'package:skg_hagen/src/contacts/model/contacts.dart';
import 'package:skg_hagen/src/contacts/repository/contactsClient.dart';

import '../../mock/httpClientMock.dart';

class MockDioHTTPClient extends Mock implements DioHTTPClient {}

class MockNetwork extends Mock implements Network {}

void main() {
  ContactsClient subject;
  MockDioHTTPClient httpClient;
  MockNetwork network;

  setUpAll(() {
    subject = ContactsClient();
    httpClient = MockDioHTTPClient();
    network = MockNetwork();
  });

  test('ContactsClient successfully retrieves data', () async {
    when(network.hasInternet()).thenAnswer((_) async => false);
    when(
      httpClient.get(
        path: 'app/contact',
        options: anyNamed('options'),
      ),
    ).thenAnswer((_) async => HTTPClientMock.getRequest(
        statusCode: HttpStatus.ok, path: 'contacts.json'));

    final Contacts contacts =
        await subject.getContacts(httpClient, network, refresh: true);

    expect(contacts.address, isNotEmpty);
    expect(contacts.address.first.latLong, '51.3691938,7.4715299');
    expect(contacts.address.first.name, 'markuskirche');
    expect(contacts.address.first.street, 'Rheinstraße');
    expect(contacts.address.first.houseNumber, '26');
    expect(contacts.address.first.zip, '58097');
    expect(contacts.address.first.city, 'Hagen');
    expect(contacts.address.first.country, 'DE');
    expect(contacts.address.length, 2);

    expect(contacts.contact, isNotEmpty);
    expect(contacts.contact.first.title, 'Dr.');
    expect(contacts.contact.first.surname, 'Flöhoff');
    expect(contacts.contact.first.firstname, 'Angela');
    expect(contacts.contact.first.role, 'Gemeindebüro Markuskirche');
    expect(contacts.contact.first.phone, '02331 83929');
    expect(contacts.contact.first.email, 'flasshoffen@skg-hagen.de');
    expect(contacts.contact.first.administration, 1);
    expect(contacts.contact.first.opening, 'Mo, Di, Do und Fr 9-12Uhr | Mi 16 -18 Uhr');
    expect(contacts.contact.first.street, 'Rheineck');
    expect(contacts.contact.first.houseNumber, '30a');
    expect(contacts.contact.first.zip, '58090');
    expect(contacts.contact.first.city, 'Hagena');
    expect(contacts.contact.first.country, 'DE');
    expect(contacts.contact.length, 1);


    expect(contacts.social, isEmpty);
  });

  test('ContactsClient fails and throws Exception', () async {
    DioError error;

    when(network.hasInternet()).thenAnswer((_) async => false);
    when(
      httpClient.get(
        path: 'app/contact',
        options: anyNamed('options'),
      ),
    ).thenAnswer((_) async =>
        HTTPClientMock.getRequest(statusCode: HttpStatus.unauthorized));

    try {
      await subject.getContacts(httpClient, network, index: 0, refresh: false);
    } catch (e) {
      error = e;
    }

    expect(error, isNotNull);
    expect(error is Exception, isTrue);
    expect(error.error.statusCode, HttpStatus.unauthorized);
  });
}
