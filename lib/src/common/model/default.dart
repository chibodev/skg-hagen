import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:skg_hagen/src/common/model/sizeConfig.dart';

class Default {
  static const int COLOR_GREEN = 0xFF8EBC6B;
  static const int START_INDEX = 0;
  static const int MAX_PAGE_RANGE = 10;

  static String capitalize(String value) =>
      value[0].toUpperCase() + value.substring(1);

  static Map<String, dynamic> getQueryParameters({int index = 0}) {
    final Map<String, dynamic> queryParameters = HashMap<String, dynamic>();
    queryParameters.putIfAbsent(
        "index",
        () => (index == null || index <= 0)
            ? START_INDEX
            : Default.MAX_PAGE_RANGE * index);
    queryParameters.putIfAbsent("page", () => Default.MAX_PAGE_RANGE);

    return queryParameters;
  }
}
