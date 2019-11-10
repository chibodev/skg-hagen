import 'package:flutter/material.dart';
import 'package:skg_hagen/src/common/model/address.dart';
import 'package:skg_hagen/src/common/model/default.dart';
import 'package:skg_hagen/src/common/model/sizeConfig.dart';
import 'package:skg_hagen/src/common/service/tapAction.dart';

class CustomWidget {
  static Padding buildProgressIndicator(bool _isPerformingRequest) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Center(
        child: Opacity(
          opacity: _isPerformingRequest ? 1.0 : 0.0,
          child: CircularProgressIndicator(
            valueColor:
                AlwaysStoppedAnimation<Color>(Color(Default.COLOR_GREEN)),
          ),
        ),
      ),
    );
  }

  static Text getTitle(String name) {
    return Text(
      name,
      style: TextStyle(
        color: Colors.white,
        fontSize: SizeConfig.getSafeBlockVerticalBy(Default.STANDARD_FONT_SIZE),
        shadows: <Shadow>[
          Shadow(
            offset: Offset(SizeConfig.getSafeBlockVerticalBy(0.2),
                SizeConfig.getSafeBlockVerticalBy(0.2)),
            blurRadius: 3.0,
            color: Colors.black45,
          ),
          Shadow(
            offset: Offset(SizeConfig.getSafeBlockVerticalBy(0.2),
                SizeConfig.getSafeBlockVerticalBy(0.2)),
            blurRadius: 8.0,
            color: Colors.black45,
          ),
        ],
      ),
    );
  }

  static Padding getCardTitle(String title, {bool textColor}) {
    return Padding(
      padding: EdgeInsets.only(
        left: SizeConfig.getSafeBlockVerticalBy(2),
        top: SizeConfig.getSafeBlockVerticalBy(2),
      ),
      child: Text(
        title,
        style: TextStyle(
          fontSize:
              SizeConfig.getSafeBlockVerticalBy(Default.STANDARD_FONT_SIZE),
          color: textColor == true ? Colors.white : Colors.black,
        ),
      ),
    );
  }

  static Padding getOccurrence(String occurrence) {
    return Padding(
      padding: EdgeInsets.only(
        left: SizeConfig.getSafeBlockVerticalBy(2),
        top: SizeConfig.getSafeBlockVerticalBy(1),
        bottom: SizeConfig.getSafeBlockVerticalBy(1),
      ),
      child: Text(
        occurrence,
        style: TextStyle(
          color: Colors.grey,
          fontWeight: FontWeight.bold,
          fontSize:
              SizeConfig.getSafeBlockVerticalBy(Default.STANDARD_FONT_SIZE),
        ),
      ),
    );
  }

  static Container getAddressWithAction(Address address) {
    return Container(
      width: SizeConfig.screenHeight,
      height: SizeConfig.getSafeBlockHorizontalBy(22.5),
      decoration: BoxDecoration(color: Color(Default.COLOR_GREEN)),
      child: InkWell(
        splashColor: Color(Default.COLOR_GREEN),
        onTap: () => TapAction().openMap(address.latLong, address.name),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              Default.capitalize(address.name),
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: SizeConfig.getSafeBlockVerticalBy(
                    Default.SUBSTANDARD_FONT_SIZE),
              ),
            ),
            Text(
              address.getStreetAndNumber(),
              style: TextStyle(
                color: Colors.white,
                fontSize: SizeConfig.getSafeBlockVerticalBy(
                    Default.SUBSTANDARD_FONT_SIZE),
              ),
            ),
            Text(
              address.getZipAndCity(),
              style: TextStyle(
                color: Colors.white,
                fontSize: SizeConfig.getSafeBlockVerticalBy(
                    Default.SUBSTANDARD_FONT_SIZE),
              ),
            ),
          ],
        ),
      ),
    );
  }

  static Widget getAddressWithoutAction(Address address,
      {bool noColor, bool textColor}) {
    return Expanded(
      child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              address.getStreetAndNumber(),
              style: TextStyle(
                color: textColor == false
                    ? Color(Default.COLOR_GREEN)
                    : Colors.white,
                fontSize: SizeConfig.getSafeBlockVerticalBy(
                    Default.SUBSTANDARD_FONT_SIZE),
              ),
            ),
            Text(
              address.getZipAndCity(),
              style: TextStyle(
                color: textColor == false
                    ? Color(Default.COLOR_GREEN)
                    : Colors.white,
                fontSize: SizeConfig.getSafeBlockVerticalBy(
                    Default.SUBSTANDARD_FONT_SIZE),
              ),
            ),
          ],
        ),
      ),
    );
  }

  static Container getInfoIcon() {
    return Container(
      color: Color(Default.COLOR_GREEN),
      width: SizeConfig.screenHeight,
      height: SizeConfig.getSafeBlockHorizontalBy(22.5),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Icon(
            Icons.info_outline,
            color: Colors.white,
          ),
        ],
      ),
    );
  }

  static Container getNoLocation() {
    return Container(
      color: Color(Default.COLOR_GREEN),
      width: SizeConfig.screenHeight,
      height: SizeConfig.getSafeBlockHorizontalBy(22.5),
    );
  }

  static Widget getOpening(String opening, {bool colorWhite}) {
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

  static Padding getEmail(String organizer, String email, String title) {
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

  static Padding getPhoneAndEmail(String phone, String email, String title) {
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
                  child: Padding(
                    padding: EdgeInsets.only(
                      left: SizeConfig.getSafeBlockVerticalBy(5),
                      bottom: SizeConfig.getSafeBlockVerticalBy(1),
                    ),
                    child: Icon(
                      Icons.email,
                      color: Colors.black,
                      size: SizeConfig.getSafeBlockVerticalBy(3),
                      semanticLabel: 'Email',
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

  static Padding getCardSubtitle(String text, {bool textColor}) {
    return Padding(
      padding: EdgeInsets.only(
        left: SizeConfig.getSafeBlockVerticalBy(2),
        right: SizeConfig.getSafeBlockVerticalBy(2),
        top: SizeConfig.getSafeBlockVerticalBy(1),
        bottom: SizeConfig.getSafeBlockVerticalBy(2),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: textColor == true ? Colors.white : Colors.grey,
          fontSize:
              SizeConfig.getSafeBlockVerticalBy(Default.SUBSTANDARD_FONT_SIZE),
        ),
      ),
    );
  }

  static Image getImageByName(String name) {
    Image image;
    if (name.contains('johannis')) {
      image = Image.asset(
        'assets/images/johanniskirche.jpg',
        fit: BoxFit.fill,
      );
    }

    if (name.contains('markus')) {
      image = Image.asset(
        'assets/images/markuskirche.jpg',
        fit: BoxFit.fill,
      );
    }

    return image;
  }

  static Column getCircleAvatar(String imageUrl) {
    return Column(
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

  static Widget noInternet() {
    return Container(
      color: Colors.red,
      child: Padding(
        padding: const EdgeInsets.all(1.0),
        child: ListTile(
          leading: Icon(
            Icons.info,
            color: Colors.white,
          ),
          title: Text(
            "Keine Netzverbinding!",
            style: TextStyle(
              color: Colors.white,
              fontSize:
                  SizeConfig.getSafeBlockVerticalBy(Default.STANDARD_FONT_SIZE),
            ),
          ),
        ),
      ),
    );
  }

  static Padding getFooter(String text) {
    return Padding(
      padding: EdgeInsets.all(SizeConfig.getSafeBlockVerticalBy(1.5)),
      child: Text(
        text,
        style: TextStyle(
          color: Colors.grey,
          fontSize:
              SizeConfig.getSafeBlockVerticalBy(Default.SUBSTANDARD_FONT_SIZE),
        ),
        textAlign: TextAlign.center,
      ),
    );
  }

  static Widget getAccordionTitle(String name) {
    return Text(
        name,
        style: TextStyle(
          fontSize:
              SizeConfig.getSafeBlockVerticalBy(Default.STANDARD_FONT_SIZE),
        ),
    );
  }
}
