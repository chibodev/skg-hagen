import 'package:flutter/material.dart';
import 'package:skg_hagen/src/churchyear/controller/churchyearController.dart'
    as Controller;
import 'package:skg_hagen/src/churchyear/dto/easterOffer.dart';
import 'package:skg_hagen/src/churchyear/model/churchYear.dart';
import 'package:skg_hagen/src/churchyear/repository/easterOfferClient.dart';
import 'package:skg_hagen/src/churchyear/view/cards.dart';
import 'package:skg_hagen/src/common/dto/default.dart';
import 'package:skg_hagen/src/common/dto/sizeConfig.dart';
import 'package:skg_hagen/src/common/routes/routes.dart';
import 'package:skg_hagen/src/common/service/analyticsManager.dart';
import 'package:skg_hagen/src/common/service/client/dioHttpClient.dart';
import 'package:skg_hagen/src/common/service/network.dart';
import 'package:skg_hagen/src/common/view/customWidget.dart';
import 'package:skg_hagen/src/settings/view/settingsMenu.dart';

class Accordions extends State<Controller.ChurchYearController> {
  EasterOffer? _easterOffer;
  late List<dynamic> _options;
  bool _isPerformingRequest = false;
  bool _hasInternet = true;
  bool _dataAvailable = false;
  late SettingsMenu settingsMenu;

  @override
  void initState() {
    super.initState();
    settingsMenu = SettingsMenu(pageView: this);
    AnalyticsManager()
        .setScreen(ChurchYear.NAME, Default.classNameFromRoute(Routes.offer));
    _getOffers();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () async {
          _getOffers();
        },
        child: _buildCards(context),
      ),
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          !_hasInternet ? CustomWidget.noInternet() : Container(),
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
            title: CustomWidget.getTitle(ChurchYear.NAME),
            background: Image.asset(
              ChurchYear.IMAGE,
              fit: BoxFit.cover,
            ),
          ),
          actions: <Widget>[settingsMenu.getMenu()],
        ),
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (BuildContext context, int index) => _dataAvailable
                ? Cards().buildRows(context, _options[index], _dataAvailable)
                : CustomWidget.buildSliverSpinner(),
            childCount: _options.length,
          ),
        ),
        _isPerformingRequest
            ? SliverToBoxAdapter(
                child: CustomWidget.buildSliverSpinner(),
              )
            : !_dataAvailable
                ? SliverToBoxAdapter(
                    child: CustomWidget.centeredNoEntry(),
                  )
                : SliverToBoxAdapter(),
      ],
    );
  }

  Future<void> _getOffers() async {
    if (!_isPerformingRequest) {
      setState(() => _isPerformingRequest = true);

      _hasInternet = await Network().hasInternet();
      _easterOffer =
          await EasterOfferClient().getOffers(DioHTTPClient(), Network());

      _options = <dynamic>[];

      _setOptions();

      setState(() {
        _isPerformingRequest = false;
      });
    }
  }

  void _setOptions() {
    //TODO: use somewhat of a tag service to avoid always extending
    if (_easterOffer != null) {
      _options.add(_easterOffer!.resurrectionStation);
      _dataAvailable = true;
    }
  }
}
