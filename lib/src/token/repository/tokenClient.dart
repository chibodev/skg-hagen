import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:dio_http_cache/dio_http_cache.dart';
import 'package:skg_hagen/src/common/model/dioHttpClient.dart';
import 'package:skg_hagen/src/token/model/token.dart';

class TokenClient {
  static const String _PATH = 'token';
  static const String _USERNAME = 'super.admin', _PASSWORD = 'super.admin1';

  Future<Token> getToken(DioHTTPClient http) async {
    http.initialiseInterceptors('debug');
    http.initialiseInterceptors('cache');
    final Options options = Options();
    buildCacheOptions(Duration(minutes: 30), maxStale: Duration(hours: 1));
    options.contentType = Headers.formUrlEncodedContentType;

    return await http
        .post(
            path: _PATH,
            data: <String, String>{
              'username': _USERNAME,
              'password': _PASSWORD
            },
            options: options)
        .then((Response<dynamic> response) => Token.fromJson(jsonDecode(response.data)));
  }
}
