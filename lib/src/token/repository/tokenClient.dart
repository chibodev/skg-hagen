import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:dio_http_cache/dio_http_cache.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:skg_hagen/src/common/service/dioHttpClient.dart';
import 'package:skg_hagen/src/common/service/assetClient.dart';
import 'package:skg_hagen/src/token/model/token.dart';
import 'package:skg_hagen/src/token/repository/credentials.dart';
import 'package:yaml/yaml.dart';

class TokenClient {
  static const String _PATH = 'token';
  static const String CONFIG_FILE = 'assets/config/api.yaml';

  Future<Credentials> getCredentials() async {
    final String apiCredentials = await AssetClient().loadAsset(CONFIG_FILE);
    final YamlMap apiConfig = loadYaml(apiCredentials);
    final Credentials credentials = Credentials(username: null, password: null);

    apiConfig.forEach((dynamic key, dynamic value) {
      if (key == 'username') {
        credentials.username = value;
      }
      if (key == 'password') {
        credentials.password = value;
      }
    });

    if (credentials.username == null && credentials == null) {
      throw Exception('Unable to retrieve credentials');
    }

    return credentials;
  }

  Future<Token> getToken(DioHTTPClient http) async {
    http.initialiseInterceptors('debug');
    http.initialiseInterceptors('cache');
    final Options options = Options();
    buildCacheOptions(Duration(minutes: 30), maxStale: Duration(hours: 1));
    options.contentType = Headers.formUrlEncodedContentType;
    final Credentials credentials = await getCredentials();

    return await http
        .post(
            path: _PATH,
            data: <String, String>{
              'username': credentials.username,
              'password': credentials.password
            },
            options: options)
        .then((Response<dynamic> response) =>
            Token.fromJson(jsonDecode(response.data)))
    .catchError((dynamic onError) {
      Crashlytics.instance.log(onError.error.toString());
    });
  }
}
