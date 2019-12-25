import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:skg_hagen/src/common/model/default.dart';
import 'package:skg_hagen/src/common/model/sizeConfig.dart';
import 'package:skg_hagen/src/common/view/customWidget.dart';
import 'package:skg_hagen/src/offer/model/offers.dart';
import 'package:skg_hagen/src/offer/model/project.dart';

class Projects extends StatelessWidget {
  final Project projects;
  final BuildContext context;

  const Projects({Key key, this.context, @required this.projects})
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
                title: CustomWidget.getTitle(this.projects.getName()),
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
                  CustomWidget.getSinglePageTitle(thirty, projects.title),
                  CustomWidget.getSinglePageDescription(
                      thirty, projects.description),
                  projects.imageUrl != null
                      ? CustomWidget.getImageFromNetwork(
                          thirty, projects.imageUrl)
                      : Container(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
