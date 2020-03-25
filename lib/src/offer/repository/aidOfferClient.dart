import 'dart:io';

import 'package:dio/dio.dart';
import 'package:skg_hagen/src/common/service/client/dioHttpClient.dart';
import 'package:skg_hagen/src/common/service/network.dart';
import 'package:skg_hagen/src/offer/model/aid.dart';
import 'package:skg_hagen/src/offer/model/helper.dart';

class AidOfferClient {
  static const String PATH = 'app/aid_offer';
  static const String CACHE_DATA = 'app/aid_offer/data';

  Future<Aid> getAidOffer(DioHTTPClient http, Network network,
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

  Future<bool> saveHelper(
      DioHTTPClient http, Network network, Helper helper) async {
    final Options options = await http.setOptions(http, network, false);

    final Response<dynamic> response = await http.postJSON(
        http: http, path: PATH, options: options, data: helper.toJson());

    return response?.statusCode != HttpStatus.ok ? false : true;
  }
}
