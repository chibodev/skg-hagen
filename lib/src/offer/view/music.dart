import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:skg_hagen/src/common/model/default.dart';
import 'package:skg_hagen/src/common/model/sizeConfig.dart';
import 'package:skg_hagen/src/common/view/customWidget.dart';
import 'package:skg_hagen/src/offer/model/music.dart' as Model;
import 'package:skg_hagen/src/offer/model/offers.dart';

class Music extends StatelessWidget {
  final Model.Music music;
  final BuildContext context;

  const Music({Key key, this.context, @required this.music}) : super(key: key);

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
                title: CustomWidget.getTitle(this.music.getName()),
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
                  CustomWidget.getSinglePageTitle(thirty, music.title),
                  music.imageUrl != null
                      ? CustomWidget.getImageFromNetwork(thirty, music.imageUrl)
                      : Container(),
                  CustomWidget.getSinglePageDescription(
                      thirty, music.description),
                  music.occurrence.length > 2
                      ? CustomWidget.getSinglePageOccurrence(thirty,
                          Default.capitalize(music.getFormattedOccurrence()))
                      : Container(),
                  music.email.length > 2
                      ? CustomWidget.getSinglePageEmail(
                          thirty, music.email, music.title)
                      : Container(),
                  Padding(
                    padding: EdgeInsets.only(bottom: SizeConfig.getSafeBlockVerticalBy(1)),
                    child: CustomWidget.getAddressWithAction(music.address),
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
