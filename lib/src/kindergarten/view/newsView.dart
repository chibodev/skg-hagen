import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:open_file/open_file.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:skg_hagen/src/common/library/globals.dart';
import 'package:skg_hagen/src/common/dto/default.dart';
import 'package:skg_hagen/src/common/dto/sizeConfig.dart';
import 'package:skg_hagen/src/common/routes/routes.dart';
import 'package:skg_hagen/src/common/service/analyticsManager.dart';
import 'package:skg_hagen/src/common/service/client/dioHttpClient.dart';
import 'package:skg_hagen/src/common/view/customWidget.dart';
import 'package:skg_hagen/src/kindergarten/controller/news.dart';
import 'package:skg_hagen/src/kindergarten/dto/kindergarten.dart';
import 'package:skg_hagen/src/kindergarten/dto/news.dart' as DTO;
import 'package:skg_hagen/src/kindergarten/service/fileDownload.dart';
import 'package:skg_hagen/src/settings/view/settingsMenu.dart';

class NewsView extends State<News> {
  static bool downloading = false;
  FileDownload fileDownload = FileDownload();
  SettingsMenu settingsMenu;

  @override
  void initState() {
    super.initState();
    settingsMenu = SettingsMenu(pageView: this);
    AnalyticsManager().setScreen(
        DTO.News.NAME, Default.classNameFromRoute(Routes.kindergarten));
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
              backgroundColor: Colors.white,
              flexibleSpace: FlexibleSpaceBar(
                titlePadding: const EdgeInsetsDirectional.only(
                    start: 72, bottom: 16, end: 102),
                title: CustomWidget.getTitle(DTO.News.NAME),
                background: Image.asset(
                  Kindergarten.IMAGE,
                  fit: BoxFit.cover,
                ),
              ),
              actions: <Widget>[settingsMenu.getMenu()],
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
                width: SizeConfig.getSafeBlockVerticalBy(appFont.boxSize),
                height: SizeConfig.getSafeBlockHorizontalBy(appFont.boxSize),
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
    final PermissionHandler permissionHandler = PermissionHandler();
    final DioHTTPClient client = DioHTTPClient();

    if (await fileDownload.hasPermission(permissionHandler)) {
      setState(() {
        downloading = true;
      });

      final String saveDir = await fileDownload.getSaveDirectory();
      final String filePath = "$saveDir/$filename";
      if (await client.downloadFile(
          http: client, urlPath: fileUrl, savePath: filePath)) {
        OpenFile.open(filePath);
      }
    }

    setState(() {
      downloading = false;
    });
  }
}
