import 'package:flutter/material.dart';
import 'package:skg_hagen/src/churchyear/controller/singlePageController.dart';
import 'package:skg_hagen/src/churchyear/dto/easterOffer.dart';
import 'package:skg_hagen/src/churchyear/dto/easterOffer/resurrectionStation.dart';
import 'package:skg_hagen/src/churchyear/dto/easterOffer/station.dart';
import 'package:skg_hagen/src/churchyear/dto/info.dart';
import 'package:skg_hagen/src/common/dto/default.dart';
import 'package:skg_hagen/src/common/dto/sizeConfig.dart';
import 'package:skg_hagen/src/common/library/globals.dart';
import 'package:skg_hagen/src/common/view/customWidget.dart';

class Cards {
  late BuildContext _buildContext;
  late bool _dataAvailable;

  Widget buildRows(BuildContext context, dynamic card, bool dataAvailable) {
    this._buildContext = context;
    this._dataAvailable = dataAvailable;
    String subjectName = "";

    final List<Widget> list = <Widget>[];
    if (card is ResurrectionStation) {
      subjectName = EasterOffer.NAME;
      list.add(_buildTileForInfo(card.info));
      for (int i = 0; i < card.station.length; i++) {
        list.add(_buildTileForEasterOffer(card.station[i]));
      }
    }

    return card != null
        ? ExpansionTile(
            title: CustomWidget.getAccordionTitle(subjectName),
            children: list,
          )
        : Container();
  }

  Widget _buildTileForInfo(Info info) {
    return Material(
      child: Padding(
        padding: EdgeInsets.only(
          bottom: SizeConfig.getSafeBlockHorizontalBy(3),
        ),
        child: Card(
          elevation: 7,
          child: InkWell(
            splashColor: Color(Default.COLOR_GREEN),
            onTap: () => Navigator.push(
              _buildContext,
              MaterialPageRoute<dynamic>(
                builder: (BuildContext _context) => SinglePageController(
                  content: info,
                  context: _context,
                  dataAvailable: this._dataAvailable,
                  title: info.title,
                ),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Flexible(
                    child: Container(
                  child: Padding(
                    padding: const EdgeInsets.all(1.0),
                    child: ListTile(
                      leading: Icon(
                        Icons.info,
                        color: Color(Default.COLOR_GREEN),
                        size:
                            SizeConfig.getSafeBlockVerticalBy(appFont.iconSize),
                      ),
                      title: CustomWidget.getCardTitle(info.title),
                    ),
                  ),
                )),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTileForEasterOffer(Station station) {
    return Material(
      child: Padding(
        padding: EdgeInsets.only(
          bottom: SizeConfig.getSafeBlockHorizontalBy(3),
        ),
        child: Card(
          elevation: 7,
          child: InkWell(
            splashColor: Color(Default.COLOR_GREEN),
            onTap: () => Navigator.push(
              _buildContext,
              MaterialPageRoute<dynamic>(
                builder: (BuildContext _context) => SinglePageController(
                  content: station,
                  context: _context,
                  dataAvailable: this._dataAvailable,
                  title: station.title,
                ),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Flexible(
                    child: Container(
                  child: Padding(
                    padding: const EdgeInsets.all(1.0),
                    child: ListTile(
                      leading: Icon(
                        Icons.highlight,
                        color: Color(Default.COLOR_GREEN),
                        size:
                            SizeConfig.getSafeBlockVerticalBy(appFont.iconSize),
                      ),
                      title: CustomWidget.getCardTitle(station.title),
                    ),
                  ),
                )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
