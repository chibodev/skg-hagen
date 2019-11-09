import 'package:flutter/material.dart';
import 'package:skg_hagen/src/common/model/default.dart';
import 'package:skg_hagen/src/common/model/sizeConfig.dart';
import 'package:skg_hagen/src/common/service/dioHttpClient.dart';
import 'package:skg_hagen/src/common/service/network.dart';
import 'package:skg_hagen/src/common/view/customWidget.dart';
import 'package:skg_hagen/src/kindergarten/controller/kindergarten.dart'
    as Controller;
import 'package:skg_hagen/src/kindergarten/model/kindergarten.dart';
import 'package:skg_hagen/src/kindergarten/repository/kindergartenClient.dart';
import 'package:skg_hagen/src/kindergarten/view/cards.dart';
import 'package:skg_hagen/src/menu/controller/menu.dart';

class Accordions extends State<Controller.Kindergarten> {
  Kindergarten _kindergarten;
  List<dynamic> _options;
  final ScrollController _scrollController = ScrollController();
  bool _isPerformingRequest = false;
  bool _hasInternet = false;

  @override
  void initState() {
    super.initState();
    _getInfos();
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
          _getInfos();
        },
        child: _buildCards(context),
      ),
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(
                bottom: SizeConfig.getSafeBlockVerticalBy(1.5),
                top: SizeConfig.getSafeBlockVerticalBy(1.5)),
            child: Text(
              Kindergarten.FOOTER,
              style: TextStyle(
                color: Colors.grey,
                fontSize: SizeConfig.getSafeBlockVerticalBy(
                    Default.SUBSTANDARD_FONT_SIZE),
              ),
              textAlign: TextAlign.center,
            ),
          ),
          !_hasInternet ? CustomWidget.noInternet() : Container()
        ],
      ),
    );
  }

  Widget _buildCards(BuildContext context) {
    return CustomScrollView(
      controller: _scrollController,
      slivers: <Widget>[
        SliverAppBar(
          pinned: true,
          expandedHeight: SizeConfig.getSafeBlockVerticalBy(20),
          backgroundColor: Color(Default.COLOR_GREEN),
          flexibleSpace: FlexibleSpaceBar(
            title: CustomWidget.getTitle(Kindergarten.NAME),
            background: Image.asset(
              Kindergarten.IMAGE,
              fit: BoxFit.cover,
            ),
          ),
        ),
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (BuildContext context, int index) {
              if (_kindergarten.news.isEmpty) {
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
              return Cards().buildRows(context, _options[index]);
            },
            childCount: _options?.length ?? 0,
          ),
        ),
      ],
    );
  }

  Future<void> _getInfos() async {
    if (!_isPerformingRequest) {
      setState(() => _isPerformingRequest = true);

      _hasInternet = await Network().hasInternet();
      _kindergarten = await KindergartenClient()
          .getAppointments(DioHTTPClient(), Network());
      _options = List<dynamic>();
      _options.add(_kindergarten.events);
      _options.add(_kindergarten.news);

      setState(() {
        _isPerformingRequest = false;
      });
    }
  }
}
