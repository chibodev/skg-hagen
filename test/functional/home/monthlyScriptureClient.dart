import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:skg_hagen/src/common/model/dioHttpClient.dart';
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
    when(network.hasInternet()).thenAnswer((_) async => false);
    when(httpClient.get(
            path: 'app/monthly-devotion', options: anyNamed('options')))
        .thenAnswer((_) async =>
            HTTPClientMock.monthlyScriptureGet(statusCode: HttpStatus.ok));

    final MonthlyScripture verse = await subject.getVerse(httpClient, network);

    expect(verse.text, 'Suchet der Stadt Beste');
    expect(verse.book, 'Jeremia');
    expect(verse.chapter, '27');
    expect(verse.verse, '12');
  });

  test('MonthlyScriptureClient fails and throws Exception', () async {
    DioError error;

    when(network.hasInternet()).thenAnswer((_) async => false);
    when(httpClient.get(
            path: 'app/monthly-devotion', options: anyNamed('options')))
        .thenAnswer((_) async => HTTPClientMock.monthlyScriptureGet(
            statusCode: HttpStatus.unauthorized));

    try {
      await subject.getVerse(httpClient, network);
    } catch (e) {
      error = e;
    }

    expect(error, isNotNull);
    expect(error is Exception, isTrue);
    expect(error.error.statusCode, HttpStatus.unauthorized);
  });
}
