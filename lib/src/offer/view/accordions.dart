import 'package:flutter/material.dart';
import 'package:skg_hagen/src/common/model/default.dart';
import 'package:skg_hagen/src/common/model/dioHttpClient.dart';
import 'package:skg_hagen/src/common/model/sizeConfig.dart';
import 'package:skg_hagen/src/common/service/network.dart';
import 'package:skg_hagen/src/common/view/customWidget.dart';
import 'package:skg_hagen/src/menu/controller/menu.dart';
import 'package:skg_hagen/src/offer/controller/offer.dart' as Controller;
import 'package:skg_hagen/src/offer/model/offers.dart';
import 'package:skg_hagen/src/offer/repository/offerClient.dart';
import 'package:skg_hagen/src/offer/view/cards.dart';

class Accordions extends State<Controller.Offer> {
  Offers _offers;
  List<dynamic> _options;
  final ScrollController _scrollController = ScrollController();
  bool _isPerformingRequest = false;

  @override
  void initState() {
    super.initState();
    _getOffers();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      drawer: Menu(),
      body: RefreshIndicator(
        onRefresh: () async {
          _getOffers();
        },
        child: _buildCards(context),
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.only(
            bottom: SizeConfig.getSafeBlockVerticalBy(1.5),
            top: SizeConfig.getSafeBlockVerticalBy(1.5)),
        child: Text(
          Offers.FOOTER,
          style: TextStyle(
            color: Colors.grey,
            fontSize: SizeConfig.getSafeBlockVerticalBy(1.4),
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  Widget _buildCards(BuildContext context) {
    return CustomScrollView(
      controller: _scrollController,
      slivers: <Widget>[
        SliverAppBar(
          pinned: true,
          iconTheme: IconThemeData(color: Colors.white),
          expandedHeight: SizeConfig.getSafeBlockVerticalBy(20),
          backgroundColor: Color(Default.COLOR_GREEN),
          flexibleSpace: FlexibleSpaceBar(
            title: CustomWidget.getTitle(Offers.NAME),
            background: Image.asset(
              Offers.IMAGE,
              fit: BoxFit.cover,
            ),
          ),
        ),
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (BuildContext context, int index) {
              if (_offers.offers.isEmpty) {
                return SizedBox(
                  height: MediaQuery.of(context).size.height * 2,
                  child: Align(
                    alignment: Alignment.topCenter,
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(
                        Color(Default.COLOR_GREEN),
                      ),
                    ),
                  ),
                );
              }
              return Cards().buildRows(_options[index]);
            },
            childCount: _options?.length ?? 0,
          ),
        ),
      ],
    );
  }

  Future<void> _getOffers() async {
    if (!_isPerformingRequest) {
      setState(() => _isPerformingRequest = true);

      _offers = await OfferClient().getOffers(DioHTTPClient(), Network());
      _options = List<dynamic>();
      _options.add(_offers.offers);
      _options.add(_offers.groups);

      setState(() {
        _isPerformingRequest = false;
      });
    }
  }
}
