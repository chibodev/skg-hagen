import 'package:dio/dio.dart';
import 'package:dio_http_cache/dio_http_cache.dart';
import 'package:skg_hagen/src/common/model/dioHttpClient.dart';
import 'package:skg_hagen/src/common/service/network.dart';
import 'package:skg_hagen/src/home/model/monthlyScripture.dart';

class MonthlyScriptureClient {
  static const String PATH = 'app/monthly-devotion';

  Future<MonthlyScripture> getVerse(DioHTTPClient http, Network network) async {
    Options options =
        buildCacheOptions(Duration(days: 7), maxStale: Duration(days: 10));

    http.initialiseInterceptors('debug');
    http.initialiseInterceptors('cache');
    http.initialiseInterceptors('token');

    final bool hasInternet = await network.hasInternet();

    if (hasInternet) {
      options = buildCacheOptions(Duration(days: 7),
          maxStale: Duration(days: 10), forceRefresh: true);
    }

    return await http.get(path: PATH, options: options).then(
        (Response response) => MonthlyScripture.fromJson(response.data.first));
  }
}
