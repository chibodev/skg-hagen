import 'package:flutter/material.dart';
import 'package:skg_hagen/src/aboutus/controller/aboutus.dart' as Controller;
import 'package:skg_hagen/src/aboutus/dto/aboutus.dart';
import 'package:skg_hagen/src/aboutus/repository/aboutusClient.dart';
import 'package:skg_hagen/src/aboutus/view/cards.dart';
import 'package:skg_hagen/src/common/dto/default.dart';
import 'package:skg_hagen/src/common/dto/sizeConfig.dart';
import 'package:skg_hagen/src/common/routes/routes.dart';
import 'package:skg_hagen/src/common/service/analyticsManager.dart';
import 'package:skg_hagen/src/common/service/client/dioHttpClient.dart';
import 'package:skg_hagen/src/common/service/network.dart';
import 'package:skg_hagen/src/common/view/customWidget.dart';
import 'package:skg_hagen/src/settings/view/settingsMenu.dart';

class Accordions extends State<Controller.AboutUs> {
  AboutUs _aboutUs;
  List<dynamic> _options;
  bool _isPerformingRequest = false;
  bool _hasInternet = true;
  bool _dataAvailable = false;
  SettingsMenu settingsMenu;

  @override
  void initState() {
    super.initState();
    settingsMenu = SettingsMenu(pageView: this);
    AnalyticsManager()
        .setScreen(AboutUs.NAME, Default.classNameFromRoute(Routes.aboutUs));
    _getAboutUs();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () async {
          _getAboutUs();
        },
        child: _buildCards(context),
      ),
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          !_hasInternet ? CustomWidget.noInternet() : Container()
        ],
      ),
    );
  }

  Widget _buildCards(BuildContext context) {
    return CustomScrollView(
      slivers: <Widget>[
        SliverAppBar(
          pinned: true,
          iconTheme: IconThemeData(color: Colors.white),
          expandedHeight: SizeConfig.getSafeBlockVerticalBy(20),
          backgroundColor: Color(Default.COLOR_GREEN),
          flexibleSpace: FlexibleSpaceBar(
            titlePadding: const EdgeInsetsDirectional.only(
                start: 72, bottom: 16, end: 102),
            title: CustomWidget.getTitle(AboutUs.NAME),
            background: Image.asset(
              AboutUs.IMAGE,
              fit: BoxFit.scaleDown,
            ),
          ),
          actions: <Widget>[settingsMenu.getMenu()],
        ),
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (BuildContext context, int index) => !_dataAvailable
                ? CustomWidget.buildSliverSpinner()
                : Cards().buildRows(_options[index], context: context),
            childCount: _options?.length ?? 0,
          ),
        ),
        !_dataAvailable
            ? SliverToBoxAdapter(
                child: CustomWidget.buildSliverSpinner(),
              )
            : SliverToBoxAdapter(),
      ],
    );
  }

  Future<void> _getAboutUs() async {
    if (!_isPerformingRequest) {
      setState(() => _isPerformingRequest = true);

      _hasInternet = await Network().hasInternet();
      _aboutUs = await AboutUsClient().getData(DioHTTPClient(), Network());

      _options = List<dynamic>();
      if (_aboutUs != null) {
        _options.add(_aboutUs.history);
        _options.add(_aboutUs.presbytery);
        _dataAvailable = true;
      }

      setState(() {
        _isPerformingRequest = false;
      });
    }
  }
}
