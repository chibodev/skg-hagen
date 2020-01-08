import 'package:flutter/material.dart';
import 'package:skg_hagen/src/common/model/default.dart';
import 'package:skg_hagen/src/common/model/sizeConfig.dart';
import 'package:skg_hagen/src/common/service/client/assetClient.dart';
import 'package:skg_hagen/src/common/service/client/dioHttpClient.dart';
import 'package:skg_hagen/src/common/service/network.dart';
import 'package:skg_hagen/src/home/model/cardContent.dart';
import 'package:skg_hagen/src/home/model/monthlyScripture.dart';
import 'package:skg_hagen/src/home/repository/monthlyScriptureClient.dart';
import 'package:skg_hagen/src/home/service/singleCard.dart';
import 'package:skg_hagen/src/menu/controller/menu.dart';

class Cards {
  MonthlyScriptureClient monthlyScriptureClient = MonthlyScriptureClient();
  BuildContext _context;

  Widget getCards(BuildContext context) {
    this._context = context;
    SizeConfig().init(_context);
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        title: Container(
          width: SizeConfig.getSafeBlockHorizontalBy(100),
          child: FutureBuilder<MonthlyScripture>(
            future: _getText(),
            builder: (BuildContext context,
                AsyncSnapshot<MonthlyScripture> response) {
              if (response.connectionState == ConnectionState.done &&
                  response.data != null) {
                return InkWell(
                  onTap: () {
                    return showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          backgroundColor: Color(Default.COLOR_GREEN),
                          title: Text(
                            MonthlyScripture.TITLE,
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: SizeConfig.getSafeBlockVerticalBy(
                                  Default.STANDARD_FONT_SIZE),
                            ),
                          ),
                          content: SingleChildScrollView(
                              child: _getDevionalAndLesson(
                            response.data.oldTestamentText,
                            response.data.newTestamentText,
                          )),
                          actions: <Widget>[
                            FlatButton(
                              child: Text(
                                "Schließen",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: SizeConfig.getSafeBlockVerticalBy(
                                      Default.SUBSTANDARD_FONT_SIZE),
                                ),
                              ),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                          ],
                        );
                      },
                    );
                  },
                  child: Center(
                    child: _getDevotional(response.data.getModifiedText()),
                  ),
                );
              }
              return Text('');
            },
          ),
        ),
        backgroundColor: Color(Default.COLOR_GREEN),
      ),
      body: Container(
        height: SizeConfig.getSafeBlockVerticalBy(100),
        width: SizeConfig.getSafeBlockHorizontalBy(100),
        child: FutureBuilder<List<CardContent>>(
          future: _getAllCards(),
          builder: (BuildContext context,
              AsyncSnapshot<List<CardContent>> response) {
            if (response.connectionState == ConnectionState.done &&
                response.data != null) {
              return _buildCards(response.data);
            }
            return CircularProgressIndicator(
              valueColor:
                  AlwaysStoppedAnimation<Color>(Color(Default.COLOR_GREEN)),
            );
          },
        ),
      ),
      drawer: Menu(),
    );
  }

  Widget _getDevotional(String oldTestamentText) {
    TextStyle style = TextStyle(
        fontSize: SizeConfig.getSafeBlockVerticalBy(2.3),
        color: Colors.white,
        fontFamily: Default.FONT);

    return Text(
      oldTestamentText,
      style: style,
    );
  }

  Widget _getDevionalAndLesson(
      String oldTestamentText, String newTestamentText) {
    TextStyle style = TextStyle(
        fontSize: SizeConfig.getSafeBlockVerticalBy(2.3),
        color: Colors.white,
        fontFamily: Default.FONT);

    return RichText(
      text: TextSpan(
        text: oldTestamentText,
        style: style,
        children: <TextSpan>[
          newTestamentText != null ? TextSpan(text: '\n\n') : TextSpan(),
          newTestamentText != null
              ? TextSpan(
                  text: newTestamentText,
                  style: style,
                )
              : TextSpan(),
        ],
      ),
    );
  }

  Future<MonthlyScripture> _getText() async {
    return await MonthlyScriptureClient().getDevotion(DioHTTPClient(), Network());
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
    final double thirtyPercent =
        SizeConfig.getSafeBlockVerticalBy(Default.STANDARD_FONT_SIZE);
    final double tenPercent =
        SizeConfig.getSafeBlockHorizontalBy(Default.SUBSTANDARD_FONT_SIZE);

    return Material(
      child: InkWell(
        onTap: () => Navigator.of(this._context).pushNamed(card.routeName),
        child: Card(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Container(
                padding: EdgeInsets.zero,
                height: SizeConfig.getSafeBlockVerticalBy(12.5),
                width: SizeConfig.getSafeBlockHorizontalBy(100),
                child: card.getImageAsset(),
              ),
              Container(
                padding: EdgeInsets.only(
                    left: thirtyPercent,
                    top: thirtyPercent,
                    bottom: tenPercent),
                alignment: AlignmentDirectional.centerStart,
                child: Text(
                  card.title.toLowerCase(),
                  style: TextStyle(
                      fontFamily: Default.FONT, fontSize: thirtyPercent),
                ),
              ),
              Container(
                padding:
                    EdgeInsets.only(left: thirtyPercent, bottom: thirtyPercent),
                alignment: AlignmentDirectional.centerStart,
                child: Text(card.joinedSubtitle.toUpperCase(),
                    style: TextStyle(
                        color: Colors.black45,
                        fontFamily: Default.FONT,
                        fontSize: thirtyPercent)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
