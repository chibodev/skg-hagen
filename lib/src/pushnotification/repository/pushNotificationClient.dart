import 'package:dio/dio.dart';
import 'package:skg_hagen/src/common/service/client/dioHttpClient.dart';
import 'package:skg_hagen/src/common/service/network.dart';
import 'package:skg_hagen/src/pushnotification/model/pushNotifications.dart';

class PushNotificationClient {
  static const String PATH = 'app/push/notification';
  static const String CACHE_DATA = 'app/push/notification/data';

  Future<PushNotifications> getPushNotifications(
      DioHTTPClient http, Network network,
      {int index, bool refresh}) async {
    final Options options = await http.setOptions(http, network, refresh);
    final Map<String, dynamic> queryParameters =
        http.getQueryParameters(index: index);

    final dynamic jsonResponse = await http.getJSONResponse(
        http: http,
        options: options,
        path: PATH,
        object: PushNotifications,
        cacheData: CACHE_DATA,
        queryParameters: queryParameters);

    if (jsonResponse != null && jsonResponse.isNotEmpty) {
      return PushNotifications.fromJson(jsonResponse);
    }

    return null;
  }
}
