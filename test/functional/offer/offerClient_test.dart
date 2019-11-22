import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:skg_hagen/src/common/service/client/dioHttpClient.dart';
import 'package:skg_hagen/src/common/service/network.dart';
import 'package:skg_hagen/src/offer/model/offers.dart';
import 'package:skg_hagen/src/offer/repository/offerClient.dart';

import '../../mock/httpClientMock.dart';

class MockDioHTTPClient extends Mock implements DioHTTPClient {}

class MockNetwork extends Mock implements Network {}

void main() {
  OfferClient subject;
  MockDioHTTPClient httpClient;
  MockNetwork network;

  setUpAll(() {
    subject = OfferClient();
    httpClient = MockDioHTTPClient();
    network = MockNetwork();
  });

  test('OfferClient successfully retrieves data', () async {
    when(network.hasInternet()).thenAnswer((_) async => false);
    when(
      httpClient.getResponse(
        http: httpClient,
        path: 'app/offers',
        object: Offers,
        options: anyNamed('options'),
        cacheData: 'app/offers/data',
      ),
    ).thenAnswer((_) async => HTTPClientMock.getRequest(
        statusCode: HttpStatus.ok, path: 'offers.json'));

    final Offers offers =
        await subject.getOffers(httpClient, network, refresh: true);

    expect(offers.offers, isNotEmpty);
    expect(offers.offers.first.title, 'Crossover SKG-Band');
    expect(offers.offers.first.occurrence, 'Donnerstags');
    expect(offers.offers.first.time, '18:00:00');
    expect(offers.offers.first.placeName, 'markuskirche');
    expect(offers.offers.first.room, 'room');
    expect(offers.offers.first.organizer, 'Jonas Lehmann');
    expect(offers.offers.first.email, 'leimann@gmail.com');
    expect(offers.offers.first.ageStart, 4);
    expect(offers.offers.first.ageEnd, 10);
    expect(offers.offers.first.schoolYear, '');
    expect(offers.offers.first.name, 'markuskirche');
    expect(offers.offers.first.street, 'Rheinstraße');
    expect(offers.offers.first.houseNumber, '26');
    expect(offers.offers.first.zip, '58097');
    expect(offers.offers.first.city, 'Hagen');
    expect(offers.offers.first.country, 'DE');
    expect(offers.offers.length, 2);

    expect(offers.groups, isNotEmpty);
    expect(
        offers.groups.last.title, 'Frauenhilfe (Infos bei den Pfarrerinnen)');
    expect(offers.groups.last.occurrence, 'Mittwochs');
    expect(offers.groups.last.time, '15:00:00');
    expect(offers.groups.last.placeName, 'markuskirche');
    expect(offers.groups.last.room, isNull);
    expect(offers.groups.last.organizer, '');
    expect(offers.groups.last.email, '');
    expect(offers.groups.last.name, 'markuskirche');
    expect(offers.groups.last.street, 'Rheinstraße');
    expect(offers.groups.last.houseNumber, '26');
    expect(offers.groups.last.zip, '58097');
    expect(offers.groups.last.city, 'Hagen');
    expect(offers.groups.last.country, 'DE');
    expect(offers.groups.length, 2);
  });

  test('OfferClient fails and throws Exception', () async {
    DioError error;

    when(network.hasInternet()).thenAnswer((_) async => false);
    when(
      httpClient.getResponse(
        http: httpClient,
        path: 'app/offers',
        object: Offers,
        options: anyNamed('options'),
        cacheData: 'app/offers/data',
      ),
    ).thenAnswer((_) async =>
        HTTPClientMock.getRequest(statusCode: HttpStatus.unauthorized));

    try {
      await subject.getOffers(httpClient, network, index: 0, refresh: false);
    } catch (e) {
      error = e;
    }

    expect(error, isNotNull);
    expect(error is Exception, isTrue);
    expect(error.error.statusCode, HttpStatus.unauthorized);
  });
}
