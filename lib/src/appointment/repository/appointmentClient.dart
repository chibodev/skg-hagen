import 'package:dio/dio.dart';
import 'package:skg_hagen/src/appointment/dto/appointments.dart';
import 'package:skg_hagen/src/common/service/client/dioHttpClient.dart';
import 'package:skg_hagen/src/common/service/network.dart';

class AppointmentClient {
  static const String PATH = 'app/appointments';
  static const String CACHE_DATA = 'app/appointments/data';

  Future<Appointments?> getAppointments(DioHTTPClient http, Network network,
      {int? index, bool? refresh}) async {
    final Options options = await http.setOptions(http, network, refresh);

    final Map<String, dynamic> queryParameters =
        http.getQueryParameters(index: index);

    final dynamic jsonResponse = await http.getJSONResponse(
        http: http,
        options: options,
        path: PATH,
        object: Appointments,
        cacheData: CACHE_DATA,
        queryParameters: queryParameters);

    if (jsonResponse != null && jsonResponse.isNotEmpty) {
      return Appointments.fromJson(jsonResponse);
    }

    return null;
  }
}
