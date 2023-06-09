import 'package:flutter/material.dart';
import 'package:skg_hagen/src/common/dto/default.dart';
import 'package:skg_hagen/src/common/dto/sizeConfig.dart';
import 'package:skg_hagen/src/common/routes/routes.dart';
import 'package:skg_hagen/src/common/service/analyticsManager.dart';
import 'package:skg_hagen/src/common/service/client/dioHttpClient.dart';
import 'package:skg_hagen/src/common/service/network.dart';
import 'package:skg_hagen/src/common/view/customWidget.dart';
import 'package:skg_hagen/src/kindergarten/controller/kindergarten.dart'
    as Controller;
import 'package:skg_hagen/src/kindergarten/dto/kindergarten.dart';
import 'package:skg_hagen/src/kindergarten/repository/kindergartenClient.dart';
import 'package:skg_hagen/src/kindergarten/view/cards.dart';
import 'package:skg_hagen/src/settings/view/settingsMenu.dart';

class Accordions extends State<Controller.Kindergarten> {
  Kindergarten? _kindergarten;
  late List<dynamic> _options;
  bool _isPerformingRequest = false;
  bool _hasInternet = true;
  bool _dataAvailable = false;
  late SettingsMenu settingsMenu;

  @override
  void initState() {
    super.initState();
    settingsMenu = SettingsMenu(pageView: this);
    AnalyticsManager().setScreen(
        Kindergarten.NAME, Default.classNameFromRoute(Routes.kindergarten));
    _getInfos();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () async {
          _getInfos();
        },
        child: _buildCards(context),
      ),
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          CustomWidget.getFooter(Kindergarten.FOOTER),
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
          expandedHeight: SizeConfig.getSafeBlockVerticalBy(20),
          backgroundColor: Colors.white,
          flexibleSpace: FlexibleSpaceBar(
            titlePadding: const EdgeInsetsDirectional.only(
                start: 72, bottom: 16, end: 102),
            title: CustomWidget.getTitle(Kindergarten.NAME),
            background: Image.asset(
              Kindergarten.IMAGE,
              fit: BoxFit.cover,
            ),
          ),
          actions: <Widget>[settingsMenu.getMenu()],
        ),
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (BuildContext context, int index) => !_dataAvailable
                ? CustomWidget.buildSliverSpinner()
                : Cards().buildRows(context, _options[index]),
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

  Future<void> _getInfos() async {
    if (!_isPerformingRequest) {
      setState(() => _isPerformingRequest = true);

      _hasInternet = await Network().hasInternet();
      _kindergarten = await KindergartenClient()
          .getAppointments(DioHTTPClient(), Network());

      _options = <dynamic>[];

      if (_kindergarten != null) {
        _options.add(_kindergarten?.events);
        _options.add(_kindergarten?.news);
        _dataAvailable = true;
      }
      setState(() {
        _isPerformingRequest = false;
      });
    }
  }
}
