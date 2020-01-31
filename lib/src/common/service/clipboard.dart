import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:skg_hagen/src/common/model/default.dart';

class ClipboardService {
  static void copyAndNotify({@required BuildContext context, @required String text}) {
    Clipboard.setData(ClipboardData(text: text));
    Scaffold.of(context).showSnackBar(SnackBar(
      backgroundColor: Color(Default.COLOR_GREEN),
      content: Text(Default.COPIED),
      duration: Duration(seconds: 3),
    ));
  }
}
