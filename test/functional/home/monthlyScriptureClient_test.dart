import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:skg_hagen/src/common/service/client/dioHttpClient.dart';
import 'package:skg_hagen/src/common/service/network.dart';
import 'package:skg_hagen/src/home/model/monthlyScripture.dart';
import 'package:skg_hagen/src/home/repository/monthlyScriptureClient.dart';

import '../../mock/httpClientMock.dart';

class MockDioHTTPClient extends Mock implements DioHTTPClient {}

class MockNetwork extends Mock implements Network {}

void main() {
  MonthlyScriptureClient subject;
  MockDioHTTPClient httpClient;
  MockNetwork network;

  setUpAll(() {
    subject = MonthlyScriptureClient();
    httpClient = MockDioHTTPClient();
    network = MockNetwork();
  });

  test('MonthlyScriptureClient successfully retrieves data', () async {
    final String filename = 'monthlyScripture.html';

    when(network.hasInternet()).thenAnswer((_) async => false);
    when(
      httpClient.getHTMLResponse(
        http: httpClient,
        cacheData: anyNamed('cacheData'),
        path: anyNamed('path'),
        options: anyNamed('options'),
      ),
    ).thenAnswer(
      (_) async => HTTPClientMock.getHTMLRequest(
          statusCode: HttpStatus.ok, path: filename),
    );

    final MonthlyScripture verse = await subject.getDevotion(httpClient, network);

    expect(verse.oldTestamentText.contains('Wer wird uns Gutes sehen lassen?'), true);
    expect(verse.newTestamentText.contains('Ich bin das Licht der Welt.'), true);
  });
}
