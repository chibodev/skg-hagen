import 'package:flutter/material.dart';
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
      title: Text(card.first.getName()),
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
                  CustomWidget.getEmail(
                      card.getFormattedOrganiser(), card.email, card.title),
                ],
              ),
            ),
            CustomWidget.getAddress(card.address)
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
                ],
              ),
            ),
            CustomWidget.getAddress(card.address)
          ],
        ),
      ),
    );
  }
}
