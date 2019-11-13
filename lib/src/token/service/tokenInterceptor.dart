import 'dart:io';

import 'package:dio/dio.dart';
import 'package:skg_hagen/src/common/service/client/dioHttpClient.dart';
import 'package:skg_hagen/src/token/model/token.dart';
import 'package:skg_hagen/src/token/repository/tokenClient.dart';

class TokenInterceptor extends Interceptor {
  final TokenClient _tokenClient = TokenClient();
  String token;
  int _counter = 0;

  TokenInterceptor();

  @override
  Future<dynamic> onRequest(RequestOptions options) async {
    if (token == null) {
      final DioHTTPClient http = DioHTTPClient();
      http.client.lock();
      return await _tokenClient.getToken(DioHTTPClient()).then((Token tkn) {
        options.headers[HttpHeaders.authorizationHeader] =
            token = "${tkn?.tokenType} ${tkn?.jwtToken}";
        return options;
      }).whenComplete(() => http.client.unlock());
    } else {
      options.headers[HttpHeaders.authorizationHeader] = "Bearer $token";
      return options;
    }
  }

  @override
  Future<dynamic> onError(DioError error) async {
    _counter++;
    if (_counter < 3) {
      final DioHTTPClient http = DioHTTPClient();
      if (error.response?.statusCode == HttpStatus.unauthorized) {
        final RequestOptions options = error.response.request;
        if (token != options.headers[HttpHeaders.authorizationHeader]) {
          options.headers[HttpHeaders.authorizationHeader] = "Bearer $token";
          return http.client.request(options.path, options: options);
        }
        http.client.lock();
        http.client.interceptors.responseLock.lock();
        http.client.interceptors.errorLock.lock();
        return _tokenClient.getToken(http).then((Token tkn) {
          options.headers[HttpHeaders.authorizationHeader] =
              token = "${tkn?.tokenType} ${tkn?.jwtToken}";
        }).whenComplete(() {
          http.client.unlock();
          http.client.interceptors.responseLock.unlock();
          http.client.interceptors.errorLock.unlock();
        }).then((dynamic e) {
          return http.client.request(options.path, options: options);
        });
      }
    }
    return null;
  }
}
