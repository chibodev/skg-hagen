library skg_hagen.globals;

import 'package:shared_preferences/shared_preferences.dart';
import 'package:skg_hagen/src/common/model/font.dart';

SharedPreferences sharedPreferences;
Font appFont;

bool hasCache(String path) {
  return sharedPreferences.containsKey(path);
}
