import 'dart:collection';

import 'package:dio/dio.dart';
import 'package:dio_http_cache/dio_http_cache.dart';
import 'package:skg_hagen/src/common/service/debugInterceptor.dart';
import 'package:skg_hagen/src/common/service/network.dart';
import 'package:skg_hagen/src/token/service/tokenInterceptor.dart';

class DioHTTPClient {
  static const String BASE_URL = 'https://skg-hagen.chibo.org/wp-json/api/v1/';
  static const int TIMEOUT = 5000;
  static const int START_INDEX = 0;
  static const int MAX_PAGE_RANGE = 10;

  Dio _client;

  DioHTTPClient() {
    final BaseOptions options = BaseOptions(
        baseUrl: BASE_URL, connectTimeout: TIMEOUT, receiveTimeout: TIMEOUT);
    _client = Dio(options);
  }

  Dio get client => _client;

  void initialiseInterceptors(String options) {
    switch (options) {
      case 'debug':
        this.client.interceptors.add(DebugInterceptor());
        break;

      case 'cache':
        this
            .client
            .interceptors
            .add(DioCacheManager(CacheConfig()).interceptor);
        break;

      case 'token':
        this.client.interceptors.add(TokenInterceptor());
        break;
    }
  }

  Future<Options> setGetOptions(DioHTTPClient http, Network network, bool refresh) async {
    Options options =
    buildCacheOptions(Duration(days: 7), maxStale: Duration(days: 10));

    http.initialiseInterceptors('debug');
    http.initialiseInterceptors('cache');
    http.initialiseInterceptors('token');

    final bool hasInternet = await network.hasInternet();

    if (hasInternet || refresh) {
      options = buildCacheOptions(Duration(days: 7),
          maxStale: Duration(days: 10), forceRefresh: true);
    }
    return options;
  }

  Map<String, dynamic> getQueryParameters({int index = 0}) {
    final Map<String, dynamic> queryParameters = HashMap<String, dynamic>();
    queryParameters.putIfAbsent(
        "index",
            () => (index == null || index <= 0)
            ? START_INDEX
            : MAX_PAGE_RANGE * index);
    queryParameters.putIfAbsent("page", () => MAX_PAGE_RANGE);

    return queryParameters;
  }

  Future<Response<dynamic>> post({String path, dynamic data, Options options}) async {
    return await this._client.post(path, options: options, data: data);
  }

  Future<Response<dynamic>> get({String path, Options options, Map<String, dynamic> queryParameters}) async {
    return await this._client.get(path, options: options, queryParameters: queryParameters);
  }
}
