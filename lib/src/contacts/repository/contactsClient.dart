import 'package:dio/dio.dart';
import 'package:skg_hagen/src/common/service/client/dioHttpClient.dart';
import 'package:skg_hagen/src/common/service/network.dart';
import 'package:skg_hagen/src/contacts/model/contacts.dart';

class ContactsClient {
  static const String PATH = 'app/contact';
  static const String CACHE_DATA = 'app/contact/data';

  Future<Contacts> getContacts(DioHTTPClient http, Network network,
      {int index, bool refresh}) async {
    final Options options = await http.setGetOptions(http, network, refresh);

    final Map<String, dynamic> jsonResponse = await http.getResponse(
      http: http,
      options: options,
      path: PATH,
      object: Contacts,
      cacheData: CACHE_DATA,
    );

    if (jsonResponse != null) {
      return Contacts.fromJson(jsonResponse);
    }

    return null;
  }
}
