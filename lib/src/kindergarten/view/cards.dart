import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:skg_hagen/src/common/model/default.dart';
import 'package:skg_hagen/src/common/model/sizeConfig.dart';
import 'package:skg_hagen/src/common/view/customWidget.dart';
import 'package:skg_hagen/src/kindergarten/model/events.dart';
import 'package:skg_hagen/src/kindergarten/model/news.dart' as Model;
import 'package:skg_hagen/src/kindergarten/view/news.dart';

class Cards {
  BuildContext _context;

  Widget buildRows(BuildContext context, dynamic card) {
    this._context = context;

    final List<Widget> list = List<Widget>();
    String subjectName = "";

    if (card is List<Events>) {
      subjectName = Events.NAME;
      for (int i = 0; i < card.length; i++) {
        list.add(_buildTileForEvents(card[i]));
      }
    } else if (card is List<Model.News>) {
      subjectName = Model.News.NAME;
      for (int i = 0; i < card.length; i++) {
        list.add(_buildTileForNews(card[i]));
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

  Widget _buildTileForEvents(Events card) {
    return Material(
      child: Padding(
        padding: EdgeInsets.only(
          bottom: SizeConfig.getSafeBlockHorizontalBy(3),
        ),
        child: Slidable(
          actionPane: SlidableDrawerActionPane(),
          actionExtentRatio: 0.25,
          actions: <Widget>[
            CustomWidget.getSlidableShare(
              card.title,
              Default.getSharableContent(
                card.title,
                card.getFormattedOccurrence(),
                card.comment,
                card?.address,
              ),
            ),
          ],
          child: Card(
            elevation: 7,
            shape: Border(
              left: BorderSide(
                color: Color(Default.COLOR_GREEN),
                width: SizeConfig.getSafeBlockHorizontalBy(1),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      CustomWidget.getCardTitle(card.title),
                      CustomWidget.getOccurrence(
                        card.getFormattedOccurrence(),
                      ),
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
      child: Padding(
        padding: EdgeInsets.only(
          bottom: SizeConfig.getSafeBlockHorizontalBy(3),
        ),
        child: Card(
          elevation: 7,
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
                        Icons.info,
                        color: Color(Default.COLOR_GREEN),
                      ),
                      title: CustomWidget.getCardTitle(card.title),
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
