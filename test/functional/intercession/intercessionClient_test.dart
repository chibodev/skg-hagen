import 'dart:io';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:skg_hagen/src/common/service/client/dioHttpClient.dart';
import 'package:skg_hagen/src/common/service/network.dart';
import 'package:skg_hagen/src/intercession/repository/intercessionClient.dart';

import '../../mock/httpClientFormMock.dart';

class MockDioHTTPClient extends Mock implements DioHTTPClient {}

class MockDotEnv extends Mock implements DotEnv {}

void main() {
  IntercessionClient subject;
  MockDioHTTPClient httpClient;

  setUpAll(() {
    subject = IntercessionClient();
  });

  test('IntercessionClient successfully sends intercession', () async {
    httpClient = MockDioHTTPClient();

    when(httpClient.postJSON(
            http: httpClient,
            path: 'app/intercession',
            data: anyNamed('data'),
            options: anyNamed('options')))
        .thenAnswer((_) async =>
            HTTPClientFormMock.formPost(statusCode: HttpStatus.ok));

    final bool response = await subject.saveIntercession(httpClient, Network(), 'gebetswunsch');

    expect(response, isTrue);
  });

  test('IntercessionClient fails', () async {
    httpClient = MockDioHTTPClient();

    when(httpClient.postJSON(
        http: httpClient,
        path: 'app/intercession',
        data: anyNamed('data'),
        options: anyNamed('options')))
        .thenAnswer((_) async =>
        HTTPClientFormMock.formPost(statusCode: HttpStatus.badRequest));

    final bool response = await subject.saveIntercession(httpClient, Network(), 'gebetswunsch');

    expect(response, isFalse);
  });
}
