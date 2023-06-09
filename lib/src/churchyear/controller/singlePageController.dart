import 'package:flutter/material.dart';
import 'package:skg_hagen/src/churchyear/model/churchYear.dart';
import 'package:skg_hagen/src/churchyear/view/page.dart';

class SinglePageController extends StatefulWidget {
  final dynamic content;
  final String title;
  final String image;
  final bool dataAvailable;
  final BuildContext context;

  const SinglePageController(
      {Key? key,
      required this.context,
      required this.content,
      this.dataAvailable = true,
      this.title = '',
      this.image = ChurchYear.IMAGE})
      : super(key: key);

  @override
  ChurchYearPage createState() => ChurchYearPage();
}
