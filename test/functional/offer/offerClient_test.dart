import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:skg_hagen/src/offer/dto/offers.dart';
import 'package:skg_hagen/src/offer/repository/offerClient.dart';

import '../../mock/httpClientMock.dart';

void main() {
  late OfferClient subject;
  late MockDioHTTPClient httpClient;
  late MockNetwork network;
  final Options options = Options();

  setUpAll(() {
    subject = OfferClient();
    httpClient = MockDioHTTPClient();
    network = MockNetwork();
  });

  test('OfferClient successfully retrieves data', () async {
    when(network.hasInternet()).thenAnswer((_) async => true);
    when(httpClient.setOptions(httpClient, network, any)).thenAnswer((_) async => options);
    when(
      httpClient.getJSONResponse(
        http: httpClient,
        options: options,
        path: OfferClient.PATH,
        object: Offers,
        cacheData: OfferClient.CACHE_DATA,
      ),
    ).thenAnswer((_) async => HTTPClientMock.getJSONRequest(statusCode: HttpStatus.ok, path: 'offers.json'));

    final Offers? offers = await subject.getOffers(httpClient, network, refresh: true);

    expect(offers!.offers, isNotEmpty);
    expect(offers.offers!.first.title, 'Crossover SKG-Band');
    expect(offers.offers!.first.occurrence, 'Donnerstags');
    expect(offers.offers!.first.time, '18:00:00');
    expect(offers.offers!.first.placeName, 'markuskirche');
    expect(offers.offers!.first.room, 'room');
    expect(offers.offers!.first.organizer, 'Jonas Lehmann');
    expect(offers.offers!.first.email, 'leimann@gmail.com');
    expect(offers.offers!.first.ageStart, 4);
    expect(offers.offers!.first.ageEnd, 10);
    expect(offers.offers!.first.schoolYear, '');
    expect(offers.offers!.first.name, 'markuskirche');
    expect(offers.offers!.first.street, 'Rheinstraße');
    expect(offers.offers!.first.houseNumber, '26');
    expect(offers.offers!.first.zip, '58097');
    expect(offers.offers!.first.city, 'Hagen');
    expect(offers.offers!.first.country, 'DE');
    expect(offers.offers!.first.url, 'https://someUrl');
    expect(offers.offers!.first.urlFormat, 'audio');
    expect(offers.offers!.length, 2);

    expect(offers.projects, isNotEmpty);
    expect(offers.projects!.first.title, 'New');
    expect(offers.projects!.first.description.contains('Project description'), true);
    expect(offers.projects!.length, 1);

    expect(offers.music, isNotEmpty);
    expect(offers.music!.first.description, 'Der Kinderchor - unter der Leitung Meister Meistermann');
    expect(offers.music!.first.occurrence, 'Montags');
    expect(offers.music!.first.time, '16:15:00');
    expect(offers.music!.first.placeName, 'marchurch');
    expect(offers.music!.first.room, 'Großer Saal');
    expect(offers.music!.first.email, '');
    expect(offers.music!.first.name, 'marchurch');
    expect(offers.music!.first.street, 'MaxStr');
    expect(offers.music!.first.houseNumber, '20');
    expect(offers.music!.first.zip, '58090');
    expect(offers.music!.first.city, 'Hagen');
    expect(offers.music!.first.country, 'DE');
    expect(offers.music!.first.latLong, 'lat&Long');
    expect(offers.music!.length, 1);
  });

  test('OfferClient fails and throws Exception', () async {
    Offers? offers;

    when(network.hasInternet()).thenAnswer((_) async => false);
    when(httpClient.setOptions(httpClient, network, any)).thenAnswer((_) async => options);
    when(
      httpClient.getJSONResponse(
        http: httpClient,
        options: options,
        path: OfferClient.PATH,
        object: Offers,
        cacheData: OfferClient.CACHE_DATA,
      ),
    ).thenAnswer((_) async => HTTPClientMock.getJSONRequest(statusCode: HttpStatus.unauthorized));

    offers = await subject.getOffers(httpClient, network, index: 0, refresh: false);

    expect(offers, isNotNull);
    expect(offers?.offers, isNull);
    expect(offers?.music, isNull);
    expect(offers?.projects, isNull);
  });
}
