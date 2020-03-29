import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:skg_hagen/src/common/model/default.dart';
import 'package:skg_hagen/src/common/model/sizeConfig.dart';
import 'package:skg_hagen/src/common/view/customWidget.dart';
import 'package:skg_hagen/src/offer/controller/musicController.dart';
import 'package:skg_hagen/src/offer/model/music.dart' as Model;
import 'package:skg_hagen/src/offer/model/offers.dart';
import 'package:skg_hagen/src/settings/view/settingsMenu.dart';

class Music extends State<MusicController> {
  SettingsMenu settingsMenu;

  @override
  void initState() {
    super.initState();
    settingsMenu = SettingsMenu(pageView: this);
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
                title: CustomWidget.getTitle(Model.Music.NAME),
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
                  CustomWidget.getSinglePageTitle(thirty, widget?.music?.title),
                  widget?.music?.imageUrl != null
                      ? CustomWidget.getImageFromNetwork(
                          thirty, widget?.music?.imageUrl)
                      : Container(),
                  CustomWidget.getSinglePageDescription(
                      thirty, widget?.music?.description),
                  widget.music.occurrence.length > 2
                      ? CustomWidget.getSinglePageOccurrence(
                          thirty,
                          Default.capitalize(
                              widget?.music?.getFormattedOccurrence()))
                      : Container(),
                  widget.music.email.length > 2
                      ? CustomWidget.getSinglePageEmail(thirty,
                          widget?.music?.email, widget?.music?.title, context)
                      : Container(),
                  Padding(
                    padding: EdgeInsets.only(
                        bottom: SizeConfig.getSafeBlockVerticalBy(1)),
                    child: CustomWidget.getAddressWithAction(
                        widget?.music?.address,
                        room: widget?.music?.room),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
