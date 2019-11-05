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
        fontSize: SizeConfig.getSafeBlockVerticalBy(2.5),
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

  static Padding getCardTitle(String title) {
    return Padding(
      padding: EdgeInsets.only(
        left: SizeConfig.getSafeBlockVerticalBy(2),
        top: SizeConfig.getSafeBlockVerticalBy(2),
      ),
      child: Text(
        title,
        style: TextStyle(
          fontSize: SizeConfig.getSafeBlockVerticalBy(2),
        ),
      ),
    );
  }

  static Padding getOccurrence(String occurrence) {
    return Padding(
      padding: EdgeInsets.only(
        left: SizeConfig.getSafeBlockVerticalBy(2),
        top: SizeConfig.getSafeBlockVerticalBy(1),
      ),
      child: Text(
        occurrence,
        style: TextStyle(
          color: Colors.grey,
          fontWeight: FontWeight.bold,
          fontSize: SizeConfig.getSafeBlockVerticalBy(2),
        ),
      ),
    );
  }

  static Container getAddressWithAction(Address address) {
    return Container(
      color: Color(Default.COLOR_GREEN),
      width: SizeConfig.getSafeBlockVerticalBy(17),
      height: SizeConfig.getSafeBlockHorizontalBy(22.5),
      child: InkWell(
        splashColor: Color(Default.COLOR_GREEN),
        onTap: () => TapAction().openMap(address.name),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              Default.capitalize(address.name),
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: SizeConfig.getSafeBlockVerticalBy(1.7),
              ),
            ),
            Text(
              address.getStreetAndNumber(),
              style: TextStyle(
                color: Colors.white,
                fontSize: SizeConfig.getSafeBlockVerticalBy(1.7),
              ),
            ),
            Text(
              address.getZipAndCity(),
              style: TextStyle(
                color: Colors.white,
                fontSize: SizeConfig.getSafeBlockVerticalBy(1.7),
              ),
            ),
          ],
        ),
      ),
    );
  }

  static Container getAddressWithoutAction(Address address) {
    return Container(
      color: Color(Default.COLOR_GREEN),
      width: SizeConfig.getSafeBlockVerticalBy(17),
      height: SizeConfig.getSafeBlockHorizontalBy(22.5),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            Default.capitalize(address.name),
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: SizeConfig.getSafeBlockVerticalBy(1.7),
            ),
          ),
          Text(
            address.getStreetAndNumber(),
            style: TextStyle(
              color: Colors.white,
              fontSize: SizeConfig.getSafeBlockVerticalBy(1.7),
            ),
          ),
          Text(
            address.getZipAndCity(),
            style: TextStyle(
              color: Colors.white,
              fontSize: SizeConfig.getSafeBlockVerticalBy(1.7),
            ),
          ),
        ],
      ),
    );
  }

  static Container getInfoIcon() {
    return Container(
      color: Color(Default.COLOR_GREEN),
      width: SizeConfig.getSafeBlockVerticalBy(17),
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
      width: SizeConfig.getSafeBlockVerticalBy(17),
      height: SizeConfig.getSafeBlockHorizontalBy(22.5),
    );
  }

  static Padding getEmail(String organizer, String email, String title) {
    return Padding(
      padding: EdgeInsets.only(
        left: SizeConfig.getSafeBlockVerticalBy(2),
        top: SizeConfig.getSafeBlockVerticalBy(1),
      ),
      child: Row(
        children: <Widget>[
          Text(
            organizer,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(color: Colors.grey),
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
                size: SizeConfig.getSafeBlockVerticalBy(3),
                semanticLabel: 'Email',
              ),
            ),
          )
        ],
      ),
    );
  }

  static Padding getCardSubtitle(String text) {
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
          color: Colors.grey,
          fontSize: SizeConfig.getSafeBlockVerticalBy(1.7),
        ),
      ),
    );
  }
}
