import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:skg_hagen/src/kindergarten/dto/kindergarten.dart';
import 'package:skg_hagen/src/kindergarten/repository/kindergartenClient.dart';

import '../../mock/httpClientMock.dart';

void main() {
  late KindergartenClient subject;
  late MockDioHTTPClient httpClient;
  late MockNetwork network;
  final Options options = Options();

  setUpAll(() {
    subject = KindergartenClient();
    httpClient = MockDioHTTPClient();
    network = MockNetwork();
  });

  test('KindergartenClient successfully retrieves data', () async {
    when(network.hasInternet()).thenAnswer((_) async => false);
    when(httpClient.setOptions(httpClient, network, any))
        .thenAnswer((_) async => options);
    when(
      httpClient.getJSONResponse(
        http: httpClient,
        options: options,
        path: KindergartenClient.PATH,
        object: Kindergarten,
        cacheData: KindergartenClient.CACHE_DATA,
      ),
    ).thenAnswer((_) async => HTTPClientMock.getJSONRequest(
        statusCode: HttpStatus.ok, path: 'kindergarten.json'));

    final Kindergarten? kindergarten =
        await subject.getAppointments(httpClient, network, refresh: true);

    expect(kindergarten!.events, isNotEmpty);
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
    dynamic error;

    when(network.hasInternet()).thenAnswer((_) async => false);
    when(httpClient.setOptions(httpClient, network, any))
        .thenAnswer((_) async => options);
    when(
      httpClient.getJSONResponse(
        http: httpClient,
        options: options,
        path: KindergartenClient.PATH,
        object: Kindergarten,
        cacheData: KindergartenClient.CACHE_DATA,
      ),
    ).thenAnswer((_) async =>
        HTTPClientMock.getJSONRequest(statusCode: HttpStatus.unauthorized));

    try {
      await subject.getAppointments(httpClient, network,
          index: 0, refresh: false);
    } catch (e) {
      error = e;
    }

    expect(error, isNotNull);
    expect(error is NoSuchMethodError, isTrue);
  });

  test('FileDownload test pass', () async {
    when(httpClient.downloadFile(
            http: httpClient, urlPath: 'fileUrl', savePath: 'filePath'))
        .thenAnswer((_) async => true);

    final bool result = await httpClient.downloadFile(
        http: httpClient, urlPath: 'fileUrl', savePath: 'filePath');
    assert(result, isTrue);
  });

  test('FileDownload test fails', () async {
    when(httpClient.downloadFile(
            http: httpClient, urlPath: 'fileUrlError', savePath: 'filePath'))
        .thenAnswer((_) async => false);

    final bool result = await httpClient.downloadFile(
        http: httpClient, urlPath: 'fileUrlError', savePath: 'filePath');
    assert(result != true, true);
  });
}
