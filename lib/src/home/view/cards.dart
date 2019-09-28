import 'package:flutter/material.dart';
import 'package:skg_hagen/src/common/routes/routes.dart';
import 'package:skg_hagen/src/home/model/cardContent.dart';
import 'package:skg_hagen/src/home/model/scripturalVerse.dart';
import 'package:skg_hagen/src/home/model/singleCard.dart';
import 'package:skg_hagen/src/home/repository/monthlyVerseClient.dart';
import 'package:skg_hagen/src/menu/controller/menu.dart';

class Cards {
  final _fontOptima = const TextStyle(fontFamily: 'Optima');
  MonthlyVerseClient monthlyVerseClient = new MonthlyVerseClient();

  Widget getCards(BuildContext context) {
    ScripturalVerse monthlyVerse = monthlyVerseClient.getVerse();
    return Scaffold(
      appBar: AppBar(
        title: Text(
          monthlyVerse.text +
              ' ' +
              monthlyVerse.book +
              ' ' +
              monthlyVerse.chapter.toString() +
              ', ' +
              monthlyVerse.verse.toString(),
          style: TextStyle(fontSize: 12, color: Colors.white),
        ),
        backgroundColor: Color(0xFF8EBC6B),
      ),
      body: _buildCards(context),
      drawer: Menu(),
    );
  }

  Widget _buildCards(BuildContext context) {
    SingleCard card = new SingleCard();
    List<CardContent> cards = card.getAllCards();

    return ListView.builder(
        padding: EdgeInsets.zero,
        itemCount: cards.length,
        itemBuilder: (context, index) {
          return _buildRows(context, cards[index]);
        });
  }

  Widget _buildRows(BuildContext context, CardContent card) {
    final imageAssest = (card.custom != null) ? Image.asset(card.custom) : null;

    return Material(
      child: GestureDetector(
        onTap: () => Navigator.pushReplacementNamed(context, Routes.appointment),
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
                subtitle:
                    Text(card.joinedSubtitle.toUpperCase(), style: _fontOptima),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
