import 'package:dio/dio.dart';
import 'package:skg_hagen/src/common/service/dioHttpClient.dart';
import 'package:skg_hagen/src/common/service/network.dart';
import 'package:skg_hagen/src/home/model/monthlyScripture.dart';

class MonthlyScriptureClient {
  static const String PATH = 'app/monthly-devotion';

  Future<MonthlyScripture> getVerse(DioHTTPClient http, Network network,
      {bool refresh}) async {
    final Options options = await http.setGetOptions(http, network, refresh);

    return await http.get(path: PATH, options: options).then(
        (Response<dynamic> response) =>
            MonthlyScripture.fromJson(response.data.first));
  }
}
