import 'package:flutter/material.dart';
import 'package:skg_hagen/src/common/model/default.dart';
import 'package:skg_hagen/src/common/model/sizeConfig.dart';
import 'package:skg_hagen/src/common/service/tapAction.dart';
import 'package:skg_hagen/src/common/view/customWidget.dart';
import 'package:skg_hagen/src/offer/model/group.dart';
import 'package:skg_hagen/src/offer/model/music.dart';
import 'package:skg_hagen/src/offer/model/offer.dart';
import 'package:skg_hagen/src/offer/view/music.dart' as View;

class Cards {
  Widget buildRows(BuildContext context, dynamic card) {
    final List<Widget> list = List<Widget>();

    if (card is List<Offer>) {
      for (int i = 0; i < card.length; i++) {
        list.add(_buildTileForOffers(card[i]));
      }
    } else if (card is List<Group>) {
      for (int i = 0; i < card.length; i++) {
        list.add(_buildTileForGroups(card[i]));
      }
    } else if (card is List<Music>) {
      for (int i = 0; i < card.length; i++) {
        list.add(_buildTileForMusic(context, card[i]));
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
                  _getEmail(
                      card.getFormattedOrganiser(), card.email, card.title),
                  (card.address.street == null || card.address.name == null)
                      ? CustomWidget.getNoLocation()
                      : CustomWidget.getAddressWithAction(card.address, room: card.room),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTileForGroups(Group card) {
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
                  _getEmail(
                      card.getFormattedOrganiser(), card.email, card.title),
                  (card.address.street == null || card.address.name == null)
                      ? CustomWidget.getNoLocation()
                      : CustomWidget.getAddressWithAction(card.address, room: card.room),
                ],
              ),
            ),
          ],
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
                      Icons.info_outline,
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

  Padding _getEmail(String organizer, String email, String title) {
    return Padding(
      padding: EdgeInsets.only(
        left: SizeConfig.getSafeBlockVerticalBy(2),
        top: SizeConfig.getSafeBlockVerticalBy(1),
        bottom: SizeConfig.getSafeBlockVerticalBy(2),
      ),
      child: Row(
        children: <Widget>[
          Flexible(
            child: (organizer != null) ? Text(
              organizer,
              overflow: TextOverflow.visible,
              style: TextStyle(
                color: Colors.grey,
                fontSize: SizeConfig.getSafeBlockVerticalBy(
                    Default.SUBSTANDARD_FONT_SIZE),
              ),
            ) : Container(),
          ),
          (email != null) ? InkWell(
            splashColor: Color(Default.COLOR_GREEN),
            onTap: () => TapAction().sendMail(email, title),
            child: Padding(
              padding: EdgeInsets.only(
                left: SizeConfig.getSafeBlockVerticalBy(1),
              ),
              child: Icon(
                Icons.email,
                color: Colors.grey,
                size: SizeConfig.getSafeBlockVerticalBy(4),
                semanticLabel: 'Email',
              ),
            ),
          ) : Container(),
        ],
      ),
    );
  }
}
