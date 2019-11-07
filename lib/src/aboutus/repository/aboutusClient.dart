import 'package:dio/dio.dart';
import 'package:skg_hagen/src/aboutus/model/aboutus.dart';
import 'package:skg_hagen/src/common/service/dioHttpClient.dart';
import 'package:skg_hagen/src/common/service/network.dart';

class AboutUsClient {
  static const String PATH = 'app/aboutus';

  Future<AboutUs> getData(DioHTTPClient http, Network network,
      {int index, bool refresh}) async {
    final Options options = await http.setGetOptions(http, network, refresh);

    return await http
        .get(
          path: PATH,
          options: options,
        )
        .then((Response<dynamic> response) => AboutUs.fromJson(response.data));
  }
}
