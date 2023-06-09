import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:skg_hagen/src/common/dto/default.dart';

class ClipboardService {
  static void copyAndNotify(
      {required BuildContext context, required String text}) {
    Clipboard.setData(ClipboardData(text: text));
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      backgroundColor: Color(Default.COLOR_GREEN),
      content: Text(Default.COPIED),
      duration: Duration(seconds: 3),
    ));
  }
}
