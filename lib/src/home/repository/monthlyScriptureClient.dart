import 'package:dio/dio.dart';
import 'package:skg_hagen/src/common/service/client/dioHttpClient.dart';
import 'package:skg_hagen/src/common/service/network.dart';
import 'package:skg_hagen/src/home/model/monthlyScripture.dart';

class MonthlyScriptureClient {
  static const String PATH = 'app/monthly-devotion';
  static const String CACHE_DATA = 'app/monthly-devotion/data';

  Future<MonthlyScripture> getVerse(DioHTTPClient http, Network network,
      {bool refresh}) async {
    final Options options = await http.setGetOptions(http, network, refresh);

    final Map<String, dynamic> jsonResponse = await http.getResponse(
      http: http,
      options: options,
      path: PATH,
      object: MonthlyScripture,
      cacheData: CACHE_DATA,
    );

    if (jsonResponse != null) {
      return MonthlyScripture.fromJson(jsonResponse);
    }

    return null;
  }
}
