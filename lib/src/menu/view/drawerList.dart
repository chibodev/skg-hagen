import 'package:flutter/material.dart';
import 'package:skg_hagen/src/common/model/default.dart';
import 'package:skg_hagen/src/common/model/sizeConfig.dart';
import 'package:skg_hagen/src/common/routes/routes.dart';
import 'package:skg_hagen/src/common/service/assetClient.dart';
import 'package:skg_hagen/src/home/model/cardContent.dart';
import 'package:skg_hagen/src/home/service/singleCard.dart';

class DrawerList {
  static const String LOGO = 'assets/images/skg-green.png';
  static const String HOME_NAME = 'Home';

  static Widget getList(BuildContext context) {
    final SingleCard card = SingleCard();
    final Future<List<CardContent>> cards = card.getAllCards(AssetClient());
    SizeConfig().init(context);

    return Drawer(
      child: FutureBuilder<List<CardContent>>(
        future: cards,
        builder:
            (BuildContext context, AsyncSnapshot<List<CardContent>> response) {
          if (response.connectionState == ConnectionState.done &&
              response.data != null) {
            return _buildListView(context, response.data);
          }
          return CircularProgressIndicator(
            valueColor:
                AlwaysStoppedAnimation<Color>(Color(Default.COLOR_GREEN)),
          );
        },
      ),
    );
  }

  static Widget _buildListView(BuildContext context, List<CardContent> cards) {
    return ListView(
        padding: EdgeInsets.zero, children: _cardList(context, cards));
  }

  static List<Widget> _cardList(BuildContext context, List<CardContent> cards) {
    final List<Widget> list = List<Widget>();

    list.add(_createHeader(
        () => Navigator.pushReplacementNamed(context, Routes.home)));

    list.add(_createDrawerItem(
        text: HOME_NAME,
        onTap: () => Navigator.pushReplacementNamed(context, Routes.home)));

    for (int i = 0; i < cards.length; i++) {
      list.add(_createDrawerItem(
          text: Default.capitalize(cards[i].title),
          onTap: () =>
              Navigator.pushReplacementNamed(context, cards[i].routeName)));
    }
    return list;
  }

  static Widget _createHeader(GestureTapCallback onTap) {
    return DrawerHeader(
      margin: EdgeInsets.all(SizeConfig.getSafeBlockVerticalBy(3)),
      padding: EdgeInsets.zero,
      child: OverflowBox(
        minWidth: 0.0,
        minHeight: 0.0,
        maxWidth: SizeConfig.getSafeBlockVerticalBy(18),
        child: GestureDetector(
          onTap: onTap,
          child: Image(image: AssetImage(LOGO), fit: BoxFit.cover),
        ),
      ),
    );
  }

  static Widget _createDrawerItem({String text, GestureTapCallback onTap}) {
    return ListTile(
      title: Row(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(SizeConfig.getSafeBlockVerticalBy(2.5)),
            child: Text(text, style: TextStyle(fontFamily: 'Optima', fontSize: SizeConfig.getSafeBlockHorizontalBy(3))),
          ),
        ],
      ),
      onTap: onTap,
    );
  }
}
