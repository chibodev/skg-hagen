import 'package:flutter/material.dart';
import 'package:skg_hagen/src/common/model/default.dart';
import 'package:skg_hagen/src/common/model/sizeConfig.dart';
import 'package:skg_hagen/src/common/service/tapAction.dart';
import 'package:skg_hagen/src/common/view/customWidget.dart';
import 'package:skg_hagen/src/offer/model/offer.dart';

class Cards {
  Widget buildRows(dynamic card) {
    final List<Widget> list = List<Widget>();

    if (card is List<Offer>)
      for (int i = 0; i < card.length; i++) {
        list.add(_buildTileForOffers(card[i]));
      }
    else
      for (int i = 0; i < card.length; i++) {
        list.add(_buildTileForGroups(card[i]));
      }

    return ExpansionTile(
      title: CustomWidget.getAccordionTitle(card.first.getName()),
      children: list,
    );
  }

  Widget _buildTileForOffers(dynamic card) {
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
                      : CustomWidget.getAddressWithAction(card.address),
                ],
              ),
            ),

          ],
        ),
      ),
    );
  }

  Widget _buildTileForGroups(dynamic card) {
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
                  CustomWidget.getAddressWithAction(card.address),
                ],
              ),
            ),

          ],
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
          Text(
            organizer,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: Colors.grey,
              fontSize: SizeConfig.getSafeBlockVerticalBy(
                  Default.SUBSTANDARD_FONT_SIZE),
            ),
          ),
          InkWell(
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
          )
        ],
      ),
    );
  }
}
