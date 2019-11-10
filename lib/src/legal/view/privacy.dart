import 'package:flutter/material.dart';
import 'package:skg_hagen/src/common/model/default.dart';
import 'package:skg_hagen/src/common/model/sizeConfig.dart';
import 'package:skg_hagen/src/common/service/assetClient.dart';
import 'package:skg_hagen/src/common/view/customWidget.dart';
import 'package:skg_hagen/src/legal/controller/privacy.dart' as Controller;
import 'package:skg_hagen/src/legal/model/privacy.dart';
import 'package:skg_hagen/src/legal/repository/legalClient.dart';
import 'package:skg_hagen/src/legal/view/page.dart';

class PrivacyView extends State<Controller.Privacy> {
  Privacy _privacy;
  final ScrollController _scrollController = ScrollController();
  bool _isPerformingRequest = false;

  @override
  void initState() {
    super.initState();
    _getPrivacy();
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
          _getPrivacy();
        },
        child: _buildContent(context),
      ),
    );
  }

  Widget _buildContent(BuildContext context) {
    return CustomScrollView(
      controller: _scrollController,
      slivers: <Widget>[
        SliverAppBar(
          pinned: true,
          iconTheme: IconThemeData(color: Colors.white),
          expandedHeight: SizeConfig.getSafeBlockVerticalBy(20),
          backgroundColor: Color(Default.COLOR_GREEN),
          flexibleSpace: FlexibleSpaceBar(
            title: CustomWidget.getTitle(Privacy.NAME),
            background: Image.asset(
              Privacy.IMAGE,
              fit: BoxFit.cover,
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: _privacy != null
              ? Page().buildHtml(_privacy.privacy)
              : SizedBox(
                  height: MediaQuery.of(context).size.height * 2,
                  child: Align(
                    alignment: Alignment.topCenter,
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(
                        Color(Default.COLOR_GREEN),
                      ),
                    ),
                  ),
                ),
        ),
      ],
    );
  }

  Future<void> _getPrivacy() async {
    if (!_isPerformingRequest) {
      setState(() => _isPerformingRequest = true);

      _privacy = await LegalClient().getPrivacy(AssetClient());

      setState(() {
        _isPerformingRequest = false;
      });
    }
  }
}
