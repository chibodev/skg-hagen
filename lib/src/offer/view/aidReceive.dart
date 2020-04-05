import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:skg_hagen/src/common/library/globals.dart';
import 'package:skg_hagen/src/common/dto/default.dart';
import 'package:skg_hagen/src/common/dto/sizeConfig.dart';
import 'package:skg_hagen/src/common/routes/routes.dart';
import 'package:skg_hagen/src/common/service/analyticsManager.dart';
import 'package:skg_hagen/src/common/view/customWidget.dart';
import 'package:skg_hagen/src/offer/controller/aidReceive.dart' as Controller;
import 'package:skg_hagen/src/offer/dto/aidReceive.dart' as DTO;
import 'package:skg_hagen/src/offer/dto/offers.dart';
import 'package:skg_hagen/src/settings/view/settingsMenu.dart';

class AidReceive extends State<Controller.AidReceive> {
  SettingsMenu settingsMenu;

  @override
  void initState() {
    super.initState();
    settingsMenu = SettingsMenu(pageView: this);
    AnalyticsManager().setScreen(
        DTO.AidReceive.NAME, Default.classNameFromRoute(Routes.offer));
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    final double thirty = SizeConfig.getSafeBlockVerticalBy(3.5);
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
                title: CustomWidget.getTitle(DTO.AidReceive.NAME),
                background: Image.asset(
                  Offers.IMAGE,
                  fit: BoxFit.cover,
                ),
              ),
              actions: <Widget>[settingsMenu.getMenu()],
            ),
            SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Flexible(
                    child: widget?.aidReceive != null
                        ? Padding(
                            padding: EdgeInsets.all(thirty),
                            child: SelectableText(
                              widget?.aidReceive?.description,
                              style: TextStyle(
                                fontSize: SizeConfig.getSafeBlockVerticalBy(
                                    appFont.primarySize),
                              ),
                            ),
                          )
                        : CustomWidget.centeredNoEntry(),
                  ),
                  Row(
                    children: <Widget>[
                      widget?.aidReceive?.email != null
                          ? CustomWidget.getSinglePageEmail(
                              thirty,
                              widget?.aidReceive?.email,
                              widget?.aidReceive?.title,
                              widget?.buildContext)
                          : Container(),
                      widget?.aidReceive?.phone != null
                          ? CustomWidget.getSinglePagePhone(thirty,
                              widget?.aidReceive?.phone, widget?.buildContext)
                          : Container()
                    ],
                  ),
                ],
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
}
