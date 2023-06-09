import 'package:flutter/material.dart';
import 'package:skg_hagen/src/common/dto/default.dart';
import 'package:skg_hagen/src/common/dto/sizeConfig.dart';
import 'package:skg_hagen/src/common/service/analyticsManager.dart';
import 'package:skg_hagen/src/common/service/client/assetClient.dart';
import 'package:skg_hagen/src/legal/controller/imprint.dart' as Controller;
import 'package:skg_hagen/src/legal/dto/imprint.dart';
import 'package:skg_hagen/src/legal/dto/privacy.dart';
import 'package:skg_hagen/src/legal/repository/legalClient.dart';
import 'package:skg_hagen/src/legal/view/page.dart';
import 'package:skg_hagen/src/settings/view/settingsMenu.dart';

class ImprintView extends State<Controller.Imprint> {
  late Imprint _imprint;
  late Privacy _privacy;
  bool _dataAvailableImprint = false;
  bool _dataAvailablePrivacy = false;
  bool _isPerformingRequestImprint = false;
  bool _isPerformingRequestPrivacy = false;
  late SettingsMenu settingsMenu;

  @override
  void initState() {
    super.initState();
    settingsMenu = SettingsMenu(pageView: this);
    AnalyticsManager().setScreen(Imprint.NAME, Default.capitalize('legal'));
    _getImprint();
    _getPrivacy();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      body: _buildContent(),
    );
  }

  Widget _buildContent() {
    return DefaultTabController(
      length: 2,
      child: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool value) {
          return <Widget>[
            SliverAppBar(
              pinned: true,
              iconTheme: IconThemeData(color: Colors.white),
              backgroundColor: Color(Default.COLOR_GREEN),
              actions: <Widget>[settingsMenu.getMenu()],
              bottom: TabBar(
                indicatorColor: Colors.black,
                tabs: <Tab>[
                  Tab(
                    icon: ImageIcon(
                      AssetImage(Imprint.IMAGE),
                      color: Colors.white,
                    ),
                    child: Text(
                      Imprint.NAME,
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  Tab(
                    icon: Icon(
                      Icons.lock,
                      color: Colors.white,
                    ),
                    child: Text(
                      Privacy.NAME,
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          ];
        },
        body: TabBarView(
          children: <Widget>[
            _dataAvailableImprint
                ? LegalPage().buildHtml(_imprint.imprint)
                : Container(),
            _dataAvailablePrivacy
                ? LegalPage().buildHtml(_privacy.privacy)
                : Container()
          ],
        ),
      ),
    );
  }

  Future<void> _getImprint() async {
    if (!_isPerformingRequestImprint) {
      setState(() => _isPerformingRequestImprint = true);

      _imprint = await LegalClient().getImprint(AssetClient());

      setState(() {
        _isPerformingRequestImprint = false;
        _dataAvailableImprint = _imprint?.imprint != null;
      });
    }
  }

  Future<void> _getPrivacy() async {
    if (!_isPerformingRequestPrivacy) {
      setState(() => _isPerformingRequestPrivacy = true);

      _privacy = await LegalClient().getPrivacy(AssetClient());

      setState(() {
        _isPerformingRequestPrivacy = false;
        _dataAvailablePrivacy = _privacy?.privacy != null;
      });
    }
  }
}
