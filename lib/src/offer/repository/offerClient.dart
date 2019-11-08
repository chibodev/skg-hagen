import 'package:dio/dio.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:skg_hagen/src/common/service/dioHttpClient.dart';
import 'package:skg_hagen/src/common/service/network.dart';
import 'package:skg_hagen/src/offer/model/offers.dart';

class OfferClient {
  static const String PATH = 'app/offers';

  Future<Offers> getOffers(DioHTTPClient http, Network network,
      {int index, bool refresh}) async {
    final Options options = await http.setGetOptions(http, network, refresh);

    return await http
        .get(
          path: PATH,
          options: options,
        )
        .then(
          (Response<dynamic> response) => Offers.fromJson(response.data),
        )
        .catchError((dynamic onError) {
      Crashlytics.instance.log(onError.error.toString());
    });
  }
}
