import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:skg_hagen/src/common/service/client/assetClient.dart';
import 'package:skg_hagen/src/common/service/client/dioHttpClient.dart';
import 'package:skg_hagen/src/token/model/token.dart';
import 'package:skg_hagen/src/token/repository/tokenClient.dart';

import '../../mock/fileClientMock.dart';
import '../../mock/httpClientTokenMock.dart';

class MockDioHTTPClient extends Mock implements DioHTTPClient {}

class MockAssetClient extends Mock implements AssetClient {}

void main() {
  TokenClient subject;
  MockDioHTTPClient httpClient;
  AssetClient assetClient;

  setUpAll(() {
    subject = TokenClient();
    assetClient = MockAssetClient();
  });

  test('TokenClient successfully retrieves token', () async {
    httpClient = MockDioHTTPClient();

    when(assetClient.loadAsset('assets/config/api.yaml')).thenAnswer(
        (_) async => FileClientMock.loadFromTestResourcePath('api.yaml'));

    when(httpClient.post(
            path: 'token',
            data: anyNamed('data'),
            options: anyNamed('options')))
        .thenAnswer((_) async =>
            HTTPClientTokenMock.tokenPost(statusCode: HttpStatus.ok));

    final Token token = await subject.getToken(httpClient, assetClient);

    expect(token.tokenType, 'Bearer');
    expect(token.iat, 1572514891);
    expect(token.expiresIn, 1572518491);
    expect(token.jwtToken, isNotNull);
  });

  test('TokenClient fails and throws Exception', () async {
    httpClient = MockDioHTTPClient();
    DioError error;

    when(httpClient.post(
            path: 'token',
            data: anyNamed('data'),
            options: anyNamed('options')))
        .thenAnswer((_) async =>
            HTTPClientTokenMock.tokenPost(statusCode: HttpStatus.unauthorized));

    try {
      await subject.getToken(httpClient, assetClient);
    } catch (e) {
      error = e;
    }

    expect(error, isNotNull);
    expect(error is Exception, isTrue);
    expect(error.error.statusCode, HttpStatus.unauthorized);
  });
}
