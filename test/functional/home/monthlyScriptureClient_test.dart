import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:html/dom.dart';
import 'package:mockito/mockito.dart';
import 'package:skg_hagen/src/home/dto/monthlyScripture.dart';
import 'package:skg_hagen/src/home/repository/monthlyScriptureClient.dart';

import '../../mock/httpClientMock.dart';

void main() {
  late MonthlyScriptureClient subject;
  late MockDioHTTPClient httpClient;
  late MockNetwork network;
  final Options options = Options();

  setUpAll(() {
    subject = MonthlyScriptureClient();
    httpClient = MockDioHTTPClient();
    network = MockNetwork();
  });

  test('MonthlyScriptureClient successfully retrieves data', () async {
    final String filename = 'monthlyScripture.html';
    final String path = subject.getPath();

    when(network.hasInternet()).thenAnswer((_) async => false);
    when(httpClient.setOptions(httpClient, network, any)).thenAnswer((_) async => options);
    when(
      httpClient.getHTMLResponse(
        http: httpClient,
        options: options,
        path: path,
        cacheData: MonthlyScriptureClient.CACHE_DATA,
      ),
    ).thenAnswer(
      (_) async => HTTPClientMock.getHTMLRequest(statusCode: HttpStatus.ok, path: filename),
    );

    final MonthlyScripture verse = await subject.getDevotion(httpClient, network);

    expect(verse.oldTestamentText?.contains('Ich will die Müden erquicken'), true);
    expect(verse.newTestamentText?.contains('denn ihrer ist das Himmelreich'), true);
  });

  test('MonthlyScriptureClient fails to retrieves data', () async {
    final String path = subject.getPath();

    when(network.hasInternet()).thenAnswer((_) async => false);
    when(httpClient.setOptions(httpClient, network, any)).thenAnswer((_) async => options);
    when(
      httpClient.getHTMLResponse(
        http: httpClient,
        options: options,
        path: path,
        cacheData: MonthlyScriptureClient.CACHE_DATA,
      ),
    ).thenAnswer(
      (_) async => Document.html('entry unknown'),
    );

    final MonthlyScripture verse = await subject.getDevotion(httpClient, network);

    expect(verse.oldTestamentText?.contains('Wer wird uns Gutes sehen lassen?'), true);
    expect(verse.newTestamentText?.contains('Ich bin das Licht der Welt.'), true);
  });
}
