import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:skg_hagen/src/common/service/client/dioHttpClient.dart';
import 'package:skg_hagen/src/common/service/network.dart';
import 'package:skg_hagen/src/kindergarten/model/kindergarten.dart';
import 'package:skg_hagen/src/kindergarten/repository/kindergartenClient.dart';

import '../../mock/httpClientMock.dart';

class MockDioHTTPClient extends Mock implements DioHTTPClient {}

class MockNetwork extends Mock implements Network {}

void main() {
  KindergartenClient subject;
  MockDioHTTPClient client;
  MockNetwork network;

  setUpAll(() {
    subject = KindergartenClient();
    client = MockDioHTTPClient();
    network = MockNetwork();
  });

  test('KindergartenClient successfully retrieves data', () async {
    when(network.hasInternet()).thenAnswer((_) async => false);
    when(
      client.getJSONResponse(
          http: client,
          path: 'app/kindergarten',
          object: Kindergarten,
          options: anyNamed('options'),
          cacheData: anyNamed('cacheData')),
    ).thenAnswer((_) async => HTTPClientMock.getJSONRequest(
        statusCode: HttpStatus.ok, path: 'kindergarten.json'));

    final Kindergarten kindergarten =
        await subject.getAppointments(client, network, refresh: true);

    expect(kindergarten.events, isNotEmpty);
    expect(
        kindergarten.events.first.title, 'Demonstration gegen Bienensterben');
    expect(kindergarten.events.first.occurrence, DateTime.parse('2019-09-27'));
    expect(kindergarten.events.first.time, '00:00:00');
    expect(
        kindergarten.events.first.comment
            .contains('Das sagen die Kinder verschiedener Kitas in Hagen'),
        true);
    expect(kindergarten.events.first.placeName, 'kindergarten');
    expect(kindergarten.events.first.name, 'kindergarten');
    expect(kindergarten.events.first.street, 'Rheinstraße');
    expect(kindergarten.events.first.houseNumber, '26a');
    expect(kindergarten.events.first.zip, '58097');
    expect(kindergarten.events.first.city, 'Hagen');
    expect(kindergarten.events.first.country, 'DE');
    expect(kindergarten.events.length, 2);

    expect(kindergarten.news, isNotEmpty);
    expect(kindergarten.news.first.title, 'Aktion der Nächstenliebe');
    expect(
        kindergarten.news.first.description
            .contains('Jedes Jahr findet zu Weihnachten'),
        true);
    expect(kindergarten.news.first.url, 'https://someUrl');
    expect(kindergarten.news.first.fileUrl, 'https://Formular.pdf');
    expect(kindergarten.news.first.urlFormat, null);
    expect(kindergarten.news.first.format, 'pdf');
    expect(kindergarten.news.first.filename, 'Formular.pdf');
    expect(kindergarten.news.length, 1);
  });

  test('KindergartenClient fails and throws Exception', () async {
    DioError error;

    when(network.hasInternet()).thenAnswer((_) async => false);
    when(
      client.getJSONResponse(
          http: client,
          path: 'app/kindergarten',
          object: Kindergarten,
          options: anyNamed('options'),
          cacheData: anyNamed('cacheData')),
    ).thenAnswer((_) async =>
        HTTPClientMock.getJSONRequest(statusCode: HttpStatus.unauthorized));

    try {
      await subject.getAppointments(client, network, index: 0, refresh: false);
    } catch (e) {
      error = e;
    }

    expect(error, isNotNull);
    expect(error is Exception, isTrue);
    expect(error.error.statusCode, HttpStatus.unauthorized);
  });

  test('FileDownload test pass', () async {
    when(client.downloadFile(
            http: client, urlPath: 'fileUrl', savePath: 'filePath'))
        .thenAnswer((_) async => true);

    final bool name = await client.downloadFile(
        http: client, urlPath: 'fileUrl', savePath: 'filePath');
    assert(name, isTrue);
  });

  test('FileDownload test fails', () async {
    when(client.downloadFile(
            http: client, urlPath: 'fileUrlError', savePath: 'filePath'))
        .thenAnswer((_) async => false);

    final bool result = await client.downloadFile(
        http: client, urlPath: 'fileUrlError', savePath: 'filePath');

    assert(result != true, true);
  });
}
