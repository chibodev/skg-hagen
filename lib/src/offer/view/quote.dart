import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:skg_hagen/src/common/library/globals.dart';
import 'package:skg_hagen/src/common/model/default.dart';
import 'package:skg_hagen/src/common/model/sizeConfig.dart';
import 'package:skg_hagen/src/common/routes/routes.dart';
import 'package:skg_hagen/src/common/service/analyticsManager.dart';
import 'package:skg_hagen/src/common/view/customWidget.dart';
import 'package:skg_hagen/src/offer/controller/quoteController.dart';
import 'package:skg_hagen/src/offer/model/offers.dart';
import 'package:skg_hagen/src/offer/model/quote.dart' as Model;
import 'package:skg_hagen/src/settings/view/settingsMenu.dart';

class Quote extends State<QuoteController> {
  SettingsMenu settingsMenu;

  @override
  void initState() {
    super.initState();
    settingsMenu = SettingsMenu(pageView: this);
    AnalyticsManager()
        .setScreen(Model.Quote.NAME, Default.classNameFromRoute(Routes.offer));
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      body: Container(
        child: CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              iconTheme: IconThemeData(color: Colors.white),
              pinned: true,
              expandedHeight: SizeConfig.getSafeBlockVerticalBy(20),
              backgroundColor: Color(Default.COLOR_GREEN),
              flexibleSpace: FlexibleSpaceBar(
                titlePadding: const EdgeInsetsDirectional.only(
                    start: 72, bottom: 16, end: 102),
                title: CustomWidget.getTitle(Model.Quote.PAGE_NAME),
                background: Image.asset(
                  Offers.IMAGE,
                  fit: BoxFit.cover,
                ),
              ),
              actions: <Widget>[settingsMenu.getMenu()],
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (BuildContext context, int index) => widget.dataAvailable
                    ? _buildRows(widget?.quotes[index], context)
                    : CustomWidget.buildSliverSpinner(),
                childCount: widget?.quotes?.length ?? 0,
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          !widget.dataAvailable ? CustomWidget.noInternet() : Container(),
        ],
      ),
    );
  }

  Widget _buildRows(Model.Quote quote, BuildContext context) {
    return Material(
      child: Padding(
        padding: EdgeInsets.only(
          bottom: SizeConfig.getSafeBlockHorizontalBy(0),
        ),
        child: Card(
          shape: Border(
            left: BorderSide(
              color: Color(Default.COLOR_GREEN),
              width: SizeConfig.getSafeBlockHorizontalBy(1),
            ),
          ),
          child: Column(
            children: <Widget>[
              Slidable(
                actionPane: SlidableDrawerActionPane(),
                actionExtentRatio: Default.SLIDE_RATIO,
                actions: <Widget>[
                  CustomWidget.getSlidableShare(
                    Model.Quote.PAGE_NAME,
                    Default.getSharableContent(quote.getText()),
                  )
                ],
                child: ListTile(
                  title: Padding(
                    padding: EdgeInsets.only(
                      top: SizeConfig.getSafeBlockVerticalBy(2),
                    ),
                    child: Text(
                      quote.text,
                      style: TextStyle(
                        fontSize: SizeConfig.getSafeBlockVerticalBy(
                            appFont.primarySize),
                      ),
                    ),
                  ),
                  subtitle: (quote.getBook().length > 1)
                      ? Padding(
                          padding: EdgeInsets.only(
                            top: SizeConfig.getSafeBlockVerticalBy(1),
                            bottom: SizeConfig.getSafeBlockVerticalBy(2),
                          ),
                          child: Text(
                            quote.getBook(),
                            style: TextStyle(
                              fontSize: SizeConfig.getSafeBlockVerticalBy(
                                  appFont.primarySize),
                            ),
                          ),
                        )
                      : Text(''),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
