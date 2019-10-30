import 'dart:io';

class Network {
  Future<bool> hasInternet() async {
    bool hasInternet;

    try {
      final List<InternetAddress> result =
          await InternetAddress.lookup('example.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        hasInternet = true;
      }
    } on SocketException catch (_) {
      hasInternet = false;
    }

    return hasInternet;
  }
}
