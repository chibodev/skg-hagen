import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:skg_hagen/src/aboutus/model/history.dart';
import 'package:skg_hagen/src/aboutus/model/presbytery.dart';
import 'package:skg_hagen/src/common/library/globals.dart';
import 'package:skg_hagen/src/common/model/sizeConfig.dart';
import 'package:skg_hagen/src/common/view/customWidget.dart';

class Cards {
  Widget buildRows(dynamic card) {
    final List<Widget> list = List<Widget>();
    String subjectName = "";

    if (card is List<History>) {
      subjectName = History.NAME;
      for (int i = 0; i < card.length; i++) {
        list.add(_buildTileForHistory(card[i]));
      }
    } else if (card is List<Presbytery>) {
      subjectName = Presbytery.NAME;
      for (int i = 0; i < card.length; i++) {
        list.add(_buildTileForPresbytery(card[i]));
      }
    }

    if (card.isEmpty) {
      list.add(CustomWidget.noEntry());
    }

    return ExpansionTile(
      title: CustomWidget.getAccordionTitle(subjectName),
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
                    fontSize:
                        SizeConfig.getSafeBlockVerticalBy(appFont.primarySize),
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
      child: Padding(
        padding: EdgeInsets.only(
          bottom: SizeConfig.getSafeBlockHorizontalBy(0),
        ),
        child: Card(
          child: Column(
            children: <Widget>[
              ListTile(
                leading: Icon(Icons.person),
                title: Text(
                  card.getPresbyter(),
                  style: TextStyle(
                    fontSize:
                        SizeConfig.getSafeBlockVerticalBy(appFont.primarySize),
                  ),
                ),
                subtitle: (card.description.length > 1)
                    ? Text(
                        card.description,
                        style: TextStyle(
                          fontSize: SizeConfig.getSafeBlockVerticalBy(
                              appFont.secondarySize),
                        ),
                      )
                    : null,
              )
            ],
          ),
        ),
      ),
    );
  }
}
