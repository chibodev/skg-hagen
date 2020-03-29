import 'package:flutter/material.dart';
import 'package:skg_hagen/src/common/model/default.dart';
import 'package:skg_hagen/src/common/model/sizeConfig.dart';
import 'package:skg_hagen/src/common/service/client/assetClient.dart';
import 'package:skg_hagen/src/common/view/customWidget.dart';
import 'package:skg_hagen/src/legal/controller/privacy.dart' as Controller;
import 'package:skg_hagen/src/legal/model/privacy.dart';
import 'package:skg_hagen/src/legal/repository/legalClient.dart';
import 'package:skg_hagen/src/legal/view/page.dart';
import 'package:skg_hagen/src/settings/view/settingsMenu.dart';

class PrivacyView extends State<Controller.Privacy> {
  Privacy _privacy;
  bool _isPerformingRequest = false;
  SettingsMenu settingsMenu;

  @override
  void initState() {
    super.initState();
    settingsMenu = SettingsMenu(pageView: this);
    _getPrivacy();
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
      slivers: <Widget>[
        SliverAppBar(
          pinned: true,
          iconTheme: IconThemeData(color: Colors.white),
          expandedHeight: SizeConfig.getSafeBlockVerticalBy(20),
          backgroundColor: Color(Default.COLOR_GREEN),
          flexibleSpace: FlexibleSpaceBar(
            titlePadding: const EdgeInsetsDirectional.only(
                start: 72, bottom: 16, end: 102),
            title: CustomWidget.getTitle(Privacy.NAME),
            background: Image.asset(
              Privacy.IMAGE,
              fit: BoxFit.cover,
            ),
          ),
          actions: <Widget>[settingsMenu.getMenu()],
        ),
        SliverToBoxAdapter(
          child: _privacy != null
              ? Page().buildHtml(_privacy.privacy)
              : CustomWidget.buildSliverSpinner(),
        ),
        _privacy == null
            ? SliverToBoxAdapter(
                child: CustomWidget.buildSliverSpinner(),
              )
            : SliverToBoxAdapter(),
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
