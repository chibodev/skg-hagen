import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:skg_hagen/src/common/library/globals.dart';
import 'package:skg_hagen/src/common/model/default.dart';
import 'package:skg_hagen/src/common/model/sizeConfig.dart';
import 'package:skg_hagen/src/common/view/customWidget.dart';
import 'package:skg_hagen/src/offer/controller/conceptController.dart';
import 'package:skg_hagen/src/offer/model/concept.dart' as Model;
import 'package:skg_hagen/src/offer/model/offers.dart';
import 'package:skg_hagen/src/settings/view/settingsMenu.dart';

class Concept extends State<ConceptController> {
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
                title: CustomWidget.getTitle(Model.Concept.PAGE_NAME),
                background: Image.asset(
                  Offers.IMAGE,
                  fit: BoxFit.cover,
                ),
              ),
              actions: <Widget>[settingsMenu.getMenu()],
            ),
            SliverToBoxAdapter(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Flexible(
                    child: widget.concept.isNotEmpty
                        ? Padding(
                            padding: EdgeInsets.all(thirty),
                            child: SelectableText(
                              widget?.concept?.first?.description,
                              style: TextStyle(
                                fontSize: SizeConfig.getSafeBlockVerticalBy(
                                    appFont.primarySize),
                              ),
                            ),
                          )
                        : CustomWidget.centeredNoEntry(),
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
