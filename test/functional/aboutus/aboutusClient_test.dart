import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:skg_hagen/src/aboutus/model/aboutus.dart';
import 'package:skg_hagen/src/aboutus/repository/aboutusClient.dart';
import 'package:skg_hagen/src/common/service/client/dioHttpClient.dart';
import 'package:skg_hagen/src/common/service/network.dart';

import '../../mock/httpClientMock.dart';

class MockDioHTTPClient extends Mock implements DioHTTPClient {}

class MockNetwork extends Mock implements Network {}

void main() {
  AboutUsClient subject;
  MockDioHTTPClient httpClient;
  MockNetwork network;

  setUpAll(() {
    subject = AboutUsClient();
    httpClient = MockDioHTTPClient();
    network = MockNetwork();
  });

  test('AboutUsClient successfully retrieves data', () async {
    when(network.hasInternet()).thenAnswer((_) async => false);
    when(
      httpClient.getJSONResponse(
        http: httpClient,
        object: AboutUs,
        cacheData: anyNamed('cacheData'),
        path: 'app/aboutus',
        options: anyNamed('options'),
      ),
    ).thenAnswer((_) async => HTTPClientMock.getJSONRequest(
        statusCode: HttpStatus.ok, path: 'aboutus.json'));

    final AboutUs aboutus =
        await subject.getData(httpClient, network, refresh: true);

    expect(aboutus.history, isNotEmpty);
    expect(
        aboutus.history.first.description
            .contains('Die Ev.-Luth. Stadtkirchengemeinde Hagen'),
        true);
    expect(aboutus.history.first.url, 'https://www.youtube.com');
    expect(aboutus.history.first.urlFormat, 'video');

    expect(aboutus.presbytery, isNotEmpty);
    expect(aboutus.presbytery.first.salutation, 'Frau');
    expect(aboutus.presbytery.first.surname, 'Bali');
    expect(aboutus.presbytery.first.firstname, 'Olympia');
    expect(aboutus.presbytery.first.description, 'She is nice lady');
    expect(aboutus.presbytery.length, 1);
  });

  test('AboutUsClient fails and throws Exception', () async {
    DioError error;

    when(network.hasInternet()).thenAnswer((_) async => false);
    when(
      httpClient.getJSONResponse(
        http: httpClient,
        object: AboutUs,
        cacheData: anyNamed('cacheData'),
        path: 'app/aboutus',
        options: anyNamed('options'),
      ),
    ).thenAnswer((_) async =>
        HTTPClientMock.getJSONRequest(statusCode: HttpStatus.unauthorized));

    try {
      await subject.getData(httpClient, network, index: 0, refresh: false);
    } catch (e) {
      error = e;
    }

    expect(error, isNotNull);
    expect(error is Exception, isTrue);
    expect(error.error.statusCode, HttpStatus.unauthorized);
  });
}
