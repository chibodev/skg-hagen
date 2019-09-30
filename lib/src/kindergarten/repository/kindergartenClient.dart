import 'dart:convert';

import 'package:skg_hagen/src/common/service/client.dart';
import 'package:skg_hagen/src/kindergarten/model/kindergarten.dart';

class KindergartenClient {
  Future<Kindergarten> getInfos() async {
    final String jsonResponse =
        await Client().loadAsset('assets/response/kindergarten.json');

    final List<dynamic> jsonMap = jsonDecode(jsonResponse);

    return Kindergarten.fromJson(jsonMap.first);
  }
}
