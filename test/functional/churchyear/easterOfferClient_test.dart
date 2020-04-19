import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:skg_hagen/src/churchyear/dto/easterOffer.dart';
import 'package:skg_hagen/src/churchyear/repository/easterOfferClient.dart';
import 'package:skg_hagen/src/common/service/client/dioHttpClient.dart';
import 'package:skg_hagen/src/common/service/network.dart';

import '../../mock/httpClientMock.dart';

class MockDioHTTPClient extends Mock implements DioHTTPClient {}

class MockNetwork extends Mock implements Network {}

void main() {
  EasterOfferClient subject;
  MockDioHTTPClient httpClient;
  MockNetwork network;

  setUpAll(() {
    subject = EasterOfferClient();
    httpClient = MockDioHTTPClient();
    network = MockNetwork();
  });

  test('EasterOffcerClient successfully retrieves data', () async {
    when(network.hasInternet()).thenAnswer((_) async => false);
    when(
      httpClient.getJSONResponse(
        http: httpClient,
        path: 'app/churchyear/easter',
        object: EasterOffer,
        options: anyNamed('options'),
        cacheData: 'app/churchyear/easter/data',
      ),
    ).thenAnswer((_) async => HTTPClientMock.getJSONRequest(
        statusCode: HttpStatus.ok, path: 'easteroffer.json'));

    final EasterOffer easterOffer =
        await subject.getOffers(httpClient, network, refresh: true);

    expect(easterOffer.resurrectionStation.station, isNotEmpty);
    expect(easterOffer.resurrectionStation.station.first.title,
        '1. Station - Botschaft des Engels');
    expect(easterOffer.resurrectionStation.station.first.description, 'Test');
    expect(easterOffer.resurrectionStation.station.first.url,
        'https://google.com');
    expect(easterOffer.resurrectionStation.station.first.format, isNull);

    expect(easterOffer.resurrectionStation.info.title, 'Title');
    expect(easterOffer.resurrectionStation.info.description,
        'Sie sind herzlich eingeladen');
  });

  test('EasterOffcerClient fails and throws Exception', () async {
    DioError error;

    when(network.hasInternet()).thenAnswer((_) async => false);
    when(
      httpClient.getJSONResponse(
        http: httpClient,
        path: 'app/churchyear/easter',
        object: EasterOffer,
        options: anyNamed('options'),
        cacheData: 'app/churchyear/easter/data',
      ),
    ).thenAnswer((_) async =>
        HTTPClientMock.getJSONRequest(statusCode: HttpStatus.unauthorized));

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
