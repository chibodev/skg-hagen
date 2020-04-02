import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:skg_hagen/src/common/library/globals.dart';
import 'package:skg_hagen/src/common/model/sizeConfig.dart';
import 'package:skg_hagen/src/common/service/tapAction.dart';

class Page {
  Widget buildHtml(String content) {
    final double thirty = SizeConfig.getSafeBlockVerticalBy(3.5);
    return SingleChildScrollView(
      child: Html(
        padding: EdgeInsets.all(thirty),
        useRichText: true,
        defaultTextStyle: TextStyle(
          fontSize: SizeConfig.getSafeBlockVerticalBy(appFont.secondarySize),
        ),
        data: content,
        onLinkTap: (String url) {
          if (url.startsWith('http')) {
            TapAction().launchURL(url);
          }
        },
      ),
    );
  }
}
