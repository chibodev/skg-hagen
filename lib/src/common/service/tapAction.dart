import 'dart:io';

import 'package:map_launcher/map_launcher.dart';
import 'package:url_launcher/url_launcher.dart';

class TapAction {
  void sendMail(String email, String title, {String body}) async {
    final String subject = Platform.isIOS ? Uri.encodeComponent(title) : title;

    final String bodyContent =
        body != null && Platform.isIOS ? Uri.encodeComponent(body) : body;

    String uri = 'mailto:$email?subject=$subject';
    uri = body != null ? "$uri&body=$bodyContent" : uri;

    if (await canLaunch(uri)) {
      await launch(uri);
    } else {
      throw 'Could not launch $uri';
    }
  }

  void openMap(String longLat, String name) async {
    final bool noLongLat = longLat == null;

    if (noLongLat == true) {
      return;
    }

    final List<String> location = longLat.split(',');

    final List<AvailableMap> availableMaps = await MapLauncher.installedMaps;

    await availableMaps.first.showMarker(
        coords: Coords(double.parse(location[0]), double.parse(location[1])),
        description: "Längen- und Breitengrad: $longLat",
        title: name);
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
    // Android and iOS
    final String uri = 'tel:${Uri.encodeComponent(phoneNumber)}';
    if (await canLaunch(uri)) {
      await launch(uri);
    } else {
      throw 'Could not launch $uri';
    }
  }
}
