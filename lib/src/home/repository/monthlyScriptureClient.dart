import 'package:dio/dio.dart';
import 'package:dio_http_cache/dio_http_cache.dart';
import 'package:skg_hagen/src/common/model/dioHttpClient.dart';
import 'package:skg_hagen/src/common/service/debugInterceptor.dart';
import 'package:skg_hagen/src/common/service/network.dart';
import 'package:skg_hagen/src/home/model/monthlyScripture.dart';
import 'package:skg_hagen/src/token/repository/tokenClient.dart';
import 'package:skg_hagen/src/token/service/tokenInterceptor.dart';

class MonthlyScriptureClient {
  DioHTTPClient _http;
  final String _path = 'app/monthly-devotion';
  Network _network;

  MonthlyScriptureClient() {
    _http = DioHTTPClient();
    _network = Network();
  }

  Future<MonthlyScripture> getVerse() async {
    return await _getData();
  }

  Future<MonthlyScripture> _getData() async {
    final TokenClient tokenClient = TokenClient();
    Options cacheOptions =
        buildCacheOptions(Duration(days: 7), maxStale: Duration(days: 10));

    _http.client.interceptors.add(DioCacheManager(CacheConfig()).interceptor);
    _http.client.interceptors.add(TokenInterceptor(tokenClient, _http));
    _http.client.interceptors.add(DebugInterceptor());

    final bool hasInternet = await _network.hasInternet();

    if (hasInternet) {
      cacheOptions = buildCacheOptions(Duration(days: 7),
          maxStale: Duration(days: 10), forceRefresh: true);
    }
    return await _http.client.get(_path, options: cacheOptions).then(
        (Response response) => MonthlyScripture.fromJson(response.data.first));
  }
}
