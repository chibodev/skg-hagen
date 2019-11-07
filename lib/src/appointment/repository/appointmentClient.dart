import 'package:dio/dio.dart';
import 'package:skg_hagen/src/appointment/model/appointments.dart';
import 'package:skg_hagen/src/common/service/dioHttpClient.dart';
import 'package:skg_hagen/src/common/service/network.dart';

class AppointmentClient {
  static const String PATH = 'app/appointments';

  Future<Appointments> getAppointments(DioHTTPClient http, Network network,
      {int index, bool refresh}) async {
    final Options options = await http.setGetOptions(http, network, refresh);

    final Map<String, dynamic> queryParameters =
        http.getQueryParameters(index: index);

    return await http
        .get(path: PATH, options: options, queryParameters: queryParameters)
        .then((Response<dynamic> response) =>
            Appointments.fromJson(response.data));
  }
}
