import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:skg_hagen/src/common/library/globals.dart';
import 'package:skg_hagen/src/common/model/default.dart';
import 'package:skg_hagen/src/common/model/sizeConfig.dart';
import 'package:skg_hagen/src/common/service/client/dioHttpClient.dart';
import 'package:skg_hagen/src/common/service/network.dart';
import 'package:skg_hagen/src/common/view/customWidget.dart';
import 'package:skg_hagen/src/pushnotification/controller/appointmentController.dart';
import 'package:skg_hagen/src/pushnotification/model/pushNotification.dart';
import 'package:skg_hagen/src/pushnotification/model/pushNotifications.dart';
import 'package:skg_hagen/src/pushnotification/repository/pushNotificationClient.dart';
import 'package:skg_hagen/src/settings/view/settingsMenu.dart';

class NotificationList extends State<PushNotificationController> {
  int _indexCounter = 0;
  PushNotifications pushNotifications;
  final ScrollController _scrollController = ScrollController();
  bool _isPerformingRequest = false;
  bool _hasInternet = true;
  SettingsMenu settingsMenu;

  @override
  void initState() {
    super.initState();
    settingsMenu = SettingsMenu(pageView: this);
    _getInitialNotifications();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        _getMoreNotifications();
      }
    });
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
          _getInitialNotifications();
        },
        child: _buildList(context, pushNotifications),
      ),
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          !_hasInternet ? CustomWidget.noInternet() : Container()
        ],
      ),
    );
  }

  Future<void> _getInitialNotifications() async {
    if (!_isPerformingRequest) {
      setState(() => _isPerformingRequest = true);
      _hasInternet = true;

      pushNotifications = await PushNotificationClient()
          .getPushNotifications(DioHTTPClient(), Network(), refresh: true);

      final bool status = pushNotifications?.pushNotification != null;
      _hasInternet = await Network().hasInternet();

      if (status && pushNotifications.pushNotification.isEmpty) {
        final double edge = 50.0;
        final double offsetFromBottom =
            _scrollController.position.maxScrollExtent -
                _scrollController.position.pixels;
        if (offsetFromBottom < edge) {
          _scrollController.animateTo(
              _scrollController.offset - (edge - offsetFromBottom),
              duration: Duration(milliseconds: 500),
              curve: Curves.easeOut);
        }
      }
      setState(() {
        _isPerformingRequest = false;
        _indexCounter = 1;
      });
    }
  }

  Future<void> _getMoreNotifications() async {
    if (!_isPerformingRequest) {
      setState(() => _isPerformingRequest = true);

      _hasInternet = await Network().hasInternet();
      if (!_hasInternet) {
        _isPerformingRequest = false;
      } else {
        final PushNotifications newNotifications =
            await PushNotificationClient().getPushNotifications(
                DioHTTPClient(), Network(),
                index: _indexCounter, refresh: true);

        final List<PushNotification> newEntries =
            newNotifications?.pushNotification;
        final bool isResponseEmpty = newEntries?.isEmpty;
        if (isResponseEmpty != null && isResponseEmpty) {
          final double edge = 50.0;
          final double offsetFromBottom =
              _scrollController.position.maxScrollExtent -
                  _scrollController.position.pixels;
          if (offsetFromBottom < edge) {
            _scrollController.animateTo(
                _scrollController.offset - (edge - offsetFromBottom),
                duration: Duration(milliseconds: 500),
                curve: Curves.easeOut);
          }
        }
        setState(() {
          _isPerformingRequest = false;
          if (isResponseEmpty != null && !isResponseEmpty) {
            pushNotifications?.pushNotification?.addAll(newEntries);
            _indexCounter++;
          }
        });
      }
    }
  }

  Widget _buildList(BuildContext context, PushNotifications pushNotifications) {
    return CustomScrollView(
      controller: _scrollController,
      slivers: <Widget>[
        SliverAppBar(
          iconTheme: IconThemeData(color: Colors.white),
          pinned: true,
          expandedHeight: SizeConfig.getSafeBlockVerticalBy(20),
          backgroundColor: Color(Default.COLOR_GREEN),
          flexibleSpace: FlexibleSpaceBar(
            titlePadding: const EdgeInsetsDirectional.only(
                start: 72, bottom: 16, end: 102),
            title: CustomWidget.getTitle(PushNotifications.NAME),
            background: Image.asset(
              PushNotifications.IMAGE,
              fit: BoxFit.cover,
            ),
          ),
          actions: <Widget>[settingsMenu.getMenu()],
        ),
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (BuildContext context, int index) {
              return pushNotifications == null
                  ? CustomWidget.buildProgressIndicator(_isPerformingRequest)
                  : _buildRows(
                      context, pushNotifications.pushNotification[index]);
            },
            childCount: pushNotifications?.pushNotification?.length ?? 0,
          ),
        ),
        SliverToBoxAdapter(
          child: (!_hasInternet)
              ? Container()
              : CustomWidget.buildProgressIndicator(_isPerformingRequest),
        )
      ],
    );
  }

  Widget _buildRows(BuildContext context, PushNotification list) {
    return Material(
      child: Padding(
        padding: EdgeInsets.only(
          bottom: SizeConfig.getSafeBlockHorizontalBy(1),
        ),
        child: Card(
          child: Column(
            children: <Widget>[
              ListTile(
                isThreeLine: true,
                onTap: () => Navigator.of(context).pushNamed(list.screen),
                title: Text(
                  list.title,
                  style: TextStyle(
                    fontSize:
                        SizeConfig.getSafeBlockVerticalBy(appFont.primarySize),
                  ),
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      list.body,
                      style: TextStyle(
                        fontSize: SizeConfig.getSafeBlockVerticalBy(
                            appFont.secondarySize),
                      ),
                    ),
                    Text(
                      "${list.getCategory()} · ${list.getFormattedValidUntil()}",
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: SizeConfig.getSafeBlockVerticalBy(
                            appFont.primarySize - 1),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
