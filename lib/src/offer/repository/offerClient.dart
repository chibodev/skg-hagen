import 'dart:convert';

import 'package:skg_hagen/src/common/service/assetClient.dart';
import 'package:skg_hagen/src/offer/model/offers.dart';

class OfferClient {

  Future<Offers> getOffers() async {
    final String jsonResponse =
        await AssetClient().loadAsset('assets/response/offers.json');

    final List<dynamic> jsonMap = jsonDecode(jsonResponse);
    return Offers.fromJson(jsonMap?.first);
  }
}
