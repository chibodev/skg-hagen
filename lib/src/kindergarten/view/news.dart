import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:skg_hagen/src/common/model/default.dart';
import 'package:skg_hagen/src/common/model/sizeConfig.dart';
import 'package:skg_hagen/src/common/view/customWidget.dart';
import 'package:skg_hagen/src/kindergarten/model/kindergarten.dart';
import 'package:skg_hagen/src/kindergarten/model/news.dart' as Model;

class News extends StatelessWidget {
  final Model.News news;
  final BuildContext context;

  const News({Key key, this.context, @required this.news}) : super(key: key);
  //TODO: enable zoom and copy text
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    final double thirty = SizeConfig.getSafeBlockVerticalBy(3.5);
    return Scaffold(
      body: Container(
        child: CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              pinned: true,
              expandedHeight: SizeConfig.getSafeBlockVerticalBy(20),
              backgroundColor: Color(Default.COLOR_GREEN),
              flexibleSpace: FlexibleSpaceBar(
                title: CustomWidget.getTitle(this.news.getName()),
                background: Image.asset(
                  Kindergarten.IMAGE,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(left: thirty, right: thirty, top: thirty),
                    child: Text(
                      news.title,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(thirty),
                    child: Text(news.description),
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
