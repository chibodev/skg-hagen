import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:open_file/open_file.dart';
import 'package:skg_hagen/src/common/model/default.dart';
import 'package:skg_hagen/src/common/model/sizeConfig.dart';
import 'package:skg_hagen/src/common/service/client/fileDownload.dart';
import 'package:skg_hagen/src/common/view/customWidget.dart';
import 'package:skg_hagen/src/kindergarten/controller/news.dart';
import 'package:skg_hagen/src/kindergarten/model/kindergarten.dart';
import 'package:skg_hagen/src/kindergarten/model/news.dart' as Model;

class NewsView extends State<News> {
  static bool downloading = false;
  FileDownload fileDownload = FileDownload();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    final double thirty = SizeConfig.getSafeBlockVerticalBy(3.5);
    return Scaffold(
        body: Builder(
      builder: (BuildContext contextOfBuilder) => Container(
        child: CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              pinned: true,
              expandedHeight: SizeConfig.getSafeBlockVerticalBy(20),
              backgroundColor: Color(Default.COLOR_GREEN),
              flexibleSpace: FlexibleSpaceBar(
                title: CustomWidget.getTitle(Model.News.NAME),
                background: Image.asset(
                  Kindergarten.IMAGE,
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
                  CustomWidget.getSinglePageTitle(thirty, widget.news.title),
                  CustomWidget.getSinglePageDescription(
                      thirty, widget.news.description),
                  widget.news.imageUrl != null
                      ? CustomWidget.getImageFromNetwork(
                          thirty, widget.news.imageUrl)
                      : Container(),
                  widget.news.fileUrl != null
                      ? _downloadFile(contextOfBuilder)
                      : Container(),
                ],
              ),
            ),
          ],
        ),
      ),
    ));
  }

  Widget _downloadFile(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.zero,
          child: InkWell(
            splashColor: Color(Default.COLOR_GREEN),
            onTap: () => _download(widget.news.fileUrl, widget.news.filename),
            child: Padding(
              padding: EdgeInsets.only(
                left: SizeConfig.getSafeBlockVerticalBy(1),
              ),
              child: Image.asset(
                widget.news.format == 'pdf'
                    ? 'assets/images/icon/pdf.png'
                    : 'assets/images/icon/file.png',
                fit: BoxFit.scaleDown,
                width: SizeConfig.getSafeBlockVerticalBy(15),
                height: SizeConfig.getSafeBlockHorizontalBy(15),
              ),
            ),
          ),
        ),
        downloading
            ? CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(
                  Color(Default.COLOR_GREEN),
                ),
              )
            : SizedBox(),
        SizedBox(height: 10),
      ],
    );
  }

  Future<void> _download(String fileUrl, String filename) async {
    if (await fileDownload.hasPermission()) {
      setState(() {
        downloading = true;
      });

      final String saveDir = await fileDownload.getSaveDirectory();
      final String filePath = "$saveDir/$filename";
      if (await fileDownload.downloadFile(fileUrl, filePath)) {
        OpenFile.open(filePath);
      }
    }

    setState(() {
      downloading = false;
    });
  }
}
