import 'package:dio/dio.dart';
import 'package:skg_hagen/src/common/service/client/dioHttpClient.dart';
import 'package:skg_hagen/src/common/service/network.dart';
import 'package:skg_hagen/src/contacts/dto/contacts.dart';

class ContactsClient {
  static const String PATH = 'app/contact';
  static const String CACHE_DATA = 'app/contact/data';

  Future<Contacts?> getContacts(DioHTTPClient http, Network network,
      {int? index, bool? refresh}) async {
    final Options options = await http.setOptions(http, network, refresh);

    final dynamic jsonResponse = await http.getJSONResponse(
      http: http,
      options: options,
      path: PATH,
      object: Contacts,
      cacheData: CACHE_DATA,
    );

    if (jsonResponse != null && jsonResponse.isNotEmpty) {
      return Contacts.fromJson(jsonResponse);
    }

    return null;
  }
}
