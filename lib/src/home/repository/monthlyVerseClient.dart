import 'dart:convert';

import 'package:skg_hagen/src/common/service/client.dart';
import 'package:skg_hagen/src/home/model/monthlyScripture.dart';

class MonthlyVerseClient {
  //TODO setup client
  Future<MonthlyScripture> getVerse() async {
    final String jsonResponse =
        await Client().loadAsset('assets/response/monthlyScripture.json');

    final List<dynamic> jsonMap = jsonDecode(jsonResponse);

    print(jsonMap);
    return MonthlyScripture.fromJson(jsonMap?.first);
  }
//('Suche Frieden und jage ihm nach!', 'Ps.', 34, 15);

}
