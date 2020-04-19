import 'package:dio/dio.dart';
import 'package:skg_hagen/src/common/service/client/dioHttpClient.dart';
import 'package:skg_hagen/src/common/service/network.dart';
import 'package:skg_hagen/src/offer/dto/offers.dart';

class OfferClient {
  static const String PATH = 'app/offers';
  static const String CACHE_DATA = 'app/offers/data';

  Future<Offers> getOffers(DioHTTPClient http, Network network,
      {int index, bool refresh}) async {
    final Options options = await http.setOptions(http, network, refresh);

    final dynamic jsonResponse = await http.getJSONResponse(
      http: http,
      options: options,
      path: PATH,
      object: Offers,
      cacheData: CACHE_DATA,
    );

    if (jsonResponse != null && jsonResponse.isNotEmpty) {
      return Offers.fromJson(jsonResponse);
    }

    return null;
  }
}
