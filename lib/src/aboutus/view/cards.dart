import 'package:flutter/material.dart';
import 'package:skg_hagen/src/aboutus/model/history.dart';
import 'package:skg_hagen/src/aboutus/model/imprint.dart';
import 'package:skg_hagen/src/aboutus/model/presbytery.dart';
import 'package:skg_hagen/src/common/model/default.dart';
import 'package:skg_hagen/src/common/model/sizeConfig.dart';
import 'package:skg_hagen/src/common/service/tapAction.dart';
import 'package:skg_hagen/src/common/view/customWidget.dart';

class Cards {
  Widget buildRows(dynamic card) {
    final List<Widget> list = List<Widget>();

    if (card is List<History>)
      for (int i = 0; i < card.length; i++) {
        list.add(_buildTileForHistory(card[i]));
      }
    else if (card is List<Presbytery>)
      for (int i = 0; i < card.length; i++) {
        list.add(_buildTileForPresbytery(card[i]));
      }
    else if (card is List<Imprint>)
      for (int i = 0; i < card.length; i++) {
        list.add(_buildTileForImprint(card[i]));
      }

    return ExpansionTile(
      title: CustomWidget.getAccordionTitle(card.first.getName()),
      children: list,
    );
  }

  Widget _buildTileForHistory(History card) {
    final double thirty = SizeConfig.getSafeBlockVerticalBy(4);
    return Material(
      child: Card(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Flexible(
              child: Padding(
                padding: EdgeInsets.all(thirty),
                child: SelectableText(
                  card.description,
                  style: TextStyle(
                    fontSize: SizeConfig.getSafeBlockVerticalBy(
                        Default.STANDARD_FONT_SIZE),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTileForPresbytery(Presbytery card) {
    return Material(
      child: Card(
        child: Column(
          children: <Widget>[
            ListTile(
              leading: Icon(Icons.person),
              title: Text(
                card.getPresbyter(),
                style: TextStyle(
                  fontSize: SizeConfig.getSafeBlockVerticalBy(
                      Default.STANDARD_FONT_SIZE),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildTileForImprint(Imprint card) {
    return Material(
      child: Card(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Flexible(
              child: InkWell(
                splashColor: Color(Default.COLOR_GREEN),
                onTap: () => TapAction().launchURL(card.url),
                child: Padding(
                  padding: EdgeInsets.all(
                    SizeConfig.getSafeBlockVerticalBy(2),
                  ),
                  child: Text(
                    //TODO replace txt with icon for url
                    card.url,
                    style: TextStyle(
                      fontSize: SizeConfig.getSafeBlockVerticalBy(
                          Default.STANDARD_FONT_SIZE),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
