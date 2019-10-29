import 'package:dio/dio.dart';
import 'package:dio_http_cache/dio_http_cache.dart';
import 'package:skg_hagen/src/common/model/dioHttpClient.dart';
import 'package:skg_hagen/src/common/model/errorHandler.dart';
import 'package:skg_hagen/src/common/service/cacheInterceptor.dart';
import 'package:skg_hagen/src/common/service/debugInterceptor.dart';
import 'package:skg_hagen/src/home/model/monthlyScripture.dart';
import 'package:skg_hagen/src/token/service/tokenClient.dart';
import 'package:skg_hagen/src/token/service/tokenInterceptor.dart';

class MonthlyVerseClient {
  DioHTTPClient _http;
  final String _path = 'app/monthly-devotion';
  String _error = '';

  MonthlyVerseClient() {
    _http = DioHTTPClient();
  }

  Future<MonthlyScripture> getVerse() async {
    return await _getData();
  }

  Future<MonthlyScripture> _getData() async {
    final TokenClient tokenClient = TokenClient();

    _http.client.interceptors.add(TokenInterceptor(tokenClient, _http));
    _http.client.interceptors.add(CacheInterceptor());
    _http.client.interceptors.add(DebugInterceptor());

    return await _http.client
        .get(_path,
            options: buildCacheOptions(Duration(days: 7),
                maxStale: Duration(days: 10)))
        .then((Response response) =>
            MonthlyScripture.fromJson(response.data.first))
        .catchError((dynamic err) =>
            _error = ErrorHandler.handleError(err, err.response.statusCode));
  }

  String get error => _error;
}
