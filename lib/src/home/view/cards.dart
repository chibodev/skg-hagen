import 'package:flutter/material.dart';
import 'package:skg_hagen/src/common/model/default.dart';
import 'package:skg_hagen/src/common/model/dioHttpClient.dart';
import 'package:skg_hagen/src/common/service/assetClient.dart';
import 'package:skg_hagen/src/common/service/network.dart';
import 'package:skg_hagen/src/home/model/cardContent.dart';
import 'package:skg_hagen/src/home/model/monthlyScripture.dart';
import 'package:skg_hagen/src/home/service/singleCard.dart';
import 'package:skg_hagen/src/home/repository/monthlyScriptureClient.dart';
import 'package:skg_hagen/src/menu/controller/menu.dart';

class Cards {
  final TextStyle _fontOptima = const TextStyle(fontFamily: 'Optima');
  MonthlyScriptureClient monthlyScriptureClient = MonthlyScriptureClient();
  BuildContext _context;

  Widget getCards(BuildContext context) {
    this._context = context;

    return Scaffold(
      appBar: AppBar(
        title: FutureBuilder(
          future: _getText(),
          builder:
              (BuildContext context, AsyncSnapshot<MonthlyScripture> response) {
            if (response.connectionState == ConnectionState.none) {
              print('monthlyverse snapshot data is: ${response.data}');
              return Text('');
            }
            if (response.connectionState == ConnectionState.done && response.data != null) {
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
        backgroundColor: Color(Default.COLOR_GREEN),
      ),
      body: FutureBuilder(
        future: _getAllCards(),
        builder:
            (BuildContext context, AsyncSnapshot<List<CardContent>> response) {
          if (response.connectionState == ConnectionState.done && response.data != null) {
            return _buildCards(response.data);
          }
          return CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Color(Default.COLOR_GREEN)),
          );
        },
      ),
      drawer: Menu(),
    );
  }

  Future<MonthlyScripture> _getText() async {
    return await MonthlyScriptureClient().getVerse(DioHTTPClient(), Network());
  }

  Future<List<CardContent>> _getAllCards() async {
    return await SingleCard().getAllCards(AssetClient());
  }

  Widget _buildCards(List<CardContent> cards) {
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
