import 'dart:collection';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:dio_http_cache/dio_http_cache.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:html/parser.dart';
import 'package:skg_hagen/src/common/library/globals.dart';
import 'package:skg_hagen/src/common/service/cacheInterceptor.dart';
import 'package:skg_hagen/src/common/service/debugInterceptor.dart';
import 'package:skg_hagen/src/common/service/environment.dart';
import 'package:skg_hagen/src/common/service/network.dart';
import 'package:skg_hagen/src/token/service/tokenInterceptor.dart';

class DioHTTPClient {
  static const int TIMEOUT = 5000;
  static const int START_INDEX = 0;
  static const int MAX_PAGE_RANGE = 10;
  static const int COMPLETED = 100;

  Dio _client;

  DioHTTPClient() {
    final BaseOptions options = BaseOptions(
        baseUrl: DotEnv().env['API'],
        connectTimeout: TIMEOUT,
        receiveTimeout: TIMEOUT);
    _client = Dio(options);
  }

  Dio get client => _client;

  void initialiseInterceptors(String options) {
    switch (options) {
      case 'debug':
        this.client.interceptors.add(
              DebugInterceptor(),
            );
        break;

      case 'cache':
        this.client.interceptors.add(
              CacheInterceptor(),
            );
        break;

      case 'token':
        this.client.interceptors.add(
              TokenInterceptor(),
            );
        break;
    }
  }

  Future<Options> setOptions(
      DioHTTPClient http, Network network, bool refresh) async {
    Options options = buildCacheOptions(
      Duration(days: 2),
      maxStale: Duration(days: 3),
    );

    if (!Environment.isProduction()) {
      http.initialiseInterceptors('debug');
    }
    http.initialiseInterceptors('cache');

    final bool refreshState = refresh != null;
    final bool hasInternet = await network.hasInternet();

    if (hasInternet) {
      options = buildCacheOptions(Duration(days: 2),
          maxStale: Duration(days: 3),
          forceRefresh: (refreshState && refresh == true) ? true : false);
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

  Future<dynamic> getJSONResponse(
      {@required DioHTTPClient http,
      @required Options options,
      Map<String, dynamic> queryParameters,
      @required String path,
      @required dynamic object,
      @required String cacheData}) async {
    return await http
        ._get(path: path, options: options, queryParameters: queryParameters)
        .then(
          (Response<dynamic> response) => jsonDecode(response.data),
        )
        .catchError((dynamic onError) {
      if (sharedPreferences.containsKey(cacheData)) {
        return jsonDecode(
          sharedPreferences.get(cacheData),
        );
      } else {
        Crashlytics.instance.log(
          onError.error.toString(),
        );
        return null;
      }
    });
  }

  Future<dynamic> getHTMLResponse(
      {@required DioHTTPClient http,
      @required Options options,
      @required String path,
      @required String cacheData}) async {
    _client.options.baseUrl = '';
    return await http
        ._get(path: path, options: options)
        .then(
          (Response<dynamic> response) => parse(response.data),
        )
        .catchError((dynamic onError) {
      if (sharedPreferences.containsKey(cacheData)) {
        return parse(
          sharedPreferences.get(cacheData),
        );
      } else {
        Crashlytics.instance.log(
          onError.error.toString(),
        );
        return null;
      }
    });
  }

  Future<dynamic> postJSON({
    @required DioHTTPClient http,
    @required Options options,
    @required String path,
    dynamic data,
  }) async {
    return await http
        ._post(path: path, options: options, data: data)
        .then(
          (Response<dynamic> response) => response,
        )
        .catchError((dynamic onError) {
      Crashlytics.instance.log(
        onError.error.toString(),
      );
    });
  }

  Future<bool> downloadFile(
      {@required DioHTTPClient http,
      @required String urlPath,
      @required String savePath}) async {
    return await http
            ._download(urlPath: urlPath, savePath: savePath)
            .catchError((dynamic onError) {
          Crashlytics.instance.log(
            onError.error.toString(),
          );
        }) ==
        COMPLETED;
  }

  Future<Response<dynamic>> _post(
      {String path, dynamic data, Options options}) async {
    return await this._client.post(path, options: options, data: data);
  }

  Future<Response<dynamic>> _get(
      {String path,
      Options options,
      Map<String, dynamic> queryParameters}) async {
    return await this
        ._client
        .get(path, options: options, queryParameters: queryParameters);
  }

  Future<int> _download({String urlPath, String savePath}) async {
    int progress = 0;

    return await this._client.download(urlPath, savePath,
        onReceiveProgress: (int receivedBytes, int totalBytes) {
      progress = ((receivedBytes / totalBytes) * 100).toInt();
    }).then(
      (Response<dynamic> response) => progress,
    );
  }
}
