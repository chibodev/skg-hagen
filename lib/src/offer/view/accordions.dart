import 'package:flutter/material.dart';
import 'package:skg_hagen/src/common/dto/default.dart';
import 'package:skg_hagen/src/common/dto/sizeConfig.dart';
import 'package:skg_hagen/src/common/routes/routes.dart';
import 'package:skg_hagen/src/common/service/analyticsManager.dart';
import 'package:skg_hagen/src/common/service/client/dioHttpClient.dart';
import 'package:skg_hagen/src/common/service/network.dart';
import 'package:skg_hagen/src/common/view/customWidget.dart';
import 'package:skg_hagen/src/offer/controller/offer.dart' as Controller;
import 'package:skg_hagen/src/offer/dto/aid.dart';
import 'package:skg_hagen/src/offer/dto/confirmation.dart';
import 'package:skg_hagen/src/offer/dto/offers.dart';
import 'package:skg_hagen/src/offer/repository/aidOfferClient.dart';
import 'package:skg_hagen/src/offer/repository/confirmationClient.dart';
import 'package:skg_hagen/src/offer/repository/offerClient.dart';
import 'package:skg_hagen/src/offer/view/cards.dart';
import 'package:skg_hagen/src/settings/view/settingsMenu.dart';

class Accordions extends State<Controller.Offer> {
  Offers _offers;
  Confirmation _confirmation;
  Aid _aid;
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
        .setScreen(Offers.NAME, Default.classNameFromRoute(Routes.offer));
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
          CustomWidget.getFooter(Offers.FOOTER),
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
            title: CustomWidget.getTitle(Offers.NAME),
            background: Image.asset(
              Offers.IMAGE,
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

  Future<void> _getOffers() async {
    if (!_isPerformingRequest) {
      setState(() => _isPerformingRequest = true);

      _hasInternet = await Network().hasInternet();
      _offers = await OfferClient().getOffers(DioHTTPClient(), Network());
      _confirmation = await ConfirmationClient()
          .getConfirmation(DioHTTPClient(), Network());
      _aid = await AidOfferClient().getAidOffer(DioHTTPClient(), Network());

      _options = List<dynamic>();

      _setOptions();

      setState(() {
        _isPerformingRequest = false;
      });
    }
  }

  void _setOptions() {
    //TODO: use somewhat of a tag service to avoid always extending
    if (_offers != null) {
      _options.add(_offers.offers);
      _options.add(_offers.music);
      _options.add(_offers.projects);
      _dataAvailable = true;
    }

    if (_aid != null) {
      _options.add(_aid);
      _dataAvailable = true;
    }

    if (_confirmation != null) {
      _options.add(_confirmation);
      _dataAvailable = true;
    }
  }
}
