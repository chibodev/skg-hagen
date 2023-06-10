import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:skg_hagen/src/aboutus/dto/aboutus.dart';
import 'package:skg_hagen/src/aboutus/repository/aboutusClient.dart';

import '../../mock/httpClientMock.dart';

void main() {
  late AboutUsClient subject;
  late MockDioHTTPClient httpClient;
  late MockNetwork network;
  final Options options = Options();

  setUpAll(() {
    subject = AboutUsClient();
    httpClient = MockDioHTTPClient();
    network = MockNetwork();
  });

  test('AboutUsClient successfully retrieves data', () async {
    when(network.hasInternet()).thenAnswer((_) async => false);
    when(httpClient.setOptions(httpClient, network, any)).thenAnswer((_) async => options);
    when(
      httpClient.getJSONResponse(
        http: httpClient,
        options: options,
        path: AboutUsClient.PATH,
        object: AboutUs,
        cacheData: AboutUsClient.CACHE_DATA,
      ),
    ).thenAnswer((_) async => HTTPClientMock.getJSONRequest(statusCode: HttpStatus.ok, path: 'aboutus.json'));

    final AboutUs? aboutUs = await subject.getData(httpClient, network, refresh: true);

    expect(aboutUs!.history, isNotEmpty);
    expect(aboutUs.history!.first.description!.contains('Die Ev.-Luth. Stadtkirchengemeinde Hagen'), true);
    expect(aboutUs.history!.first.url, 'https://www.youtube.com');
    expect(aboutUs.history!.first.urlFormat, 'video');

    expect(aboutUs.presbytery, isNotEmpty);
    expect(aboutUs.presbytery!.first.salutation, 'Frau');
    expect(aboutUs.presbytery!.first.surname, 'Bali');
    expect(aboutUs.presbytery!.first.firstname, 'Olympia');
    expect(aboutUs.presbytery!.first.description, 'She is nice lady');
    expect(aboutUs.presbytery!.length, 1);
  });

  test('AboutUsClient fails and throws Exception', () async {
    dynamic error;

    when(network.hasInternet()).thenAnswer((_) async => true);
    when(httpClient.setOptions(httpClient, network, any)).thenAnswer((_) async => options);
    when(
      httpClient.getJSONResponse(
        http: httpClient,
        options: options,
        path: AboutUsClient.PATH,
        object: AboutUs,
        cacheData: AboutUsClient.CACHE_DATA,
      ),
    ).thenAnswer((_) async => HTTPClientMock.getJSONRequest(statusCode: HttpStatus.unauthorized));

    try {
      await subject.getData(httpClient, network, index: 0, refresh: false);
    } catch (e) {
      error = e;
    }

    expect(error, isNotNull);
    expect(error is NoSuchMethodError, isTrue);
  });
}
