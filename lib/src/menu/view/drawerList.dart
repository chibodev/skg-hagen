import 'package:flutter/material.dart';
import 'package:skg_hagen/src/common/dto/default.dart';
import 'package:skg_hagen/src/common/dto/font.dart';
import 'package:skg_hagen/src/common/dto/sizeConfig.dart';
import 'package:skg_hagen/src/common/library/globals.dart';
import 'package:skg_hagen/src/common/routes/routes.dart';
import 'package:skg_hagen/src/common/service/analyticsManager.dart';
import 'package:skg_hagen/src/common/service/client/assetClient.dart';
import 'package:skg_hagen/src/common/service/featureFlag.dart';
import 'package:skg_hagen/src/home/dto/cardContent.dart';
import 'package:skg_hagen/src/home/service/singleCard.dart';
import 'package:skg_hagen/src/legal/dto/imprint.dart';
import 'package:skg_hagen/src/pushnotification/dto/pushNotifications.dart';

class DrawerList {
  static const String LOGO = 'assets/images/skg-transparent.png';
  static const String HOME_NAME = 'Home';
  static late bool featureEnabled;

  static Widget getList(BuildContext context, bool isEnabled) {
    final SingleCard card = SingleCard();
    featureEnabled = isEnabled;
    final Future<List<CardContent>> cards = card.getAllCards(AssetClient());
    SizeConfig().init(context);
    AnalyticsManager().setScreen('Drawer', Default.capitalize('menu'));

    return Drawer(
        child: Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: <Color>[Color(Default.COLOR_GREEN), Colors.white])),
      child: FutureBuilder<List<CardContent>>(
        future: cards,
        builder:
            (BuildContext context, AsyncSnapshot<List<CardContent>> response) {
          final List<CardContent>? data = response.data;
          if (response.connectionState == ConnectionState.done &&
              data != null) {
            return _buildListView(context, data);
          }
          return CircularProgressIndicator(
            valueColor:
                AlwaysStoppedAnimation<Color>(Color(Default.COLOR_GREEN)),
          );
        },
      ),
    ));
  }

  static Widget _buildListView(BuildContext context, List<CardContent> cards) {
    return ListView(
        padding: EdgeInsets.zero, children: _cardList(context, cards));
  }

  static List<Widget> _cardList(BuildContext context, List<CardContent> cards) {
    final List<Widget> list = <Widget>[];

    list.add(
      _createHeader(
        () => Navigator.of(context).popAndPushNamed(Routes.home),
      ),
    );

    list.add(
      _createDrawerItem(
        text: HOME_NAME,
        onTap: () => Navigator.of(context).popAndPushNamed(Routes.home),
      ),
    );

    for (int i = 0; i < cards.length; i++) {
      if (cards[i].title == FeatureFlag.KIRCHENJAHR && !featureEnabled) {
        continue;
      }

      list.add(
        _createDrawerItem(
          text: Default.capitalize(cards[i].name),
          onTap: () =>
              Navigator.of(context).popAndPushNamed(cards[i].routeName),
        ),
      );
    }

    list.add(Divider());

    list.add(
      _createOtherDrawerItem(
        text: PushNotifications.NAME,
        onTap: () =>
            Navigator.of(context).popAndPushNamed(Routes.pushNotification),
      ),
    );

    list.add(Divider());

    list.add(
      _createOtherDrawerItem(
        text: Imprint.NAME,
        onTap: () => Navigator.of(context).popAndPushNamed(Routes.imprint),
      ),
    );

    return list;
  }

  static Widget _createHeader(GestureTapCallback onTap) {
    return DrawerHeader(
      margin: EdgeInsets.all(SizeConfig.getSafeBlockVerticalBy(1)),
      padding: EdgeInsets.zero,
      child: OverflowBox(
        minWidth: 0.0,
        minHeight: 0.0,
        maxWidth: SizeConfig.getSafeBlockVerticalBy(23),
        child: GestureDetector(
          onTap: onTap,
          child: Image(image: AssetImage(LOGO), fit: BoxFit.scaleDown),
        ),
      ),
    );
  }

  static Widget _createDrawerItem(
      {required String text, required GestureTapCallback onTap}) {
    return ListTile(
      title: Row(
        children: <Widget>[
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(
                left: SizeConfig.getSafeBlockVerticalBy(1.5),
                bottom: SizeConfig.getSafeBlockVerticalBy(0.5),
              ),
              child: Text(
                text,
                style: TextStyle(
                  fontFamily: Font.NAME,
                  fontSize:
                      SizeConfig.getSafeBlockVerticalBy(appFont.primarySize),
                ),
              ),
            ),
          ),
        ],
      ),
      onTap: onTap,
    );
  }

  static Widget _createOtherDrawerItem(
      {required String text, required GestureTapCallback onTap}) {
    return ListTile(
      title: Row(
        children: <Widget>[
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(
                left: SizeConfig.getSafeBlockVerticalBy(1.5),
              ),
              child: Text(
                text,
                style: TextStyle(
                  fontFamily: Font.NAME,
                  fontSize:
                      SizeConfig.getSafeBlockVerticalBy(appFont.secondarySize),
                ),
              ),
            ),
          ),
        ],
      ),
      onTap: onTap,
    );
  }
}
