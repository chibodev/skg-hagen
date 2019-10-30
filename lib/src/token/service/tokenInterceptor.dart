import 'dart:io';

import 'package:dio/dio.dart';
import 'package:skg_hagen/src/common/model/dioHttpClient.dart';
import 'package:skg_hagen/src/token/model/token.dart';
import 'package:skg_hagen/src/token/repository/tokenClient.dart';

class TokenInterceptor extends Interceptor {
  final TokenClient _tokenClient;
  final DioHTTPClient _http;
  String token;
  int _counter = 0;

  TokenInterceptor(this._tokenClient, this._http);

  @override
  Future<dynamic> onRequest(RequestOptions options) async {
    if (token == null) {
      _http.client.lock();
      return _tokenClient.getToken().then((Token tkn) {
        options.headers[HttpHeaders.authorizationHeader] =
            token = "${tkn.tokenType} ${tkn.jwtToken}";
        return options;
      }).whenComplete(() => _http.client.unlock());
    } else {
      options.headers[HttpHeaders.authorizationHeader] = "Bearer $token";
      return options;
    }
  }

  @override
  Future<dynamic> onError(DioError error) async {
    _counter++;
    if (_counter < 3) {
      if (error.response?.statusCode == 401) {
        final RequestOptions options = error.response.request;
        if (token != options.headers[HttpHeaders.authorizationHeader]) {
          options.headers[HttpHeaders.authorizationHeader] = "Bearer $token";
          return _http.client.request(options.path, options: options);
        }
        _http.client.lock();
        _http.client.interceptors.responseLock.lock();
        _http.client.interceptors.errorLock.lock();
        return _tokenClient.getToken().then((Token tkn) {
          options.headers[HttpHeaders.authorizationHeader] =
              token = "${tkn.tokenType} ${tkn.jwtToken}";
        }).whenComplete(() {
          _http.client.unlock();
          _http.client.interceptors.responseLock.unlock();
          _http.client.interceptors.errorLock.unlock();
        }).then((e) {
          return _http.client.request(options.path, options: options);
        });
      }
    }
    return null;
  }
}
