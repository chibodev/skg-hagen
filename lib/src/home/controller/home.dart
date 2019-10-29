import 'package:flutter/material.dart';
import 'package:skg_hagen/src/home/view/cards.dart';

class Home extends StatelessWidget {
  static const String route = '/home';

  @override
  Widget build(BuildContext context) {
    final Cards cards = Cards();
    return cards.getCards(context);
  }
}
