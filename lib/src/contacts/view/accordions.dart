import 'package:flutter/material.dart';
import 'package:skg_hagen/src/common/dto/default.dart';
import 'package:skg_hagen/src/common/dto/sizeConfig.dart';
import 'package:skg_hagen/src/common/routes/routes.dart';
import 'package:skg_hagen/src/common/service/analyticsManager.dart';
import 'package:skg_hagen/src/common/service/client/dioHttpClient.dart';
import 'package:skg_hagen/src/common/service/network.dart';
import 'package:skg_hagen/src/common/view/customWidget.dart';
import 'package:skg_hagen/src/contacts/controller/contacts.dart' as Controller;
import 'package:skg_hagen/src/contacts/dto/contacts.dart';
import 'package:skg_hagen/src/contacts/repository/contactsClient.dart';
import 'package:skg_hagen/src/contacts/view/cards.dart';
import 'package:skg_hagen/src/settings/view/settingsMenu.dart';

class Accordions extends State<Controller.Contacts> {
  Contacts? _contacts;
  late List<dynamic> _options;
  bool _isPerformingRequest = false;
  bool _hasInternet = true;
  bool _dataAvailable = false;
  late SettingsMenu settingsMenu;

  @override
  void initState() {
    super.initState();
    settingsMenu = SettingsMenu(pageView: this);
    AnalyticsManager().setScreen('Kontakte', 'Contacts');
    AnalyticsManager().setScreen(Contacts.NAME, Default.classNameFromRoute(Routes.contacts));
    _getContacts();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () async {
          _getContacts();
        },
        child: _buildCards(context),
      ),
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[!_hasInternet ? CustomWidget.noInternet() : Container()],
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
            titlePadding: const EdgeInsetsDirectional.only(start: 72, bottom: 16, end: 102),
            title: CustomWidget.getTitle(Contacts.NAME),
            background: Image.asset(
              Contacts.IMAGE,
              fit: BoxFit.cover,
            ),
          ),
          actions: <Widget>[settingsMenu.getMenu()],
        ),
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (BuildContext context, int index) => !_dataAvailable ? CustomWidget.buildSliverSpinner() : Cards().buildRows(_options[index], context),
            childCount: _options.length,
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

  Future<void> _getContacts() async {
    if (!_isPerformingRequest) {
      setState(() => _isPerformingRequest = true);

      _hasInternet = await Network().hasInternet();

      _contacts = await ContactsClient().getContacts(
        DioHTTPClient(),
        Network(),
      );
      _options = <dynamic>[];
      if (_contacts != null) {
        _options.add(_contacts!.address);
        _options.add(_contacts!.contact);
        _options.add(_contacts!.social);
        _dataAvailable = true;
      }
      setState(() {
        _isPerformingRequest = false;
      });
    }
  }
}
