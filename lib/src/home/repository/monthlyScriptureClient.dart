import 'package:dio/dio.dart';
import 'package:html/dom.dart';
import 'package:skg_hagen/src/common/service/client/dioHttpClient.dart';
import 'package:skg_hagen/src/common/service/network.dart';
import 'package:skg_hagen/src/home/model/monthlyScripture.dart';

class MonthlyScriptureClient {
  static const String CACHE_DATA = 'app/monthly-devotion/data';
  static const String DEVOTION_URL = 'https://www.combib.de/losung/';
  static const int OLD_TESTAMENT = 0;
  static const int NEW_TESTAMENT = 2;

  Future<MonthlyScripture> getDevotion(DioHTTPClient http, Network network,
      {bool refresh}) async {
    final Options options = await http.setOptions(http, network, refresh);
    final MonthlyScripture dailyDevotion = MonthlyScripture();
    final DateTime today = DateTime.now();
    int counter = 0;
    final String path = "$DEVOTION_URL${today.year}/"
        "${_getFormattedValue(today.month)}"
        "${_getFormattedValue(today.day)}"
        ".html";

    final Document document = await http.getHTMLResponse(
      http: http,
      options: options,
      path: path,
      cacheData: CACHE_DATA,
    );

    document.querySelectorAll('td > p > font').forEach((Element e) {
      if (counter == OLD_TESTAMENT) {
        dailyDevotion.oldTestamentText = e.text.trim();
      }
      if (counter == NEW_TESTAMENT) {
        dailyDevotion.newTestamentText = e.text.trim();
      }
      counter++;
    });

    return dailyDevotion;
  }

  String _getFormattedValue(int value) {
    return value.toString().length == 1 ? "0$value" : value.toString();
  }
}
