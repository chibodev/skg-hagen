library skg_hagen.globals;

import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:skg_hagen/src/common/dto/font.dart';

SharedPreferences sharedPreferences;
Font appFont;
RemoteConfig remoteConfig;

bool hasCache(String path) {
  return sharedPreferences.containsKey(path);
}
