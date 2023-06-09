import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:skg_hagen/src/churchyear/dto/easterOffer.dart';
import 'package:skg_hagen/src/churchyear/repository/easterOfferClient.dart';

import '../../mock/httpClientMock.dart';

void main() {
  late EasterOfferClient subject;
  late MockDioHTTPClient httpClient;
  late MockNetwork network;
  final Options options = Options();

  setUpAll(() {
    subject = EasterOfferClient();
    httpClient = MockDioHTTPClient();
    network = MockNetwork();
  });

  test('EasterOffcerClient successfully retrieves data', () async {
    when(network.hasInternet()).thenAnswer((_) async => false);
    when(httpClient.setOptions(httpClient, network, any))
        .thenAnswer((_) async => options);
    when(
      httpClient.getJSONResponse(
        http: httpClient,
        options: options,
        path: 'app/churchyear/easter',
        object: EasterOffer,
        cacheData: EasterOfferClient.CACHE_DATA,
      ),
    ).thenAnswer((_) async => HTTPClientMock.getJSONRequest(
        statusCode: HttpStatus.ok, path: 'easteroffer.json'));

    final EasterOffer? easterOffer =
        await subject.getOffers(httpClient, network, refresh: true);

    expect(easterOffer!.resurrectionStation.station, isNotEmpty);
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
    dynamic error;

    when(network.hasInternet()).thenAnswer((_) async => false);
    when(httpClient.setOptions(httpClient, network, any))
        .thenAnswer((_) async => options);
    when(
      httpClient.getJSONResponse(
        http: httpClient,
        options: options,
        path: 'app/churchyear/easter',
        object: EasterOffer,
        cacheData: EasterOfferClient.CACHE_DATA,
      ),
    ).thenAnswer((_) async =>
        HTTPClientMock.getJSONRequest(statusCode: HttpStatus.unauthorized));

    try {
      await subject.getOffers(httpClient, network, index: 0, refresh: false);
    } catch (e) {
      error = e;
    }

    expect(error, isNotNull);
    expect(error is TypeError, isTrue);
  });
}
