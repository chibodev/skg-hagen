import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:dio_http_cache/dio_http_cache.dart';
import 'package:skg_hagen/src/common/model/dioHttpClient.dart';
import 'package:skg_hagen/src/common/model/errorHandler.dart';
import 'package:skg_hagen/src/common/service/debugInterceptor.dart';
import 'package:skg_hagen/src/token/model/token.dart';

class TokenClient {
  DioHTTPClient _http;
  final String _path = 'token';
  final String _username = '', _password = '';
  String _error = '';

  TokenClient() {
    this._http = DioHTTPClient();
  }

  Future<Token> getToken() async {
    return await _getData();
  }

  Future<Token> _getData() async {

    _http.client.interceptors.add(DebugInterceptor());

    this._http.client.options.contentType = Headers.formUrlEncodedContentType;
    return await _http.client
        .post(
          _path,
          data: <String, String>{'username': _username, 'password': _password},
          options: buildCacheOptions(Duration(minutes: 30),
              maxStale: Duration(hours: 1)),
        )
        .then((Response response) =>
            Token.fromJson(jsonDecode(response.data)))
        .catchError((dynamic err) =>
            _error = ErrorHandler.handleError(err, err.response.statusCode));

  }

  String get error => _error;
}
