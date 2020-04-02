import 'package:dio/dio.dart';
import 'package:skg_hagen/src/common/service/client/dioHttpClient.dart';
import 'package:skg_hagen/src/common/service/network.dart';
import 'package:skg_hagen/src/home/model/aid.dart';

class AidClient {
  static const String PATH = 'app/aid';
  static const String CACHE_DATA = 'app/aid/data';

  Future<Aid> getAid(DioHTTPClient http, Network network,
      {int index, bool refresh}) async {
    final Options options = await http.setOptions(http, network, refresh);

    final dynamic jsonResponse = await http.getJSONResponse(
      http: http,
      options: options,
      path: PATH,
      object: Aid,
      cacheData: CACHE_DATA,
    );

    if (jsonResponse != null && jsonResponse.isNotEmpty) {
      return Aid.fromJson(jsonResponse);
    }

    return null;
  }
}
