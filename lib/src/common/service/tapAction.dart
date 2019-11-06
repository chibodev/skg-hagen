import 'dart:io';

import 'package:skg_hagen/src/common/model/location.dart';
import 'package:url_launcher/url_launcher.dart';

class TapAction {
  void sendMail(String email, String title) async {
    // Android and iOS
    final String uri = 'mailto:$email?subject=$title';
    if (await canLaunch(uri)) {
      await launch(uri);
    } else {
      throw 'Could not launch $uri';
    }
  }

  void openMap(String location) async {
    // Android
    final String longLat =
        Location(location.toLowerCase()).getLongtideLatitude();

    if (longLat != null) {
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

  void launchURL(String url) async {
    if (url.length > 0) {
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
      throw 'Could not launch $uri';
    }
  }
}
