library skg_hagen.globals;

import 'package:shared_preferences/shared_preferences.dart';

SharedPreferences sharedPreferences;

bool hasCache(String path) {
  return sharedPreferences.containsKey(path);
}