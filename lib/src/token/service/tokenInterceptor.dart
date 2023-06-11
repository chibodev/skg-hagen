import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:skg_hagen/src/common/service/client/dioHttpClient.dart';
import 'package:skg_hagen/src/token/dto/token.dart';
import 'package:skg_hagen/src/token/repository/tokenClient.dart';

class TokenInterceptor extends QueuedInterceptor {
  final TokenClient _tokenClient = TokenClient();
  String? token;
  int _counter = 0;

  TokenInterceptor();

  @override
  Future<void> onResponse(
      Response<dynamic> response, ResponseInterceptorHandler handler) async {
    if (token == null) {
      return await _tokenClient
          .getToken(DioHTTPClient(), DotEnv())
          .then((Token tkn) {
        response.requestOptions.headers[HttpHeaders.authorizationHeader] =
            token = "${tkn.tokenType} ${tkn.jwtToken}";
        handler.next(response);
      });
    } else {
      response.requestOptions.headers[HttpHeaders.authorizationHeader] =
          "Bearer $token";
      return handler.next(response);
    }
  }

  @override
  Future<void> onError(DioError error, ErrorInterceptorHandler handler) async {
    _counter++;
    if (_counter < 3) {
      final DioHTTPClient http = DioHTTPClient();
      if (error.response?.statusCode == HttpStatus.unauthorized) {
        if (token !=
            error.requestOptions.headers[HttpHeaders.authorizationHeader]) {
          error.requestOptions.headers[HttpHeaders.authorizationHeader] =
              "Bearer $token";
          final Options opts = Options(
              method: error.requestOptions.method,
              headers: error.requestOptions.headers);
          final Response<dynamic> cloneReq = await http.client.request(
              error.requestOptions.path,
              options: opts,
              data: error.requestOptions.data,
              queryParameters: error.requestOptions.queryParameters);
          return handler.resolve(cloneReq);
        }

        return _tokenClient.getToken(http, DotEnv()).then((Token tkn) {
          error.requestOptions.headers[HttpHeaders.authorizationHeader] =
              token = "${tkn.tokenType} ${tkn.jwtToken}";
        }).then((dynamic e) async {
          final Options opts = Options(
              method: error.requestOptions.method,
              headers: error.requestOptions.headers);
          final Response<dynamic> cloneReq = await http.client.request(
              error.requestOptions.path,
              options: opts,
              data: error.requestOptions.data,
              queryParameters: error.requestOptions.queryParameters);
          return handler.resolve(cloneReq);
        });
      }
    }
  }
}
