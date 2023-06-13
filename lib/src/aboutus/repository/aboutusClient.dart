import 'package:dio/dio.dart';
import 'package:skg_hagen/src/aboutus/dto/aboutus.dart';
import 'package:skg_hagen/src/common/service/client/dioHttpClient.dart';
import 'package:skg_hagen/src/common/service/network.dart';

class AboutUsClient {
  static const String PATH = 'app/aboutus';
  static const String CACHE_DATA = 'app/aboutus/data';

  Future<AboutUs?> getData(DioHTTPClient http, Network network,
      {int? index, bool refresh = false}) async {
    final Options options = await http.setOptions(http, network, refresh);

    final dynamic jsonResponse = await http.getJSONResponse(
      http: http,
      options: options,
      path: PATH,
      object: AboutUs,
      cacheData: CACHE_DATA,
    );

    if (jsonResponse != null && jsonResponse.isNotEmpty) {
      return AboutUs.fromJson(jsonResponse);
    }

    return null;
  }
}
