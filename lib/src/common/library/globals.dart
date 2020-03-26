library skg_hagen.globals;

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:skg_hagen/src/common/model/font.dart';
import 'package:skg_hagen/src/settings/view/settingsMenu.dart';

SharedPreferences sharedPreferences;
Font appFont;
SettingsMenu menu;

bool hasCache(String path) {
  return sharedPreferences.containsKey(path);
}

Widget settingsMenu() {
  return menu.getMenu();
}