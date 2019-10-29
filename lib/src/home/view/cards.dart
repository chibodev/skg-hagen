import 'package:flutter/material.dart';
import 'package:skg_hagen/src/home/model/cardContent.dart';
import 'package:skg_hagen/src/home/model/monthlyScripture.dart';
import 'package:skg_hagen/src/home/model/singleCard.dart';
import 'package:skg_hagen/src/home/repository/monthlyVerseClient.dart';
import 'package:skg_hagen/src/menu/controller/menu.dart';

class Cards {
  final TextStyle _fontOptima = const TextStyle(fontFamily: 'Optima');
  MonthlyVerseClient monthlyVerseClient = MonthlyVerseClient();
  BuildContext _context;

  Widget getCards(BuildContext context) {
    this._context = context;

    return Scaffold(
      appBar: AppBar(
        title: FutureBuilder(
          future: _getText(),
          builder:
              (BuildContext context, AsyncSnapshot<MonthlyScripture> response) {
            if (response.connectionState == ConnectionState.none &&
                response.hasData == null) {
              print('monthlyverse snapshot data is: ${response.data}');
              return Text('');
            }
            if (response.data != null) {
              return Center(
                  child: RichText(
                      text: TextSpan(
                          text: response.data.text,
                          style: TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                              fontFamily: 'Optima'),
                          children: <TextSpan>[
                    TextSpan(
                        text: response.data.getFormatted(),
                        style: TextStyle(
                            fontSize: 10,
                            color: Colors.white,
                            fontFamily: 'Optima'))
                  ])));
            }
            return Text('');
          },
        ),
        backgroundColor: Color(0xFF8EBC6B),
      ),
      body: _buildCards(),
      drawer: Menu(),
    );
  }

  Future<MonthlyScripture> _getText() async {
    return await MonthlyVerseClient().getVerse();
  }

  Widget _buildCards() {
    final SingleCard card = SingleCard();
    final List<CardContent> cards = card.getAllCards();

    return ListView.builder(
        padding: EdgeInsets.zero,
        itemCount: cards.length,
        itemBuilder: (dynamic context, int index) {
          return _buildRows(cards[index]);
        });
  }

  Widget _buildRows(CardContent card) {
    final Image imageAsset =
        (card.custom != null) ? Image.asset(card.custom) : null;

    return Material(
      child: GestureDetector(
        onTap: () =>
            Navigator.pushReplacementNamed(this._context, card.routeName),
        child: Card(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Container(
                padding: EdgeInsets.zero,
                child: imageAsset,
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
