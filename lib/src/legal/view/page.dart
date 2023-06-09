import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:skg_hagen/src/common/dto/sizeConfig.dart';
import 'package:skg_hagen/src/common/library/globals.dart';
import 'package:skg_hagen/src/common/service/tapAction.dart';

class LegalPage {
  Widget buildHtml(String content) {
    final double thirty = SizeConfig.getSafeBlockVerticalBy(3.5);
    return SingleChildScrollView(
      child: Html(
        style: {
          "body": Style(
            padding: EdgeInsets.all(thirty),
          ),
          "html": Style.fromTextStyle(TextStyle(
            fontSize: SizeConfig.getSafeBlockVerticalBy(appFont.secondarySize),
          )),
        },
        data: content,
        onLinkTap: (String? url, RenderContext context,
            Map<String, String> attributes, dynamic element) async {
          if (url != null && url.startsWith('http')) {
            TapAction().launchURL(url);
          }
        },
      ),
    );
  }
}
