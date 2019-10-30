import 'package:flutter/services.dart';

class AssetClient {
  Future<String> loadAsset(String path) async {
    try {
      return await rootBundle.loadString(path);
    } catch (e) {
      throw Exception(e);
    }
  }
}
