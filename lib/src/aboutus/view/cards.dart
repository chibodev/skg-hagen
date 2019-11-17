import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:skg_hagen/src/aboutus/model/history.dart';
import 'package:skg_hagen/src/aboutus/model/presbytery.dart';
import 'package:skg_hagen/src/common/model/default.dart';
import 'package:skg_hagen/src/common/model/sizeConfig.dart';
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
              subtitle: (card.description.length > 1)
                  ? Text(
                      card.description,
                      style: TextStyle(
                        fontSize: SizeConfig.getSafeBlockVerticalBy(
                            Default.SUBSTANDARD_FONT_SIZE),
                      ),
                    )
                  : null,
            )
          ],
        ),
      ),
    );
  }
}
