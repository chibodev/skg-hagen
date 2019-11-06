import 'package:flutter/material.dart';
import 'package:skg_hagen/src/common/model/address.dart';
import 'package:skg_hagen/src/common/model/default.dart';
import 'package:skg_hagen/src/common/model/sizeConfig.dart';
import 'package:skg_hagen/src/common/service/tapAction.dart';
import 'package:skg_hagen/src/common/view/customWidget.dart';
import 'package:skg_hagen/src/contacts/model/contact.dart';
import 'package:skg_hagen/src/contacts/model/social.dart';

class Cards {
  Widget buildRows(dynamic card) {
    final List<Widget> list = List<Widget>();

    if (card is List<Address>) {
      for (int i = 0; i < card.length; i++) {
        list.add(
          _buildTileForAddress(card[i]),
        );
      }
    } else if (card is List<Contact>) {
      for (int i = 0; i < card.length; i++) {
        list.add(_buildTileForContacts(card[i]));
      }
    } else {
      for (int i = 0; i < card.length; i++) {
        list.add(_buildTileForSocial(card[i]));
      }
    }

    return ExpansionTile(
      title: Text(
        card.first.getName(),
      ),
      children: list,
    );
  }

  Widget _buildTileForAddress(dynamic card) {
    return Material(
      child: Card(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.zero,
                    height: SizeConfig.getSafeBlockVerticalBy(14),
                    width: SizeConfig.getSafeBlockHorizontalBy(100),
                    child: CustomWidget.getImageByName(card.name),
                  ),
                ],
              ),
            ),
            (card.street == null || card.name == null)
                ? CustomWidget.getNoLocation()
                : CustomWidget.getAddressWithAction(card)
          ],
        ),
      ),
    );
  }

  Widget _buildTileForContacts(dynamic card) {
    return Material(
      child: Card(
        color: card.administration == 0
            ? Color(Default.COLOR_GREEN)
            : Colors.white,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            card.administration == 0
                ? CustomWidget.getCircleAvatar(card.imageUrl)
                : Container(),
            _getContacts(card),
            card.administration == 0
                ? CustomWidget.getAddressWithoutAction(card.address,
                    noColor: true, textColor: true)
                : CustomWidget.getOpening(card.opening, colorWhite: true),
          ],
        ),
      ),
    );
  }

  Widget _buildTileForSocial(dynamic card) {
    return Material(
      child: Card(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[_getSocialMediaIcon(card)],
        ),
      ),
    );
  }

  Widget _getSocialMediaIcon(Social card) {
    Widget widget = Container();

    switch (card.name.toLowerCase()) {
      case 'facebook':
        widget = InkWell(
          splashColor: Color(Default.COLOR_GREEN),
          onTap: () => TapAction().launchURL(card.url),
          child: Padding(
            padding: EdgeInsets.all(
              SizeConfig.getSafeBlockVerticalBy(2),
            ),
            child: Image.asset(
              'assets/images/icon/facebook.png',
              fit: BoxFit.scaleDown,
              width: SizeConfig.getSafeBlockVerticalBy(10),
              height: SizeConfig.getSafeBlockHorizontalBy(10),
            ),
          ),
        );
        break;
    }
    return widget;
  }

  Expanded _getContacts(Contact card) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          CustomWidget.getCardTitle(card.getContactName(),
              textColor: card.administration == 0),
          CustomWidget.getCardSubtitle(card.role,
              textColor: card.administration == 0),
          CustomWidget.getPhoneAndEmail(card.phone, card.email, card.role)
        ],
      ),
    );
  }
}
