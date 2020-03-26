import 'package:flutter/material.dart';
import 'package:skg_hagen/src/common/model/default.dart';
import 'package:skg_hagen/src/common/model/sizeConfig.dart';
import 'package:skg_hagen/src/common/service/client/assetClient.dart';
import 'package:skg_hagen/src/common/view/customWidget.dart';
import 'package:skg_hagen/src/legal/controller/imprint.dart' as Controller;
import 'package:skg_hagen/src/legal/model/imprint.dart';
import 'package:skg_hagen/src/legal/repository/legalClient.dart';
import 'package:skg_hagen/src/legal/view/page.dart';
import 'package:skg_hagen/src/settings/view/settingsMenu.dart';

class ImprintView extends State<Controller.Imprint> {
  Imprint _imprint;
  bool _isPerformingRequest = false;
  SettingsMenu settingsMenu;

  @override
  void initState() {
    super.initState();
    settingsMenu = SettingsMenu(pageView: this);
    _getImprint();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () async {
          _getImprint();
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
            title: CustomWidget.getTitle(Imprint.NAME),
            background: Image.asset(
              Imprint.IMAGE,
              fit: BoxFit.cover,
            ),
          ),
          actions: <Widget>[settingsMenu.getMenu()],
        ),
        SliverToBoxAdapter(
          child: _imprint != null
              ? Page().buildHtml(_imprint.imprint)
              : CustomWidget.buildSliverSpinner(),
        ),
        _imprint == null
            ? SliverToBoxAdapter(
                child: CustomWidget.buildSliverSpinner(),
              )
            : SliverToBoxAdapter(),
      ],
    );
  }

  Future<void> _getImprint() async {
    if (!_isPerformingRequest) {
      setState(() => _isPerformingRequest = true);

      _imprint = await LegalClient().getImprint(AssetClient());

      setState(() {
        _isPerformingRequest = false;
      });
    }
  }
}
