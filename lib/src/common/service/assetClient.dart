import 'package:flutter/services.dart';

class AssetClient {
  Future<String> loadAsset(String path) async {
    String asset;

     await rootBundle.loadString(path).then((String onValue) {
       asset = onValue;
     });

     return asset;
  }
}