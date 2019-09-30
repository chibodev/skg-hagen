import 'dart:io';

import 'package:skg_hagen/src/common/model/location.dart';
import 'package:url_launcher/url_launcher.dart';

class TapAction {
  void sendMail(String email, String title) async {
    // Android and iOS
    final String uri = 'mailto:chibodev@gmail.com?subject=Angebot: $title';
    if (await canLaunch(uri)) {
      await launch(uri);
    } else {
      throw 'Could not launch $uri';
    }
  }

  void openMap(String location) async {
    // Android
    final String longLat = Location(location).getLongtideLatitude();

    if (longLat != null){
      String url = 'geo:$longLat';
      if (Platform.isIOS) {
        // iOS
        url = 'http://maps.apple.com/?ll=$longLat';
      }
      if (await canLaunch(url)) {
        await launch(url);
      } else {
        throw 'Could not launch $url';
      }
    }
  }

  void callMe(String phoneNumber) async {
    // Android
    final String uri = 'tel:$phoneNumber';
    if (await canLaunch(uri)) {
      await launch(uri);
    } else {
      // iOS
      //TODO conver + to 00
      final String uri = 'tel:$phoneNumber';
      if (await canLaunch(uri)) {
        await launch(uri);
      } else {
        throw 'Could not launch $uri';
      }
    }
  }
}
