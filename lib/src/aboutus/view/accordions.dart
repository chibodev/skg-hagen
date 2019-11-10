import 'package:flutter/material.dart';
import 'package:skg_hagen/src/aboutus/controller/aboutus.dart' as Controller;
import 'package:skg_hagen/src/aboutus/model/aboutus.dart';
import 'package:skg_hagen/src/aboutus/repository/aboutusClient.dart';
import 'package:skg_hagen/src/aboutus/view/cards.dart';
import 'package:skg_hagen/src/common/model/default.dart';
import 'package:skg_hagen/src/common/service/dioHttpClient.dart';
import 'package:skg_hagen/src/common/model/sizeConfig.dart';
import 'package:skg_hagen/src/common/service/network.dart';
import 'package:skg_hagen/src/common/view/customWidget.dart';
import 'package:skg_hagen/src/menu/controller/menu.dart';

class Accordions extends State<Controller.AboutUs> {
  AboutUs _aboutUs;
  List<dynamic> _options;
  final ScrollController _scrollController = ScrollController();
  bool _isPerformingRequest = false;
  bool _hasInternet = true;

  @override
  void initState() {
    super.initState();
    _getAboutUs();
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
      controller: _scrollController,
      slivers: <Widget>[
        SliverAppBar(
          pinned: true,
          iconTheme: IconThemeData(color: Colors.white),
          expandedHeight: SizeConfig.getSafeBlockVerticalBy(20),
          backgroundColor: Color(Default.COLOR_GREEN),
          flexibleSpace: FlexibleSpaceBar(
            title: CustomWidget.getTitle(AboutUs.NAME),
            background: Image.asset(
              AboutUs.IMAGE,
              fit: BoxFit.cover,
            ),
          ),
        ),
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (BuildContext context, int index) {
              if (_aboutUs.history.isEmpty) {
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

  Future<void> _getAboutUs() async {
    if (!_isPerformingRequest) {
      setState(() => _isPerformingRequest = true);

      _hasInternet = await Network().hasInternet();
      _aboutUs = await AboutUsClient().getData(DioHTTPClient(), Network());

      _options = List<dynamic>();
      if(_aboutUs != null) {
        _options.add(_aboutUs.history);
        _options.add(_aboutUs.presbytery);
        _options.add(_aboutUs.imprint);
      }

      setState(() {
        _isPerformingRequest = false;
      });
    }
  }
}
