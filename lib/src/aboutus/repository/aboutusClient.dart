import 'package:dio/dio.dart';
import 'package:skg_hagen/src/aboutus/model/aboutus.dart';
import 'package:skg_hagen/src/common/service/client/dioHttpClient.dart';
import 'package:skg_hagen/src/common/service/network.dart';

class AboutUsClient {
  static const String PATH = 'app/aboutus';
  static const String CACHE_DATA = 'app/aboutus/data';

  Future<AboutUs> getData(DioHTTPClient http, Network network,
      {int index, bool refresh}) async {
    final Options options = await http.setGetOptions(http, network, refresh);

    final Map<String, dynamic> jsonResponse = await http.getResponse(
      http: http,
      options: options,
      path: PATH,
      object: AboutUs,
      cacheData: CACHE_DATA,
    );

    if (jsonResponse != null) {
      return AboutUs.fromJson(jsonResponse);
    }

    return null;
  }
}
