import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:skg_hagen/src/home/dto/aid.dart';
import 'package:skg_hagen/src/home/repository/aidClient.dart';

import '../../mock/httpClientMock.dart';

void main() {
  late AidClient subject;
  late MockDioHTTPClient httpClient;
  late MockNetwork network;
  final Options options = Options();

  setUpAll(() {
    subject = AidClient();
    httpClient = MockDioHTTPClient();
    network = MockNetwork();
  });

  test('AidClient successfully retrieves data', () async {
    when(network.hasInternet()).thenAnswer((_) async => false);
    when(httpClient.setOptions(httpClient, network, any))
        .thenAnswer((_) async => options);
    when(
      httpClient.getJSONResponse(
        http: httpClient,
        options: options,
        path: AidClient.PATH,
        object: Aid,
        cacheData: AidClient.CACHE_DATA,
      ),
    ).thenAnswer((_) async => HTTPClientMock.getJSONRequest(
        statusCode: HttpStatus.ok, path: 'aid.json'));

    final Aid? aid = await subject.getAid(httpClient, network);

    expect(aid!.title, 'Corona-Hinweis / Nachbarschafts-Hilfe');
    expect(
        aid.description!
            .contains('Einkaufen, Gassi gehen, Botendienste erledigen.'),
        isTrue);
    expect(aid.phone, '023464 83929');
    expect(aid.email, 'corona-hilfe@hagen.de');
  });

  test('AidClient fails', () async {
    final Aid? result;

    when(network.hasInternet()).thenAnswer((_) async => true);
    when(httpClient.setOptions(httpClient, network, any))
        .thenAnswer((_) async => options);
    when(
      httpClient.getJSONResponse(
        http: httpClient,
        options: options,
        path: AidClient.PATH,
        object: Aid,
        cacheData: AidClient.CACHE_DATA,
      ),
    ).thenAnswer((_) async =>
        HTTPClientMock.getJSONRequest(statusCode: HttpStatus.unauthorized));

    result =
        await subject.getAid(httpClient, network, index: 0, refresh: false);

    expect(result?.description, isNull);
    expect(result?.email, isNull);
    expect(result?.phone, isNull);
    expect(result?.title, isNull);
  });
}
