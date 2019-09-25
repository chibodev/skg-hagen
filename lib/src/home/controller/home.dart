import 'package:flutter/material.dart';
import 'package:skg_hagen/src/common/model/customCard.dart';
import 'package:skg_hagen/src/home/model/singleCard.dart';


class Home extends StatefulWidget {
  @override
  Cards createState() => Cards();
}

class Cards extends State<Home> {
  final _fontOptima = const TextStyle(fontFamily: 'Optima');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //TODO: Text to be got per API call
        title: Text('SUCHE DEN FRIEDEN UND JAGE IHM NACH Ps 34, 15', style: TextStyle(fontSize: 12, color: Colors.white),),
        backgroundColor: Color(0xFF8EBC6B),
      ),
      body: _buildCards(),
    );
  }

  Widget _buildCards() {
    SingleCard card = new SingleCard();
    List<CustomCard> cards = card.getAllCards();

    return ListView.builder(
        padding: EdgeInsets.zero,
        itemCount: cards.length,
        itemBuilder: (context, index) {
          return _buildRows(cards[index]);
        });
  }

  Widget _buildRows(CustomCard card) {
    final imageAssest = (card.custom != null) ? Image.asset(card.custom) : null;
    return Material(
      child: Card(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Container(
              padding: EdgeInsets.zero,
              child: imageAssest,
            ),
            ListTile(
              title: Text(
                card.title.toLowerCase(),
                style: _fontOptima,
              ),
              subtitle: Text(card.subtitle.toUpperCase(), style: _fontOptima),
            ),
          ],
        ),
      ),
    );
  }
}
