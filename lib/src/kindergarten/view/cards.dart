import 'package:flutter/material.dart';
import 'package:skg_hagen/src/common/service/tapAction.dart';
import 'package:skg_hagen/src/kindergarten/model/events.dart';
import 'package:skg_hagen/src/kindergarten/view/news.dart';

class Cards {
  BuildContext _context;

  Widget buildRows(BuildContext context, var card) {
    this._context = context;

    List<Widget> list = List<Widget>();

    if (card is List<Events>)
      for (var i = 0; i < card.length; i++) {
        list.add(_buildTileForEvents(card[i]));
      }
    else
      for (var i = 0; i < card.length; i++) {
        list.add(_buildTileForNews(card[i]));
      }

    return ExpansionTile(
      title: Text(card.first.getName()),
      children: list,
    );
  }

  Widget _buildTileForEvents(var card) {
    return Material(
      child: Card(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(left: 10.0, top: 10),
                    child: Text(card.title),
                  ),
                  Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Text(
                      card.getFormattedTime(),
                      style: TextStyle(
                          color: Colors.grey, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Divider(),
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: Text(card.comment),
                  ),
                ],
              ),
            ),
            Container(
              width: 70,
              height: 100,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  InkWell(
                    splashColor: Color(0xFF8EBC6B),
                    onTap: () => TapAction().launchURL(card.link),
                    child: Image.asset('assets/images/icon/radiohagen.png'),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildTileForNews(var card) {
    return Material(
      child: Card(
        child: InkWell(
          splashColor: Color(0xFF8EBC6B),
          onTap: () => Navigator.push(
            _context,
            MaterialPageRoute(
              builder: (BuildContext _context) => News(news: card),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(left: 10.0, top: 10),
                      child: Text(card.title),
                    ),
                    Padding(
                      padding: EdgeInsets.all(10.0),
                      child: Text(
                        card.getFormattedTime(),
                        style: TextStyle(
                            color: Colors.grey, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(3.0),
                    ),
                  ],
                ),
              ),
              Container(
                width: 70,
                height: 100,
                color: Color(0xFF8EBC6B),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(
                      Icons.info_outline,
                      color: Colors.white,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
