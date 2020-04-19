import 'package:dio/dio.dart';
import 'package:skg_hagen/src/churchyear/dto/easterOffer.dart';
import 'package:skg_hagen/src/common/service/client/dioHttpClient.dart';
import 'package:skg_hagen/src/common/service/network.dart';

class EasterOfferClient {
  static const String PATH = 'app/churchyear/easter';
  static const String CACHE_DATA = 'app/churchyear/easter/data';

  Future<EasterOffer> getOffers(DioHTTPClient http, Network network,
      {int index, bool refresh}) async {
    final Options options = await http.setOptions(http, network, refresh);

    final dynamic jsonResponse = await http.getJSONResponse(
      http: http,
      options: options,
      path: PATH,
      object: EasterOffer,
      cacheData: CACHE_DATA,
    );

    if (jsonResponse != null && jsonResponse.isNotEmpty) {
      return EasterOffer.fromJson(jsonResponse);
    }

    return null;
  }
}
