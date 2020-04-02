import 'package:flutter/material.dart';
import 'package:skg_hagen/src/kindergarten/model/news.dart' as Model;
import 'package:skg_hagen/src/kindergarten/view/newsView.dart';

class News extends StatefulWidget {
  final Model.News news;
  final BuildContext context;

  const News({Key key, this.context, @required this.news}) : super(key: key);

  @override
  NewsView createState() => NewsView();
}
