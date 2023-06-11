import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:skg_hagen/src/common/dto/address.dart';
import 'package:skg_hagen/src/common/dto/default.dart';
import 'package:skg_hagen/src/common/dto/sizeConfig.dart';
import 'package:skg_hagen/src/common/library/globals.dart';
import 'package:skg_hagen/src/common/service/clipboard.dart';
import 'package:skg_hagen/src/common/service/tapAction.dart';
import 'package:skg_hagen/src/common/view/customWidget.dart';
import 'package:skg_hagen/src/contacts/dto/contact.dart';
import 'package:skg_hagen/src/contacts/dto/social.dart';

class Cards {
  late BuildContext _buildContext;

  Widget buildRows(dynamic card, BuildContext context) {
    this._buildContext = context;
    final List<Widget> list = <Widget>[];
    String subjectName = "";

    if (card is List<Address>) {
      subjectName = Address.NAME;
      for (int i = 0; i < card.length; i++) {
        list.add(
          _buildTileForAddress(card[i]),
        );
      }
    } else if (card is List<Contact>) {
      subjectName = Contact.NAME;
      for (int i = 0; i < card.length; i++) {
        list.add(_buildTileForContacts(card[i]));
      }
    } else if (card is List<Social>) {
      subjectName = Social.NAME;
      for (int i = 0; i < card.length; i++) {
        list.add(_buildTileForSocial(card[i]));
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

  Widget _buildTileForAddress(Address card) {
    return Material(
      child: Padding(
        padding: EdgeInsets.only(
          bottom: SizeConfig.getSafeBlockHorizontalBy(3),
        ),
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
                    Slidable(
                      startActionPane: ActionPane(
                        motion: const DrawerMotion(),
                        extentRatio: Default.SLIDE_RATIO,
                        children: <Widget>[CustomWidget.getSlidableShare(card.getCapitalizedAddressName(), card.toString())],
                      ),
                      child: Container(
                        padding: EdgeInsets.zero,
                        height: SizeConfig.getSafeBlockVerticalBy(14),
                        width: SizeConfig.getSafeBlockHorizontalBy(100),
                        child: _getImageByName(card.name ?? ""),
                      ),
                    ),
                    (card.street == null || card.name == null) ? CustomWidget.getNoLocation() : CustomWidget.getAddressWithAction(card)
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
    final Color color = card.administration == 0 ? Color(Default.COLOR_GREEN) : Colors.white;
    return Material(
      child: Card(
        color: color,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            _getCircleAvatar(card.imageUrl ?? "", color),
            _getContacts(card),
            card.administration == 0
                ? _getAddressWithoutAction(card.address, noColor: true, textColor: true)
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
            left: BorderSide(
              color: Color(Default.COLOR_GREEN),
              width: SizeConfig.getSafeBlockHorizontalBy(1),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Slidable(
                  startActionPane: ActionPane(
                    motion: const DrawerMotion(),
                    extentRatio: Default.SLIDE_RATIO,
                    children: <Widget>[CustomWidget.getSlidableShare(card.name, Default.getSharableContent(card.url))],
                  ),
                  child: _getSocialMediaIcon(card)),
            ],
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
                height: SizeConfig.getSafeBlockHorizontalBy(appFont.imageIconSize),
              ),
              title: Text(
                card.location,
                style: TextStyle(
                  fontSize: SizeConfig.getSafeBlockVerticalBy(appFont.primarySize),
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
          CustomWidget.getCardTitle(card.getContactName(), textColor: card.administration == 0),
          CustomWidget.getCardSubtitle(card.role, textColor: card.administration == 0),
          _getPhoneAndEmail(card.phone, card.email, card.role)
        ],
      ),
    );
  }

  Widget _getAddressWithoutAction(Address address, {bool? noColor, bool? textColor}) {
    return Expanded(
      child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            address.street != null
                ? Text(
                    address.getStreetAndNumber(),
                    style: TextStyle(
                      color: textColor == false ? Color(Default.COLOR_GREEN) : Colors.white,
                      fontSize: SizeConfig.getSafeBlockVerticalBy(appFont.primarySize),
                    ),
                  )
                : Text(''),
            address.zip != null
                ? Text(
                    address.getZipAndCity(),
                    style: TextStyle(
                      color: textColor == false ? Color(Default.COLOR_GREEN) : Colors.white,
                      fontSize: SizeConfig.getSafeBlockVerticalBy(appFont.primarySize),
                    ),
                  )
                : Text(''),
          ],
        ),
      ),
    );
  }

  Widget _getOpening(String opening, {bool? colorWhite}) {
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
                  fontSize: SizeConfig.getSafeBlockVerticalBy(appFont.primarySize),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: twenty, right: twenty, bottom: twenty),
              child: Text(
                opening,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: SizeConfig.getSafeBlockVerticalBy(appFont.primarySize),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Column _getCircleAvatar(String imageUrl, Color color) {
    return imageUrl.length < 2
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
                  onLongPress: () => ClipboardService.copyAndNotify(context: _buildContext, text: phone),
                  child: Padding(
                    padding: EdgeInsets.only(
                      left: SizeConfig.getSafeBlockVerticalBy(1),
                      bottom: SizeConfig.getSafeBlockVerticalBy(1),
                    ),
                    child: Icon(
                      Icons.phone,
                      color: Colors.black,
                      size: SizeConfig.getSafeBlockVerticalBy(appFont.iconSize),
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
                  onLongPress: () => ClipboardService.copyAndNotify(context: this._buildContext, text: email),
                  child: Padding(
                    padding: EdgeInsets.only(
                      left: SizeConfig.getSafeBlockVerticalBy(5),
                      bottom: SizeConfig.getSafeBlockVerticalBy(1),
                    ),
                    child: Icon(
                      Icons.email,
                      color: Colors.black,
                      size: SizeConfig.getSafeBlockVerticalBy(appFont.iconSize),
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

  Image? _getImageByName(String name) {
    Image? image;
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
