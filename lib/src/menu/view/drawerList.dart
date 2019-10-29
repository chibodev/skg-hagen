import 'package:flutter/material.dart';
import 'package:skg_hagen/src/home/model/cardContent.dart';
import 'package:skg_hagen/src/common/routes/routes.dart';
import 'package:skg_hagen/src/home/service/singleCard.dart';

class DrawerList {

  static const String LOGO = 'assets/images/skg-green.png';

  static Widget getList(BuildContext context) {
    final SingleCard card = SingleCard();
    final Future<List<CardContent>> cards = card.getAllCards();

    return Drawer(
        child: FutureBuilder(
      future: cards,
      builder:
          (BuildContext context, AsyncSnapshot<List<CardContent>> response) {
        if (response.connectionState == ConnectionState.done &&
            response.data != null) {
          return _buildListView(context, response.data);
        }
        return CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF8EBC6B)),
        );
      },
    ));
  }

  static Widget _buildListView(BuildContext context, List<CardContent> cards) {
    return ListView(
        padding: EdgeInsets.zero, children: _cardList(context, cards));
  }

  static List<Widget> _cardList(BuildContext context, List<CardContent> cards) {
    String capitalize(String s) => s[0].toUpperCase() + s.substring(1);
    final List<Widget> list = List<Widget>();

    list.add(_createHeader(
        () => Navigator.pushReplacementNamed(context, Routes.home)));

    list.add(_createDrawerItem(
        text: 'Home',
        onTap: () => Navigator.pushReplacementNamed(context, Routes.home)));

    for (int i = 0; i < cards.length; i++) {
      list.add(_createDrawerItem(
          text: capitalize(cards[i].title),
          onTap: () =>
              Navigator.pushReplacementNamed(context, cards[i].routeName)));
    }
    return list;
  }

  static Widget _createHeader(GestureTapCallback onTap) {
    return DrawerHeader(
      margin: EdgeInsets.zero,
      padding: EdgeInsets.zero,
      child: OverflowBox(
        minWidth: 0.0,
        minHeight: 0.0,
        maxWidth: 180,
        child: GestureDetector(
          onTap: onTap,
          child: Image(
              image: AssetImage(LOGO),
              fit: BoxFit.cover),
        ),
      ),
    );
  }

  static Widget _createDrawerItem({String text, GestureTapCallback onTap}) {
    return ListTile(
      title: Row(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(left: 8.0),
            child: Text(text, style: TextStyle(fontFamily: 'Optima')),
          ),
        ],
      ),
      onTap: onTap,
    );
  }
}
