import 'package:dio/dio.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:skg_hagen/src/common/service/dioHttpClient.dart';
import 'package:skg_hagen/src/common/service/network.dart';
import 'package:skg_hagen/src/kindergarten/model/kindergarten.dart';

class KindergartenClient {
  static const String PATH = 'app/kindergarten';

  Future<Kindergarten> getAppointments(DioHTTPClient http, Network network,
      {int index, bool refresh}) async {
    final Options options = await http.setGetOptions(http, network, refresh);

    return await http
        .get(path: PATH, options: options)
        .then((Response<dynamic> response) =>
            Kindergarten.fromJson(response.data))
        .catchError((dynamic onError) {
      Crashlytics.instance.log(onError.error.toString());
    });
  }
}
