import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:dio_http_cache/dio_http_cache.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:skg_hagen/src/common/service/client/dioHttpClient.dart';
import 'package:skg_hagen/src/common/service/environment.dart';
import 'package:skg_hagen/src/token/model/token.dart';
import 'package:skg_hagen/src/token/repository/credentials.dart';

class TokenClient {
  static const String _PATH = 'token';

  Future<Token> getToken(DioHTTPClient http, DotEnv env) async {
    if (!Environment.isProduction()) {
      http.initialiseInterceptors('debug');
    }
    http.initialiseInterceptors('cache');
    final Options options = Options();
    buildCacheOptions(Duration(minutes: 30), maxStale: Duration(hours: 1));
    options.contentType = Headers.formUrlEncodedContentType;
    final Credentials credentials = _getCredentials(env);

    return await http
        .post(
        path: _PATH,
        data: <String, String>{
          'username': credentials.username,
          'password': credentials.password
        },
        options: options)
        .then(
          (Response<dynamic> response) => Token.fromJson(
        jsonDecode(response.data),
      ),
    )
        .catchError(
          (dynamic onError) {
        Crashlytics.instance.log(onError.error.toString());
      },
    );
  }

  Credentials _getCredentials(DotEnv env) {
    final Credentials credentials = Credentials(username: null, password: null);
    credentials.username = env.env['USERNAME'];
    credentials.password = env.env['PASSWORD'];

    if (credentials.username == null && credentials == null) {
      throw Exception('Unable to retrieve credentials');
    }

    return credentials;
  }
}
