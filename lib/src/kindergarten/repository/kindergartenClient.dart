import 'package:dio/dio.dart';
import 'package:skg_hagen/src/common/service/client/dioHttpClient.dart';
import 'package:skg_hagen/src/common/service/network.dart';
import 'package:skg_hagen/src/kindergarten/model/kindergarten.dart';

class KindergartenClient {
  static const String PATH = 'app/kindergarten';
  static const String CACHE_DATA = 'app/kindergarten/data';

  Future<Kindergarten> getAppointments(DioHTTPClient http, Network network,
      {int index, bool refresh}) async {
    final Options options = await http.setGetOptions(http, network, refresh);

    final Map<String, dynamic> jsonResponse = await http.getResponse(
      http: http,
      options: options,
      path: PATH,
      object: Kindergarten,
      cacheData: CACHE_DATA,
    );

    if (jsonResponse != null) {
      return Kindergarten.fromJson(jsonResponse);
    }

    return null;
  }
}
