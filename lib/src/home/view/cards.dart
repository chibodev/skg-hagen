import 'package:flutter/material.dart';
import 'package:share/share.dart';
import 'package:skg_hagen/src/common/model/default.dart';
import 'package:skg_hagen/src/common/model/sizeConfig.dart';
import 'package:skg_hagen/src/common/service/client/assetClient.dart';
import 'package:skg_hagen/src/common/service/client/dioHttpClient.dart';
import 'package:skg_hagen/src/common/service/network.dart';
import 'package:skg_hagen/src/common/service/tapAction.dart';
import 'package:skg_hagen/src/home/controller/home.dart';
import 'package:skg_hagen/src/home/model/aid.dart';
import 'package:skg_hagen/src/home/model/cardContent.dart';
import 'package:skg_hagen/src/home/model/monthlyScripture.dart';
import 'package:skg_hagen/src/home/repository/aidClient.dart';
import 'package:skg_hagen/src/home/repository/monthlyScriptureClient.dart';
import 'package:skg_hagen/src/home/service/singleCard.dart';
import 'package:skg_hagen/src/menu/controller/menu.dart';
import 'package:skg_hagen/src/offer/controller/aid.dart' as Controller;
import 'package:skg_hagen/src/offer/controller/aidReceive.dart';
import 'package:skg_hagen/src/offer/model/aid.dart' as Model;
import 'package:skg_hagen/src/offer/repository/aidOfferClient.dart';

class Cards extends State<Home> {
  MonthlyScriptureClient monthlyScriptureClient = MonthlyScriptureClient();
  AidClient aidClient = AidClient();
  Model.Aid _aid;
  bool _dataAvailable = true;
  BuildContext _context;

  @override
  void initState() {
    super.initState();
    _getAidOffers();
  }

  @override
  Widget build(BuildContext context) {
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
                return _devotionalTab(context, response);
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
      bottomNavigationBar: _bottomTab(),
    );
  }

  Column _bottomTab() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Container(
          color: Color(Default.COLOR_GREEN),
          child: FutureBuilder<Aid>(
            future: _getAidText(),
            builder: (BuildContext context, AsyncSnapshot<Aid> response) {
              if (response.connectionState == ConnectionState.done &&
                  response.data != null) {
                return InkWell(
                  onTap: () {
                    return showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          backgroundColor: Color(Default.COLOR_GREEN),
                          title: Row(
                            children: <Widget>[
                              Expanded(
                                child: Text(
                                  response.data.title,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: SizeConfig.getSafeBlockVerticalBy(
                                        Default.STANDARD_FONT_SIZE),
                                  ),
                                ),
                              ),
                              FlatButton(
                                onPressed: () => Share.share(
                                    response.data.description,
                                    subject: response.data.title),
                                child: Icon(
                                  Icons.share,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                          content: Column(
                            children: <Widget>[
                              Expanded(
                                child: SingleChildScrollView(
                                  child: SelectableText(
                                    response.data.description,
                                    style: TextStyle(
                                        fontSize:
                                            SizeConfig.getSafeBlockVerticalBy(
                                                2.3),
                                        color: Colors.white,
                                        fontFamily: Default.FONT),
                                  ),
                                ),
                              ),
                              Row(
                                children: <Widget>[
                                  FlatButton(
                                    child: Icon(
                                      Icons.phone,
                                      color: Colors.white,
                                      size:
                                          SizeConfig.getSafeBlockVerticalBy(4),
                                      semanticLabel: 'Phone',
                                    ),
                                    onPressed: () {
                                      TapAction().callMe(response.data.phone);
                                    },
                                  ),
                                  FlatButton(
                                    child: Icon(
                                      Icons.email,
                                      color: Colors.white,
                                      size:
                                          SizeConfig.getSafeBlockVerticalBy(4),
                                      semanticLabel: 'Email',
                                    ),
                                    onPressed: () {
                                      TapAction().sendMail(response.data.email,
                                          response.data.title, _context);
                                    },
                                  ),
                                ],
                              )
                            ],
                          ),
                          actions: <Widget>[
                            FlatButton.icon(
                              textColor: Colors.black,
                              icon: ImageIcon(
                                AssetImage('assets/images/icon/volunteer.png'),
                                color: Colors.black,
                              ),
                              label: Text('Helfer'),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute<dynamic>(
                                    builder: (BuildContext _context) =>
                                        Controller.Aid(
                                      aidOffer: _aid?.offer,
                                      context: _context,
                                      dataAvailable: _dataAvailable,
                                      aidOfferQuestion: _aid?.offerQuestion,
                                    ),
                                  ),
                                );
                              },
                            ),
                            FlatButton.icon(
                              textColor: Colors.black,
                              icon: ImageIcon(
                                AssetImage('assets/images/icon/help.png'),
                                color: Colors.black,
                              ),
                              label: Text('Hilfe-Suchende'),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute<dynamic>(
                                    builder: (BuildContext _context) =>
                                        AidReceive(
                                      aidReceive: _aid?.receive,
                                      dataAvailable: _dataAvailable,
                                      buildContext: _context,
                                    ),
                                  ),
                                );
                              },
                            ),
                          ],
                        );
                      },
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(1.0),
                    child: ListTile(
                      leading: Icon(
                        Icons.info,
                        color: Colors.white,
                      ),
                      title: Text(
                        response.data.title,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: SizeConfig.getSafeBlockVerticalBy(
                              Default.STANDARD_FONT_SIZE),
                        ),
                      ),
                    ),
                  ),
                );
              }
              return Text('');
            },
          ),
        ),
      ],
    );
  }

  InkWell _devotionalTab(
      BuildContext context, AsyncSnapshot<MonthlyScripture> response) {
    return InkWell(
      onTap: () {
        return showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              backgroundColor: Color(Default.COLOR_GREEN),
              title: Row(
                children: <Widget>[
                  Text(
                    MonthlyScripture.TITLE,
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: SizeConfig.getSafeBlockVerticalBy(
                          Default.STANDARD_FONT_SIZE),
                    ),
                  ),
                  Spacer(),
                  FlatButton(
                    onPressed: () => Share.share(
                        response.data.getSharableContent(),
                        subject: MonthlyScripture.TITLE),
                    child: Icon(
                      Icons.share,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              content: SingleChildScrollView(
                child: _getDevionalAndLesson(
                  response.data.oldTestamentText,
                  response.data.newTestamentText,
                ),
              ),
              actions: <Widget>[
                FlatButton(
                  child: Text(
                    'Schließen',
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

  Widget _getDevotional(String oldTestamentText) {
    final TextStyle style = TextStyle(
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
    final TextStyle style = TextStyle(
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
    return await MonthlyScriptureClient()
        .getDevotion(DioHTTPClient(), Network());
  }

  Future<Aid> _getAidText() async {
    return await AidClient().getAid(DioHTTPClient(), Network());
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

  Future<void> _getAidOffers() async {
    _dataAvailable = await Network().hasInternet();
    _aid = await AidOfferClient().getAidOffer(DioHTTPClient(), Network());
  }
}
