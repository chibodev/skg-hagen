import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:launch_review/launch_review.dart';
import 'package:share/share.dart';
import 'package:skg_hagen/src/common/library/globals.dart';
import 'package:skg_hagen/src/common/model/default.dart';
import 'package:skg_hagen/src/common/model/font.dart';
import 'package:skg_hagen/src/common/model/sizeConfig.dart';
import 'package:skg_hagen/src/common/service/client/assetClient.dart';
import 'package:skg_hagen/src/common/service/client/dioHttpClient.dart';
import 'package:skg_hagen/src/common/service/network.dart';
import 'package:skg_hagen/src/common/service/tapAction.dart';
import 'package:skg_hagen/src/common/view/customWidget.dart';
import 'package:skg_hagen/src/home/controller/home.dart';
import 'package:skg_hagen/src/home/model/aid.dart';
import 'package:skg_hagen/src/home/model/cardContent.dart';
import 'package:skg_hagen/src/home/model/monthlyScripture.dart';
import 'package:skg_hagen/src/home/repository/aidClient.dart';
import 'package:skg_hagen/src/home/repository/monthlyScriptureClient.dart';
import 'package:skg_hagen/src/home/service/singleCard.dart';
import 'package:skg_hagen/src/home/service/versionCheck.dart';
import 'package:skg_hagen/src/menu/controller/menu.dart';
import 'package:skg_hagen/src/offer/controller/aid.dart' as Controller;
import 'package:skg_hagen/src/offer/controller/aidReceive.dart';
import 'package:skg_hagen/src/offer/model/aid.dart' as Model;
import 'package:skg_hagen/src/offer/model/aidOffer.dart';
import 'package:skg_hagen/src/offer/model/aidReceive.dart' as Model;
import 'package:skg_hagen/src/offer/repository/aidOfferClient.dart';
import 'package:skg_hagen/src/pushnotification/service/pushNotificationManager.dart';
import 'package:skg_hagen/src/settings/view/settingsMenu.dart';

class Cards extends State<Home> {
  MonthlyScriptureClient monthlyScriptureClient = MonthlyScriptureClient();
  AidClient aidClient = AidClient();
  Model.Aid _aid;
  bool _hasInternet = true;
  bool _dataAvailable = true;
  BuildContext _context;
  SettingsMenu settingsMenu;

  @override
  void initState() {
    super.initState();
    settingsMenu = SettingsMenu(pageView: this);
    _getAidOffers();
    _checkVersion();
  }

