import 'package:flutter/material.dart';
import 'package:skg_hagen/src/common/model/default.dart';
import 'package:skg_hagen/src/common/view/customWidget.dart';
import 'package:skg_hagen/src/kindergarten/model/events.dart';
import 'package:skg_hagen/src/kindergarten/model/news.dart' as Model;
import 'package:skg_hagen/src/kindergarten/view/news.dart';

class Cards {
  BuildContext _context;

  Widget buildRows(BuildContext context, dynamic card) {
    this._context = context;

    final List<Widget> list = List<Widget>();

    if (card is List<Events>) {
      for (int i = 0; i < card.length; i++) {
        list.add(_buildTileForEvents(card[i]));
      }
    } else {
      for (int i = 0; i < card.length; i++) {
        list.add(_buildTileForNews(card[i]));
      }
    }

    return ExpansionTile(
      title: CustomWidget.getAccordionTitle(card.first.getName()),
      children: list,
    );
  }

  Widget _buildTileForEvents(Events card) {
    return Material(
      child: Card(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  CustomWidget.getCardTitle(card.title),
                  CustomWidget.getOccurrence(card.getFormattedOccurrence()),
                  _getComment(card.comment),
                    (card.address.name == null || card.address.street == null)
                      ? CustomWidget.getNoLocation()
                      : CustomWidget.getAddressWithAction(card.address)
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _getComment(String comment) {
    if (comment != "" || comment != null) {
      return CustomWidget.getCardSubtitle(comment);
    }
    return null;
  }

  Widget _buildTileForNews(Model.News card) {
    return Material(
      child: Card(
        child: InkWell(
          splashColor: Color(Default.COLOR_GREEN),
          onTap: () => Navigator.push(
            _context,
            MaterialPageRoute<dynamic>(
              builder: (BuildContext _context) => News(
                news: card,
                context: _context,
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
                        Icons.info_outline,
                        color: Color(Default.COLOR_GREEN),
                      ),
                      title: CustomWidget.getCardTitle(card.title),
                    ),
                  ),
                )
              ),
            ],
          ),
        ),
      ),
    );
  }
}
