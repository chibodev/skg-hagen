import 'package:flutter/material.dart';
import 'package:skg_hagen/src/home/model/cardContent.dart';
import 'package:skg_hagen/src/common/routes/routes.dart';
import 'package:skg_hagen/src/home/model/singleCard.dart';

class DrawerList {

  static Widget getList(BuildContext context) {
    String capitalize(String s) => s[0].toUpperCase() + s.substring(1);
    final SingleCard card = SingleCard();
    List<CardContent> cards = card.getAllCards();
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          _createHeader(
              () => Navigator.pushReplacementNamed(context, Routes.home)),
          _createDrawerItem(
              text: 'Home',
              onTap: () =>
                  Navigator.pushReplacementNamed(context, Routes.home)),
          _createDrawerItem(
              text: capitalize(cards[0].title),
              onTap: () =>
                  Navigator.pushReplacementNamed(context, Routes.appointment)),
          _createDrawerItem(
            text: capitalize(cards[1].title),
            onTap: () => Navigator.pushReplacementNamed(context, Routes.offer),
          ),
          _createDrawerItem(
            text: capitalize(cards[2].title),
            onTap: () => Navigator.pushReplacementNamed(context, Routes.kindergarten),
          ),
          _createDrawerItem(text: capitalize(cards[3].title)),
          _createDrawerItem(text: capitalize(cards[4].title)),
          _createDrawerItem(text: capitalize(cards[5].title)),
          _createDrawerItem(text: capitalize(cards[6].title)),
          _createDrawerItem(text: capitalize(cards[7].title)),
        ],
      ),
    );
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
              image: AssetImage('assets/images/skg-green.png'),
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
