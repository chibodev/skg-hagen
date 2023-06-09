import 'package:flutter/material.dart';
import 'package:skg_hagen/src/kindergarten/dto/news.dart' as DTO;
import 'package:skg_hagen/src/kindergarten/view/newsView.dart';

class News extends StatefulWidget {
  final DTO.News news;
  final BuildContext context;

  const News({Key? key, required this.context, required this.news}) : super(key: key);

  @override
  NewsView createState() => NewsView();
}
