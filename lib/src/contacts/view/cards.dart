import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:skg_hagen/src/common/model/address.dart';
import 'package:skg_hagen/src/common/model/default.dart';
import 'package:skg_hagen/src/common/model/sizeConfig.dart';
import 'package:skg_hagen/src/common/service/tapAction.dart';
import 'package:skg_hagen/src/common/view/customWidget.dart';
import 'package:skg_hagen/src/contacts/model/contact.dart';
import 'package:skg_hagen/src/contacts/model/social.dart';

class Cards {
  BuildContext _buildContext;

  Widget buildRows(dynamic card, BuildContext context) {
    this._buildContext = context;
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
      title: CustomWidget.getAccordionTitle(card.first.getName()),
      children: list,
    );
  }

  Widget _buildTileForAddress(Address card) {
    return Material(
      child: Padding(
        padding: EdgeInsets.only(
          bottom: SizeConfig.getSafeBlockHorizontalBy(3),
        ),
        child: Card(
          elevation: 7,
          shape: Border(
            right: BorderSide(
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
                    Container(
                      padding: EdgeInsets.zero,
                      height: SizeConfig.getSafeBlockVerticalBy(14),
                      width: SizeConfig.getSafeBlockHorizontalBy(100),
                      child: _getImageByName(card.name),
                    ),
                    (card.street == null || card.name == null)
                        ? CustomWidget.getNoLocation()
                        : CustomWidget.getAddressWithAction(card)
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTileForContacts(Contact card) {
    final Color color =
        card.administration == 0 ? Color(Default.COLOR_GREEN) : Colors.white;
    return Material(
      child: Card(
        color: color,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            _getCircleAvatar(card.imageUrl, color),
            _getContacts(card),
            card.administration == 0
                ? _getAddressWithoutAction(card.address,
                    noColor: true, textColor: true)
                : _getOpening(card.opening, colorWhite: true),
          ],
        ),
      ),
    );
  }

  Widget _buildTileForSocial(Social card) {
    return Material(
      child: Padding(
        padding: EdgeInsets.only(
          bottom: SizeConfig.getSafeBlockHorizontalBy(3),
        ),
        child: Card(
          elevation: 7,
          shape: Border(
            right: BorderSide(
              color: Color(Default.COLOR_GREEN),
              width: SizeConfig.getSafeBlockHorizontalBy(1),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[_getSocialMediaIcon(card)],
          ),
        ),
      ),
    );
  }

  Widget _getSocialMediaIcon(Social card) {
    final String name = card.name.toLowerCase();
    return card.isSocialValid(name)
        ? InkWell(
            splashColor: Color(Default.COLOR_GREEN),
            onTap: () => TapAction().launchURL(card.url),
            child: ListTile(
              leading: Image.asset(
                card.getSocialImage(name),
                fit: BoxFit.scaleDown,
                width: SizeConfig.getSafeBlockVerticalBy(7),
                height: SizeConfig.getSafeBlockHorizontalBy(7),
              ),
              title: Text(
                card.location,
                style: TextStyle(
                  fontSize: SizeConfig.getSafeBlockVerticalBy(
                      Default.SUBSTANDARD_FONT_SIZE),
                ),
              ),
            ),
          )
        : Container();
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
          _getPhoneAndEmail(card.phone, card.email, card.role)
        ],
      ),
    );
  }

  Widget _getAddressWithoutAction(Address address,
      {bool noColor, bool textColor}) {
    return Expanded(
      child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            address.street != null
                ? Text(
                    address.getStreetAndNumber(),
                    style: TextStyle(
                      color: textColor == false
                          ? Color(Default.COLOR_GREEN)
                          : Colors.white,
                      fontSize: SizeConfig.getSafeBlockVerticalBy(
                          Default.SUBSTANDARD_FONT_SIZE),
                    ),
                  )
                : Text(''),
            address.zip != null
                ? Text(
                    address.getZipAndCity(),
                    style: TextStyle(
                      color: textColor == false
                          ? Color(Default.COLOR_GREEN)
                          : Colors.white,
                      fontSize: SizeConfig.getSafeBlockVerticalBy(
                          Default.SUBSTANDARD_FONT_SIZE),
                    ),
                  )
                : Text(''),
          ],
        ),
      ),
    );
  }

  Widget _getOpening(String opening, {bool colorWhite}) {
    final double twenty = SizeConfig.getSafeBlockVerticalBy(2);
    return Expanded(
      child: Container(
        color: Color(Default.COLOR_GREEN),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(twenty),
              child: Text(
                'Öffnungszeiten',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontSize: SizeConfig.getSafeBlockVerticalBy(
                      Default.SUBSTANDARD_FONT_SIZE),
                ),
              ),
            ),
            Padding(
              padding:
                  EdgeInsets.only(left: twenty, right: twenty, bottom: twenty),
              child: Text(
                opening,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: SizeConfig.getSafeBlockVerticalBy(
                      Default.SUBSTANDARD_FONT_SIZE),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Column _getCircleAvatar(String imageUrl, Color color) {
    return imageUrl == null
        ? Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(
                  left: SizeConfig.getSafeBlockVerticalBy(2),
                ),
                child: CircleAvatar(
                  backgroundColor: color,
                  minRadius: SizeConfig.getSafeBlockVerticalBy(4),
                  maxRadius: SizeConfig.getSafeBlockHorizontalBy(8),
                ),
              ),
            ],
          )
        : Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(
                  left: SizeConfig.getSafeBlockVerticalBy(2),
                ),
                child: CircleAvatar(
                  backgroundImage: NetworkImage(
                    imageUrl,
                  ),
                  minRadius: SizeConfig.getSafeBlockVerticalBy(4),
                  maxRadius: SizeConfig.getSafeBlockHorizontalBy(8),
                ),
              ),
            ],
          );
  }

  Padding _getPhoneAndEmail(String phone, String email, String title) {
    return Padding(
      padding: EdgeInsets.only(
        left: SizeConfig.getSafeBlockVerticalBy(1),
      ),
      child: Row(
        children: <Widget>[
          phone != ""
              ? InkWell(
                  splashColor: Color(Default.COLOR_GREEN),
                  onTap: () => TapAction().callMe(phone),
                  onLongPress: () => <void>{
                    Clipboard.setData(ClipboardData(text: phone)),
                    showDialog(
                        context: this._buildContext,
                        builder: (BuildContext context) {
                          return AlertDialog(
                              title: Text('Telefon'),
                              content: SelectableText(phone));
                        }),
                  },
                  child: Padding(
                    padding: EdgeInsets.only(
                      left: SizeConfig.getSafeBlockVerticalBy(1),
                      bottom: SizeConfig.getSafeBlockVerticalBy(1),
                    ),
                    child: Icon(
                      Icons.phone,
                      color: Colors.black,
                      size: SizeConfig.getSafeBlockVerticalBy(3),
                      semanticLabel: 'Phone',
                    ),
                  ),
                )
              : Padding(
                  padding: EdgeInsets.only(
                    left: SizeConfig.getSafeBlockVerticalBy(4),
                    bottom: SizeConfig.getSafeBlockVerticalBy(1),
                  ),
                ),
          email != ""
              ? InkWell(
                  splashColor: Color(Default.COLOR_GREEN),
                  onTap: () => TapAction().sendMail(email, title),
                  onLongPress: () => <void>{
                    Clipboard.setData(ClipboardData(text: email)),
                    showDialog(
                        context: this._buildContext,
                        builder: (BuildContext context) {
                          return AlertDialog(
                              title: Text('E-Mail'),
                              content: SelectableText(email));
                        }),
                  },
                  child: Padding(
                    padding: EdgeInsets.only(
                      left: SizeConfig.getSafeBlockVerticalBy(5),
                      bottom: SizeConfig.getSafeBlockVerticalBy(1),
                    ),
                    child: Icon(
                      Icons.email,
                      color: Colors.black,
                      size: SizeConfig.getSafeBlockVerticalBy(3),
                      semanticLabel: 'E-Mail',
                    ),
                  ),
                )
              : Padding(
                  padding: EdgeInsets.only(
                    left: SizeConfig.getSafeBlockVerticalBy(4),
                    bottom: SizeConfig.getSafeBlockVerticalBy(1),
                  ),
                ),
        ],
      ),
    );
  }

  Image _getImageByName(String name) {
    Image image;
    if (name.contains('johannis')) {
      image = Image.asset(
        Address.MAP_IMAGE_JOHANNISKIRCHE,
        fit: BoxFit.contain,
      );
    }

    if (name.contains('markus')) {
      image = Image.asset(
        Address.MAP_IMAGE_MARKUSKIRCHE,
        fit: BoxFit.contain,
      );
    }

    return image;
  }
}
