import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:skg_hagen/src/intercession/repository/intercessionClient.dart';

import '../../mock/httpClientMock.dart';

void main() {
  late IntercessionClient subject;
  late MockDioHTTPClient httpClient;
  late MockNetwork network;
  final Options options = Options();
  final String intercession = 'gebetswunsch';
  final Map<String, String> data = <String, String>{'intercession': intercession};

  setUpAll(() {
    subject = IntercessionClient();
    httpClient = MockDioHTTPClient();
    network = MockNetwork();
  });

  test('IntercessionClient successfully sends intercession', () async {
    when(network.hasInternet()).thenAnswer((_) async => false);
    when(httpClient.setOptions(httpClient, network, false)).thenAnswer((_) async => options);

    when(httpClient.postJSON(http: httpClient, path: IntercessionClient.PATH, data: data, options: options))
        .thenAnswer((_) async => HTTPClientMock.formPost(statusCode: HttpStatus.ok, path: IntercessionClient.PATH));

    final bool response = await subject.saveIntercession(httpClient, network, intercession);

    expect(response, isTrue);
  });

  test('IntercessionClient fails', () async {
    when(network.hasInternet()).thenAnswer((_) async => false);
    when(httpClient.setOptions(httpClient, network, any)).thenAnswer((_) async => options);
    when(httpClient.postJSON(http: httpClient, path: IntercessionClient.PATH, data: data, options: options))
        .thenAnswer((_) async => HTTPClientMock.formPost(statusCode: HttpStatus.badRequest, path: IntercessionClient.PATH));

    final bool response = await subject.saveIntercession(httpClient, network, intercession);

    expect(response, isFalse);
  });
}
