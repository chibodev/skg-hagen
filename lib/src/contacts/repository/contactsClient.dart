import 'package:dio/dio.dart';
import 'package:dio_http_cache/dio_http_cache.dart';
import 'package:skg_hagen/src/common/model/dioHttpClient.dart';
import 'package:skg_hagen/src/common/service/network.dart';
import 'package:skg_hagen/src/contacts/model/contacts.dart';

class ContactsClient {
  static const String PATH = 'app/contact';

  Future<Contacts> getContacts(DioHTTPClient http, Network network,
      {int index, bool refresh}) async {
    Options options = buildCacheOptions(
      Duration(days: 7),
      maxStale: Duration(days: 10),
    );

    http.initialiseInterceptors('debug');
    http.initialiseInterceptors('cache');
    http.initialiseInterceptors('token');

    final bool hasInternet = await network.hasInternet();

    if (hasInternet || refresh) {
      options = buildCacheOptions(Duration(days: 7),
          maxStale: Duration(days: 10), forceRefresh: true);
    }

    return await http
        .get(
          path: PATH,
          options: options,
        )
        .then(
          (Response<dynamic> response) => Contacts.fromJson(response.data),
        );
  }
}
