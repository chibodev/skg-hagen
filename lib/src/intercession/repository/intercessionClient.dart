import 'dart:io';

import 'package:dio/dio.dart';
import 'package:skg_hagen/src/common/service/client/dioHttpClient.dart';
import 'package:skg_hagen/src/common/service/network.dart';

class IntercessionClient {
  static const String PATH = 'app/intercession';

  Future<bool> saveIntercession(
      DioHTTPClient http, Network network, String intercession) async {
    final Options options = await http.setOptions(http, network, false);
    final Map<String, String> data = <String, String>{
    'intercession': intercession,
    };

    final Response<dynamic> response =  await http.postJSON(
        http: http, path: PATH, options: options, data: data);

    if (response.statusCode != HttpStatus.ok) {
      return false;
    }

    return true;
  }
}
