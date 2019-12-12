import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:skg_hagen/src/common/model/default.dart';
import 'package:skg_hagen/src/common/model/sizeConfig.dart';
import 'package:skg_hagen/src/common/service/tapAction.dart';
import 'package:skg_hagen/src/common/view/customWidget.dart';
import 'package:skg_hagen/src/offer/model/music.dart';
import 'package:skg_hagen/src/offer/model/offer.dart';
import 'package:skg_hagen/src/offer/model/project.dart';
import 'package:skg_hagen/src/offer/view/music.dart' as View;
import 'package:skg_hagen/src/offer/view/projects.dart';

class Cards {
  BuildContext _buildContext;

  Widget buildRows(BuildContext context, dynamic card) {
    this._buildContext = context;

    final List<Widget> list = List<Widget>();

    if (card is List<Offer>) {
      for (int i = 0; i < card.length; i++) {
        list.add(_buildTileForOffers(card[i]));
      }
    } else if (card is List<Music>) {
      for (int i = 0; i < card.length; i++) {
        list.add(_buildTileForMusic(context, card[i]));
      }
    } else if (card is List<Project>) {
      for (int i = 0; i < card.length; i++) {
        list.add(_buildTileForProjects(context, card[i]));
      }
    }

    return card != null
        ? ExpansionTile(
            title: CustomWidget.getAccordionTitle(card?.first?.getName()),
            children: list.length > 0 ? list : Container(),
          )
        : Container();
  }

  Widget _buildTileForOffers(Offer card) {
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
                  CustomWidget.getCardOrganizerWithEmail(
                      card.getFormattedOrganiser(),
                      card.email,
                      card.title,
                      this._buildContext),
                  (card.address.street == null || card.address.name == null)
                      ? CustomWidget.getNoLocation()
                      : CustomWidget.getAddressWithAction(card.address,
                          room: card.room),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTileForProjects(BuildContext context, Project card) {
    return Material(
      child: Card(
        child: InkWell(
          splashColor: Color(Default.COLOR_GREEN),
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute<dynamic>(
              builder: (BuildContext _context) => Projects(
                projects: card,
                context: context,
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
    );
  }

  Widget _buildTileForMusic(BuildContext context, Music card) {
    return Material(
      child: Card(
        child: InkWell(
          splashColor: Color(Default.COLOR_GREEN),
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute<dynamic>(
              builder: (BuildContext _context) => View.Music(
                music: card,
                context: context,
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
    );
  }
}
