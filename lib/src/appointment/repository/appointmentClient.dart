import 'package:dio/dio.dart';
import 'package:dio_http_cache/dio_http_cache.dart';
import 'package:skg_hagen/src/appointment/model/appointments.dart';
import 'package:skg_hagen/src/common/model/default.dart';
import 'package:skg_hagen/src/common/model/dioHttpClient.dart';
import 'package:skg_hagen/src/common/service/network.dart';

class AppointmentClient {
  static const String PATH = 'app/appointments';

  Future<Appointments> getAppointments(DioHTTPClient http, Network network,
      {int index, bool refresh}) async {
    Options options =
        buildCacheOptions(Duration(days: 7), maxStale: Duration(days: 10));
    final Map<String, dynamic> queryParameters =
        Default.getQueryParameters(index: index);

    http.initialiseInterceptors('debug');
    http.initialiseInterceptors('cache');
    http.initialiseInterceptors('token');

    final bool hasInternet = await network.hasInternet();

    if (hasInternet || refresh) {
      options = buildCacheOptions(Duration(days: 7),
          maxStale: Duration(days: 10), forceRefresh: true);
    }

    return await http
        .get(path: PATH, options: options, queryParameters: queryParameters)
        .then((Response<dynamic> response) => Appointments.fromJson(response.data));
  }
}
