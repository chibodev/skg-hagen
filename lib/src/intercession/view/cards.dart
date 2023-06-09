import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:skg_hagen/src/common/library/globals.dart';
import 'package:skg_hagen/src/common/dto/default.dart';
import 'package:skg_hagen/src/common/dto/font.dart';
import 'package:skg_hagen/src/common/dto/sizeConfig.dart';
import 'package:skg_hagen/src/common/routes/routes.dart';
import 'package:skg_hagen/src/common/service/analyticsManager.dart';
import 'package:skg_hagen/src/common/service/client/dioHttpClient.dart';
import 'package:skg_hagen/src/common/service/clipboard.dart';
import 'package:skg_hagen/src/common/service/network.dart';
import 'package:skg_hagen/src/common/service/tapAction.dart';
import 'package:skg_hagen/src/common/view/customWidget.dart';
import 'package:skg_hagen/src/intercession/controller/intercession.dart'
    as Controller;
import 'package:skg_hagen/src/intercession/dto/intercession.dart' as DTO;
import 'package:skg_hagen/src/intercession/repository/intercessionClient.dart';
import 'package:skg_hagen/src/settings/view/settingsMenu.dart';

class IntercessionPage extends State<Controller.Intercession> {
  final TextEditingController _intercessionTextFieldcontroller =
      TextEditingController();
  late SettingsMenu settingsMenu;

  @override
  void initState() {
    super.initState();
    settingsMenu = SettingsMenu(pageView: this);
    AnalyticsManager().setScreen(
        DTO.Intercession.NAME, Default.classNameFromRoute(Routes.intercession));
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return GestureDetector(
      onTap: () {
        final FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: Scaffold(
        body: Builder(
          builder: (BuildContext contextOfBuilder) =>
              _buildPage(contextOfBuilder),
        ),
        bottomNavigationBar: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            CustomWidget.getFooter(DTO.Intercession.FOOTER),
            FutureBuilder<bool>(
              future: Network().hasInternet(),
              builder: (BuildContext context, AsyncSnapshot<bool> response) {
                if (response.connectionState == ConnectionState.done &&
                    response.data != null &&
                    response.data != true) {
                  return CustomWidget.noInternet();
                }
                return Container();
              },
            )
            //!_hasInternet ? CustomWidget.noInternet() : Container()
          ],
        ),
      ),
    );
  }

  Widget _buildPage(BuildContext context) {
    return CustomScrollView(
      slivers: <Widget>[
        SliverAppBar(
          pinned: true,
          expandedHeight: SizeConfig.getSafeBlockVerticalBy(20),
          backgroundColor: Color(Default.COLOR_GREEN),
          flexibleSpace: FlexibleSpaceBar(
            titlePadding: const EdgeInsetsDirectional.only(
                start: 72, bottom: 16, end: 102),
            title: CustomWidget.getTitle(DTO.Intercession.NAME,
                color: Colors.black, noShadow: true),
            background: Image.asset(
              DTO.Intercession.IMAGE,
              fit: BoxFit.cover,
            ),
          ),
          actions: <Widget>[settingsMenu.getMenu()],
        ),
        SliverToBoxAdapter(
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(
                    top: SizeConfig.getSafeBlockVerticalBy(7),
                  ),
                  child: Text(
                    DTO.Intercession.HEADER,
                    style: TextStyle(
                      fontSize: SizeConfig.getSafeBlockVerticalBy(
                          appFont.primarySize),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    left: SizeConfig.getSafeBlockVerticalBy(7),
                    right: SizeConfig.getSafeBlockVerticalBy(7),
                    bottom: SizeConfig.getSafeBlockVerticalBy(4),
                    top: SizeConfig.getSafeBlockVerticalBy(4),
                  ),
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      border: Border.all(
                          color: Colors.grey,
                          width: 0.5,
                          style: BorderStyle.solid),
                      borderRadius: BorderRadius.all(
                        Radius.circular(
                          SizeConfig.getSafeBlockVerticalBy(1),
                        ),
                      ),
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(
                        SizeConfig.getSafeBlockVerticalBy(1),
                      ),
                      child: TextField(
                        controller: _intercessionTextFieldcontroller,
                        style: TextStyle(
                          fontSize: SizeConfig.getSafeBlockVerticalBy(
                              appFont.secondarySize),
                        ),
                        autofocus: true,
                        expands: false,
                        keyboardType: TextInputType.multiline,
                        maxLines: null,
                        decoration: InputDecoration.collapsed(
                          hintText: DTO.Intercession.PLACEHOLDER,
                          hintStyle: TextStyle(
                            fontSize: SizeConfig.getSafeBlockVerticalBy(
                                appFont.secondarySize - Font.SECONDARY_SIZE),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                CustomWidget.getSendButton(context, _onSendPressed),
                Padding(
                  padding: EdgeInsets.all(20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Flexible(
                        child: Text(
                          DTO.Intercession.EMAIL_TEXT,
                          style: TextStyle(
                            fontSize: SizeConfig.getSafeBlockVerticalBy(
                                appFont.primarySize),
                          ),
                        ),
                      ),
                      InkWell(
                        splashColor: Color(Default.COLOR_GREEN),
                        onTap: () => TapAction().sendMail(
                            DTO.Intercession.EMAIL,
                            DTO.Intercession.EMAIL_NAME),
                        onLongPress: () => ClipboardService.copyAndNotify(
                            context: context, text: DTO.Intercession.EMAIL),
                        child: Padding(
                          padding: EdgeInsets.only(
                            left: SizeConfig.getSafeBlockVerticalBy(1),
                          ),
                          child: Icon(
                            Icons.email,
                            color: Colors.grey,
                            size: SizeConfig.getSafeBlockVerticalBy(
                                appFont.iconSize),
                            semanticLabel: 'E-Mail',
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }

  void _onSendPressed(BuildContext context) {
    if (_intercessionTextFieldcontroller.text.isNotEmpty) {
      _saveIntercession(context, _intercessionTextFieldcontroller.text);
    }
  }

  Future<void> _saveIntercession(
      BuildContext context, String intercession) async {
    final bool sentSuccess = await IntercessionClient()
        .saveIntercession(DioHTTPClient(), Network(), intercession);

    sentSuccess ? _sentSuccessful(context) : _sentFailed(context);
  }

  ScaffoldFeatureController<SnackBar, SnackBarClosedReason> _sentSuccessful(
      BuildContext context) {
    _intercessionTextFieldcontroller.clear();

    final FocusScopeNode currentFocus = FocusScope.of(context);
    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
    }

    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Color(Default.COLOR_GREEN),
        content: _notification(DTO.Intercession.SUCCESS, Icons.check_circle),
      ),
    );
  }

  ScaffoldFeatureController<SnackBar, SnackBarClosedReason> _sentFailed(
      BuildContext context) {
    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
          backgroundColor: Colors.red,
          content: _notification(DTO.Intercession.ERROR, Icons.error)),
    );
  }

  ListTile _notification(String text, IconData icon) {
    return ListTile(
      leading: Icon(
        icon,
        color: Colors.white,
        size: SizeConfig.getSafeBlockVerticalBy(appFont.iconSize),
      ),
      title: Text(
        text,
        style: TextStyle(
          color: Colors.white,
          fontSize: SizeConfig.getSafeBlockVerticalBy(appFont.primarySize),
        ),
      ),
    );
  }
}
