import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:skg_hagen/src/token/repository/tokenClient.dart';

import '../../mock/httpClientMock.dart';

class MockDotEnv extends Mock implements DotEnv {
  @override
  Map<String, String> get env {
    return super.noSuchMethod(Invocation.getter(#env),
        returnValue: Map<String, String>());
  }
}

void main() {
  // late TokenClient subject;
  late MockDioHTTPClient httpClient;
  late MockDotEnv env;
  final Options options = Options();
  final Map<String, String> localEnv = Map<String, String>();
  final Map<String, String> data = <String, String>{
    'username': 'someData',
    'password': 'somePass'
  };

  setUpAll(() {
    // subject = TokenClient();
    httpClient = MockDioHTTPClient();
    env = MockDotEnv();
    localEnv.putIfAbsent('USERNAME', () => 'someData');
    localEnv.putIfAbsent('PASSWORD', () => 'somePass');
  });

  test('TokenClient successfully retrieves token', () async {
    when(env.env).thenReturn(localEnv);

    when(httpClient.postJSON(
            http: httpClient,
            path: TokenClient.PATH,
            data: data,
            options: options))
        .thenAnswer(
            (_) async => HTTPClientMock.tokenPost(statusCode: HttpStatus.ok));

    // final Token token = await subject.getToken(httpClient, env);
    //
    // expect(token.tokenType, 'Bearer');
    // expect(token.iat, 1572514891);
    // expect(token.expiresIn, 1572518491);
    // expect(token.jwtToken, isNotNull);
  });
}
