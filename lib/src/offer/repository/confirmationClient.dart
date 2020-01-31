import 'package:dio/dio.dart';
import 'package:skg_hagen/src/common/service/client/dioHttpClient.dart';
import 'package:skg_hagen/src/common/service/network.dart';
import 'package:skg_hagen/src/offer/model/confirmation.dart';

class ConfirmationClient {
  static const String PATH = 'app/confirmation';
  static const String CACHE_DATA = 'app/confirmation/data';

  Future<Confirmation> getConfirmation(DioHTTPClient http, Network network,
      {int index, bool refresh}) async {
    final Options options = await http.setOptions(http, network, refresh);

    final dynamic jsonResponse = await http.getJSONResponse(
      http: http,
      options: options,
      path: PATH,
      object: Confirmation,
      cacheData: CACHE_DATA,
    );

    if (jsonResponse != null && jsonResponse.isNotEmpty) {
      return Confirmation.fromJson(jsonResponse);
    }

    return null;
  }
}
