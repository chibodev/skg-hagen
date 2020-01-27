import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:skg_hagen/src/common/model/default.dart';
import 'package:skg_hagen/src/common/model/sizeConfig.dart';
import 'package:skg_hagen/src/common/view/customWidget.dart';
import 'package:skg_hagen/src/offer/model/concept.dart' as Model;
import 'package:skg_hagen/src/offer/model/offers.dart';

class Concept extends StatelessWidget {
  final Model.Concept concept;
  final BuildContext context;
  final bool dataAvailable;

  const Concept(
      {Key key,
      this.context,
      @required this.concept,
      this.dataAvailable = true})
      : super(key: key);

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
                title: CustomWidget.getTitle(Model.Concept.PAGE_NAME),
                background: Image.asset(
                  Offers.IMAGE,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Flexible(
                    child: Padding(
                      padding: EdgeInsets.all(thirty),
                      child: SelectableText(
                        concept.description,
                        style: TextStyle(
                          fontSize: SizeConfig.getSafeBlockVerticalBy(
                              Default.STANDARD_FONT_SIZE),
                        ),
                      ),
                    ),
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
          !dataAvailable ? CustomWidget.noInternet() : Container(),
        ],
      ),
    );
  }
}
