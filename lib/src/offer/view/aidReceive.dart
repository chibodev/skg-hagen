import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:skg_hagen/src/common/model/default.dart';
import 'package:skg_hagen/src/common/model/sizeConfig.dart';
import 'package:skg_hagen/src/common/view/customWidget.dart';
import 'package:skg_hagen/src/offer/model/aidReceive.dart' as Model;
import 'package:skg_hagen/src/offer/model/offers.dart';

class AidReceive extends StatelessWidget {
  final Model.AidReceive aidReceive;
  final BuildContext buildContext;
  final bool dataAvailable;

  const AidReceive(
      {Key key,
      this.buildContext,
      @required this.aidReceive,
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
                title: CustomWidget.getTitle(aidReceive.title),
                background: Image.asset(
                  Offers.IMAGE,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Flexible(
                    child: aidReceive != null
                        ? Padding(
                            padding: EdgeInsets.all(thirty),
                            child: SelectableText(
                              aidReceive.description,
                              style: TextStyle(
                                fontSize: SizeConfig.getSafeBlockVerticalBy(
                                    Default.STANDARD_FONT_SIZE),
                              ),
                            ),
                          )
                        : CustomWidget.centeredNoEntry(),
                  ),
                  Row(
                    children: <Widget>[
                      aidReceive.email != null
                          ? CustomWidget.getSinglePageEmail(thirty,
                          aidReceive.email, aidReceive.title, this.buildContext)
                          : Container(),
                      aidReceive.phone != null
                          ? CustomWidget.getSinglePagePhone(thirty,
                          aidReceive.phone, this.buildContext)
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
          !dataAvailable ? CustomWidget.noInternet() : Container(),
        ],
      ),
    );
  }
}
