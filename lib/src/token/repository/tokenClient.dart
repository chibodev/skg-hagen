import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:dio_http_cache/dio_http_cache.dart';
import 'package:skg_hagen/src/common/model/dioHttpClient.dart';
import 'package:skg_hagen/src/common/service/debugInterceptor.dart';
import 'package:skg_hagen/src/token/model/token.dart';

class TokenClient {
  DioHTTPClient _http;
  final String _path = 'token';
  final String _username = 'super.admin', _password = 'super.admin1';

  TokenClient() {
    this._http = DioHTTPClient();
  }

  Future<Token> getToken() async {
    return await _getData();
  }

  Future<Token> _getData() async {
    _http.client.interceptors.add(DebugInterceptor());
    _http.client.interceptors.add(DioCacheManager(CacheConfig()).interceptor);

    this._http.client.options.contentType = Headers.formUrlEncodedContentType;
    return await _http.client
        .post(
          _path,
          data: <String, String>{'username': _username, 'password': _password},
          options: buildCacheOptions(Duration(minutes: 30),
              maxStale: Duration(hours: 1)),
        )
        .then((Response response) => Token.fromJson(jsonDecode(response.data)));
  }
}