  @override
  Widget build(BuildContext context) {
    this._context = context;
    SizeConfig().init(_context);
    _checkConnectivity();
    PushNotificationsManager().init(context);
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        title: Container(
          width: SizeConfig.getSafeBlockHorizontalBy(100),
          child: FutureBuilder<MonthlyScripture>(
            future: _getDevotionalText(),
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
        actions: <Widget>[settingsMenu.getMenu()],
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
    final double twenty = SizeConfig.getSafeBlockVerticalBy(2);
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        !_hasInternet ? CustomWidget.noInternet() : Container(),
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
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              Expanded(
                                child: Text(
                                  response.data.title,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: SizeConfig.getSafeBlockVerticalBy(
                                        appFont.primarySize),
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
                                  size: SizeConfig.getSafeBlockVerticalBy(
                                      appFont.iconSize),
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
                                                appFont.primarySize),
                                        color: Colors.black,
                                        fontFamily: Font.NAME),
                                  ),
                                ),
                              ),
                              Row(
                                children: <Widget>[
                                  Padding(
                                    padding: EdgeInsets.only(top: twenty),
                                    child: FlatButton(
                                      child: Icon(
                                        Icons.phone,
                                        color: Colors.white,
                                        size: SizeConfig.getSafeBlockVerticalBy(
                                            appFont.iconSize),
                                        semanticLabel: 'Phone',
                                      ),
                                      onPressed: () {
                                        TapAction().callMe(response.data.phone);
                                      },
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(top: twenty),
                                    child: FlatButton(
                                      child: Icon(
                                        Icons.email,
                                        color: Colors.white,
                                        size: SizeConfig.getSafeBlockVerticalBy(
                                            appFont.iconSize),
                                        semanticLabel: 'Email',
                                      ),
                                      onPressed: () {
                                        TapAction().sendMail(
                                            response.data.email,
                                            response.data.title);
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          actions: <Widget>[
                            Divider(),
                            FlatButton.icon(
                              textColor: Colors.black,
                              icon: ImageIcon(
                                AssetImage(AidOffer.VOLUNTEER),
                                color: Colors.black,
                                size: SizeConfig.getSafeBlockVerticalBy(
                                    appFont.iconSize),
                              ),
                              label: Flexible(
                                child: Text(
                                  AidOffer.NAME,
                                  style: TextStyle(
                                      fontSize:
                                          SizeConfig.getSafeBlockVerticalBy(
                                              appFont.primarySize),
                                      fontFamily: Font.NAME),
                                ),
                              ),
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
                            Divider(),
                            FlatButton.icon(
                              textColor: Colors.black,
                              icon: ImageIcon(
                                AssetImage(Model.AidReceive.HELP),
                                color: Colors.black,
                                size: SizeConfig.getSafeBlockVerticalBy(
                                    appFont.iconSize),
                              ),
                              label: Flexible(
                                child: Text(
                                  Model.AidReceive.NAME,
                                  style: TextStyle(
                                      fontSize:
                                          SizeConfig.getSafeBlockVerticalBy(
                                              appFont.primarySize),
                                      fontFamily: Font.NAME),
                                ),
                              ),
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
                        size:
                            SizeConfig.getSafeBlockVerticalBy(appFont.iconSize),
                      ),
                      title: Text(
                        Model.Aid.NAME,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: SizeConfig.getSafeBlockVerticalBy(
                              appFont.primarySize),
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
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Flexible(
                    child: Text(
                      MonthlyScripture.TITLE,
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: SizeConfig.getSafeBlockVerticalBy(
                            appFont.primarySize),
                      ),
                    ),
                  ),
                  FlatButton(
                    onPressed: () => Share.share(
                        response.data.getSharableContent(),
                        subject: MonthlyScripture.TITLE),
                    child: Icon(Icons.share,
                        color: Colors.white,
                        size: SizeConfig.getSafeBlockVerticalBy(
                            appFont.iconSize)),
                  ),
                ],
              ),
              content: SingleChildScrollView(
                child: _getDevotionalAndLesson(
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
                          appFont.primarySize),
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
        fontSize: SizeConfig.getSafeBlockVerticalBy(appFont.primarySize),
        color: Colors.white,
        fontFamily: Font.NAME);

    return Text(
      oldTestamentText,
      style: style,
    );
  }

  Widget _getDevotionalAndLesson(
      String oldTestamentText, String newTestamentText) {
    final TextStyle style = TextStyle(
        fontSize: SizeConfig.getSafeBlockVerticalBy(appFont.primarySize),
        color: Colors.white,
        fontFamily: Font.NAME);

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

  Future<MonthlyScripture> _getDevotionalText() async {
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
    final double verticalSize = SizeConfig.getSafeBlockVerticalBy(2.0);
    final double horizontalSize = SizeConfig.getSafeBlockHorizontalBy(1.7);

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
                    left: verticalSize,
                    top: verticalSize,
                    bottom: horizontalSize),
                alignment: AlignmentDirectional.centerStart,
                child: Text(
                  card.title.toLowerCase(),
                  style: TextStyle(
                      fontFamily: Font.NAME,
                      fontSize: SizeConfig.getSafeBlockVerticalBy(
                          appFont.primarySize)),
                ),
              ),
              Container(
                padding:
                    EdgeInsets.only(left: verticalSize, bottom: verticalSize),
                alignment: AlignmentDirectional.centerStart,
                child: Text(
                  card.joinedSubtitle.toUpperCase(),
                  style: TextStyle(
                    color: Colors.black45,
                    fontFamily: Font.NAME,
                    fontSize:
                        SizeConfig.getSafeBlockVerticalBy(appFont.primarySize),
                  ),
                ),
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

  Future<void> _checkVersion() async {
    if (await VersionCheck().isVersionOld() && !VersionCheck().updateLater) {
      const String APP_STORE_ID = '1491227545';
      const String PLAY_STORE_ID = 'de.skg_hagen';
      const String UPDATE_TITLE = 'Neue Updates sind verfügbar';
      const String UPDATE_MESSAGE =
          'Es ist eine neuere Version der App verfügbar. Bitte aktualisieren Sie sie jetzt!';
      const String UPDATE_NOW = 'Jetzt aktualisieren';
      const String UPDATE_LATER = 'Später';

      showDialog<String>(
        context: _context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return Platform.isIOS
              ? CupertinoAlertDialog(
                  title: Text(UPDATE_TITLE),
                  content: Text(UPDATE_MESSAGE),
                  actions: <Widget>[
                    FlatButton(
                      child: Text(
                        UPDATE_NOW,
                      ),
                      onPressed: () => LaunchReview.launch(
                          writeReview: false, iOSAppId: APP_STORE_ID),
                    ),
                    FlatButton(
                      child: Text(
                        UPDATE_LATER,
                      ),
                      onPressed: () {
                        VersionCheck().updateLater = true;
                        Navigator.pop(context);
                      },
                    ),
                  ],
                )
              : AlertDialog(
                  title: Text(UPDATE_TITLE),
                  content: Text(UPDATE_MESSAGE),
                  actions: <Widget>[
                    FlatButton(
                      child: Text(
                        UPDATE_NOW,
                        style: TextStyle(
                          fontSize: SizeConfig.getSafeBlockVerticalBy(
                              appFont.primarySize),
                        ),
                      ),
                      onPressed: () => LaunchReview.launch(
                          writeReview: false, androidAppId: PLAY_STORE_ID),
                    ),
                    FlatButton(
                      child: Text(
                        UPDATE_LATER,
                        style: TextStyle(
                          fontSize: SizeConfig.getSafeBlockVerticalBy(
                              appFont.primarySize),
                        ),
                      ),
                      onPressed: () {
                        VersionCheck().updateLater = true;
                        Navigator.pop(context);
                      },
                    ),
                  ],
                );
        },
      );
    }
  }

  Future<void> _checkConnectivity() async {
    _hasInternet = await Network().hasInternet();
  }
}
