import 'package:flutter/material.dart';
import 'package:skg_hagen/src/common/service/tapAction.dart';
import 'package:skg_hagen/src/offer/model/offer.dart';

class Cards {
  Widget buildRows(var card) {
    List<Widget> list = List<Widget>();

    if (card is List<Offer>)
      for (var i = 0; i < card.length; i++) {
        list.add(_buildTileForOffers(card[i]));
      }
    else
      for (var i = 0; i < card.length; i++) {
        list.add(_buildTileForGroups(card[i]));
      }

    return ExpansionTile(
      title: Text(card.first.getName()),
      children: list,
    );
  }

  Widget _buildTileForOffers(var card) {
    final String organizer =
        (card.organizer != null) ? 'Infos: ' + card.organizer : '';
    return Material(
      child: Card(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(left: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.all(3.0),
                    child: Text(card.title),
                  ),
                  Padding(
                    padding: EdgeInsets.all(3.0),
                    child: Text(
                      card.getFormatted(),
                      style: TextStyle(
                          color: Colors.grey, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Padding(
                      padding: EdgeInsets.all(3.0),
                      child: Row(
                        children: <Widget>[
                          Text(organizer,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(color: Colors.grey)),
                          InkWell(
                            splashColor: Color(0xFF8EBC6B),
                            onTap: () =>
                                TapAction().sendMail(card.email, card.title),
                            child: Padding(
                              padding: EdgeInsets.only(left: 10),
                              child: Icon(
                                Icons.email,
                                color: Colors.grey,
                                size: 20.0,
                                semanticLabel:
                                    'Text to announce in accessibility modes',
                              ),
                            ),
                          )
                        ],
                      )),
                ],
              ),
            ),
            Container(
              color: Color(0xFF8EBC6B),
              width: 125,
              height: 100,
              child: InkWell(
                splashColor: Color(0xFF8EBC6B),
                onTap: () =>
                    TapAction().openMap(card.address.churchName),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(card.address.churchName,
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold)),
                    Text(card.address.address1,
                        style: TextStyle(color: Colors.white)),
                    Text(card.address.getZipAndCity(),
                        style: TextStyle(color: Colors.white)),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildTileForGroups(var card) {
    return Material(
      child: Card(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(left: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.all(3.0),
                    child: Text(card.title),
                  ),
                  Padding(
                    padding: EdgeInsets.all(3.0),
                    child: Text(
                      card.getFormatted(),
                      style: TextStyle(
                          color: Colors.grey, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              color: Color(0xFF8EBC6B),
              width: 125,
              height: 100,
              child: InkWell(
                splashColor: Color(0xFF8EBC6B),
                onTap: () =>
                    TapAction().openMap(card.address.churchName),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(card.address.churchName,
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold)),
                    Text(card.address.address1,
                        style: TextStyle(color: Colors.white)),
                    Text(card.address.getZipAndCity(),
                        style: TextStyle(color: Colors.white)),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
