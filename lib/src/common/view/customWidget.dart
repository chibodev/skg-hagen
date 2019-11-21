import 'package:flutter/material.dart';
import 'package:skg_hagen/src/common/model/address.dart';
import 'package:skg_hagen/src/common/model/default.dart';
import 'package:skg_hagen/src/common/model/sizeConfig.dart';
import 'package:skg_hagen/src/common/service/network.dart';
import 'package:skg_hagen/src/common/service/tapAction.dart';

class CustomWidget {
  static Padding buildProgressIndicator(bool _isPerformingRequest) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Center(
        child: AnimatedOpacity(
          duration: Duration.zero,
          opacity: _isPerformingRequest ? 1.0 : 0.0,
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(
              Color(Default.COLOR_GREEN),
            ),
          ),
        ),
      ),
    );
  }

  static Widget buildSliverSpinner(bool _isPerformingRequest) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Center(
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(
            Color(Default.COLOR_GREEN),
          ),
        ),
      ),
    );
  }

  static Text getTitle(String name,
      {bool noShadow, Color color, Color shadowInner, Color shadowOuter}) {
    return Text(
      name,
      style: TextStyle(
        color: (color != null) ? color : Colors.white,
        fontSize: SizeConfig.getSafeBlockVerticalBy(Default.STANDARD_FONT_SIZE),
        shadows: noShadow == null
            ? <Shadow>[
                Shadow(
                  offset: Offset(SizeConfig.getSafeBlockVerticalBy(0.2),
                      SizeConfig.getSafeBlockVerticalBy(0.2)),
                  blurRadius: 3.0,
                  color: shadowInner != null ? shadowInner : Colors.black45,
                ),
                Shadow(
                  offset: Offset(SizeConfig.getSafeBlockVerticalBy(0.2),
                      SizeConfig.getSafeBlockVerticalBy(0.2)),
                  blurRadius: 8.0,
                  color: shadowOuter != null ? shadowOuter : Colors.black45,
                ),
              ]
            : <Shadow>[],
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
        Default.capitalize(occurrence),
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
            address.name != null ? Text(
              Default.capitalize(address.name),
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: SizeConfig.getSafeBlockVerticalBy(
                    Default.SUBSTANDARD_FONT_SIZE),
              ),
            ) : Container(),
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

  static Container getNoLocation() {
    return Container(
      color: Color(Default.COLOR_GREEN),
      width: SizeConfig.screenHeight,
      height: SizeConfig.getSafeBlockHorizontalBy(22.5),
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
            Network.NO_INTERNET,
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
        fontSize: SizeConfig.getSafeBlockVerticalBy(Default.STANDARD_FONT_SIZE),
      ),
    );
  }

  static Padding getSinglePageTitle(double thirty, String title) {
    return Padding(
      padding: EdgeInsets.only(left: thirty, right: thirty, top: thirty),
      child: Text(
        title,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize:
          SizeConfig.getSafeBlockVerticalBy(Default.STANDARD_FONT_SIZE),
        ),
      ),
    );
  }

  static Padding getSinglePageDescription(double thirty, String description) {
    return Padding(
      padding: EdgeInsets.all(thirty),
      child: SelectableText(
        description,
        style: TextStyle(
          fontSize:
          SizeConfig.getSafeBlockVerticalBy(Default.STANDARD_FONT_SIZE),
        ),
      ),
    );
  }

  static Padding getSinglePageOccurrence(double thirty, String occurrence) {
    return Padding(
      padding: EdgeInsets.only(left: thirty),
      child: Text(
        "Termin: $occurrence",
        style: TextStyle(
          color: Colors.grey,
          fontWeight: FontWeight.bold,
          fontSize:
          SizeConfig.getSafeBlockVerticalBy(Default.STANDARD_FONT_SIZE),
        ),
      ),
    );
  }

  static Padding getSinglePageEmail(double thirty, String email, String title) {
    return Padding(
      padding: EdgeInsets.only(left: thirty, bottom: thirty),
      child: InkWell(
        splashColor: Color(Default.COLOR_GREEN),
        onTap: () =>
            TapAction().sendMail(email, title),
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
      ),
    );
  }

  static Padding getImageFromNetwork(double thirty, String imageUrl) {
    return Padding(
      padding: EdgeInsets.all(thirty),
      child: Image.network(
        imageUrl,
        fit: BoxFit.scaleDown,
      ),
    );
  }
}
