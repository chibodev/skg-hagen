import 'dart:io';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:skg_hagen/src/common/service/client/dioHttpClient.dart';
import 'package:skg_hagen/src/token/model/token.dart';
import 'package:skg_hagen/src/token/repository/tokenClient.dart';

import '../../mock/httpClientTokenMock.dart';

class MockDioHTTPClient extends Mock implements DioHTTPClient {}

class MockDotEnv extends Mock implements DotEnv {}

void main() {
  TokenClient subject;
  MockDioHTTPClient httpClient;
  MockDotEnv env;
  final Map<String, String> localEnv = Map<String, String>();

  setUpAll(() {
    subject = TokenClient();
    env = MockDotEnv();
    localEnv.putIfAbsent('USERNAME', () => 'someData');
    localEnv.putIfAbsent('PASSWORD', () => 'somePass');
  });

  test('TokenClient successfully retrieves token', () async {
    httpClient = MockDioHTTPClient();

    when(env.env).thenReturn(localEnv);

    when(httpClient.postJSON(
            http: httpClient,
            path: 'token',
            data: anyNamed('data'),
            options: anyNamed('options')))
        .thenAnswer((_) async =>
            HTTPClientTokenMock.tokenPost(statusCode: HttpStatus.ok));

    final Token token = await subject.getToken(httpClient, env);

    expect(token.tokenType, 'Bearer');
    expect(token.iat, 1572514891);
    expect(token.expiresIn, 1572518491);
    expect(token.jwtToken, isNotNull);
  });
}
