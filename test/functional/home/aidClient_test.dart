import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:skg_hagen/src/common/service/client/dioHttpClient.dart';
import 'package:skg_hagen/src/common/service/network.dart';
import 'package:skg_hagen/src/home/model/aid.dart';
import 'package:skg_hagen/src/home/repository/aidClient.dart';

import '../../mock/httpClientMock.dart';

class MockDioHTTPClient extends Mock implements DioHTTPClient {}

class MockNetwork extends Mock implements Network {}

void main() {
  AidClient subject;
  MockDioHTTPClient httpClient;
  MockNetwork network;

  setUpAll(() {
    subject = AidClient();
    httpClient = MockDioHTTPClient();
    network = MockNetwork();
  });

  test('AidClient successfully retrieves data', () async {
    when(
      httpClient.getJSONResponse(
        http: httpClient,
        path: 'app/aid',
        object: Aid,
        options: anyNamed('options'),
        cacheData: 'app/aid/data',
      ),
    ).thenAnswer((_) async => HTTPClientMock.getJSONRequest(
        statusCode: HttpStatus.ok, path: 'aid.json'));

    final Aid aid = await subject.getAid(httpClient, network);

    expect(aid.title, 'Corona-Hinweis / Nachbarschafts-Hilfe');
    expect(
        aid.description
            .contains('Einkaufen, Gassi gehen, Botendienste erledigen.'),
        isTrue);
    expect(aid.phone, '023464 83929');
    expect(aid.email, 'corona-hilfe@hagen.de');
  });

  test('AidClient fails and throws Exception', () async {
    DioError error;
    when(
      httpClient.getJSONResponse(
        http: httpClient,
        path: 'app/aid',
        object: Aid,
        options: anyNamed('options'),
        cacheData: 'app/aid/data',
      ),
    ).thenAnswer((_) async =>
        HTTPClientMock.getJSONRequest(statusCode: HttpStatus.unauthorized));

    try {
      await subject.getAid(httpClient, network, index: 0, refresh: false);
    } catch (e) {
      error = e;
    }

    expect(error, isNotNull);
    expect(error is Exception, isTrue);
    expect(error.error.statusCode, HttpStatus.unauthorized);
  });
}
