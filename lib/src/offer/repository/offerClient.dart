import 'package:dio/dio.dart';
import 'package:skg_hagen/src/common/service/dioHttpClient.dart';
import 'package:skg_hagen/src/common/service/network.dart';
import 'package:skg_hagen/src/offer/model/offers.dart';

class OfferClient {
  static const String PATH = 'app/offers';
  static const String CACHE_DATA = 'app/offers/data';

  Future<Offers> getOffers(DioHTTPClient http, Network network,
      {int index, bool refresh}) async {
    final Options options = await http.setGetOptions(http, network, refresh);

    final Map<String, dynamic> jsonResponse = await http.getResponse(
      http: http,
      options: options,
      path: PATH,
      object: Offers,
      cacheData: CACHE_DATA,
    );

    if (jsonResponse != null) {
      return Offers.fromJson(jsonResponse);
    }

    return null;
  }
}
