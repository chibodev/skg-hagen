import 'package:dio/dio.dart';
import 'package:dio_http_cache/dio_http_cache.dart';
import 'package:skg_hagen/src/common/model/dioHttpClient.dart';
import 'package:skg_hagen/src/common/service/network.dart';
import 'package:skg_hagen/src/offer/model/offers.dart';

class OfferClient {
  static const String PATH = 'app/offers';

  /*
  Future<Offers> getOffers() async {
    final String jsonResponse =
        await AssetClient().loadAsset('assets/response/offers.json');

    final List<dynamic> jsonMap = jsonDecode(jsonResponse);
    return Offers.fromJson(jsonMap?.first);
  }
   */
  Future<Offers> getOffers(DioHTTPClient http, Network network,
      {int index, bool refresh}) async {
    Options options =
        buildCacheOptions(Duration(days: 7), maxStale: Duration(days: 10));

    http.initialiseInterceptors('debug');
    http.initialiseInterceptors('cache');
    http.initialiseInterceptors('token');

    final bool hasInternet = await network.hasInternet();

    if (hasInternet || refresh) {
      options = buildCacheOptions(Duration(days: 7),
          maxStale: Duration(days: 10), forceRefresh: true);
    }

    return await http
        .get(
          path: PATH,
          options: options,
        )
        .then((Response<dynamic> response) => Offers.fromJson(response.data));
  }
}
