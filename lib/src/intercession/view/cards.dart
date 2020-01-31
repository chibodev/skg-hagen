import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:skg_hagen/src/common/model/default.dart';
import 'package:skg_hagen/src/common/model/sizeConfig.dart';
import 'package:skg_hagen/src/common/service/client/dioHttpClient.dart';
import 'package:skg_hagen/src/common/service/clipboard.dart';
import 'package:skg_hagen/src/common/service/network.dart';
import 'package:skg_hagen/src/common/service/tapAction.dart';
import 'package:skg_hagen/src/common/view/customWidget.dart';
import 'package:skg_hagen/src/intercession/controller/intercession.dart'
    as Controller;
import 'package:skg_hagen/src/intercession/model/intercession.dart' as Model;
import 'package:skg_hagen/src/intercession/repository/intercessionClient.dart';

class Page extends State<Controller.Intercession> {
  final TextEditingController _intercessionTextFieldcontroller =
      TextEditingController();

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
            CustomWidget.getFooter(Model.Intercession.FOOTER),
            FutureBuilder<bool>(
              future: Network().hasInternet(),
              builder: (BuildContext context, AsyncSnapshot<bool> response) {
                if (response.connectionState == ConnectionState.done &&
                    response.data != null &&
                    !response.data == true) {
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
            title: CustomWidget.getTitle(Model.Intercession.NAME,
                color: Colors.black, noShadow: true),
            background: Image.asset(
              Model.Intercession.IMAGE,
              fit: BoxFit.cover,
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(
                      top: SizeConfig.getSafeBlockVerticalBy(7)),
                  child: Text(
                    Model.Intercession.HEADER,
                    style: TextStyle(
                      fontSize: SizeConfig.getSafeBlockVerticalBy(
                          Default.STANDARD_FONT_SIZE),
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
                        Radius.circular(SizeConfig.getSafeBlockVerticalBy(1)),
                      ),
                    ),
                    child: Padding(
                      padding:
                          EdgeInsets.all(SizeConfig.getSafeBlockVerticalBy(1)),
                      child: TextField(
                        controller: _intercessionTextFieldcontroller,
                        autofocus: true,
                        expands: false,
                        keyboardType: TextInputType.multiline,
                        maxLines: null,
                        decoration: InputDecoration.collapsed(
                            hintText: Model.Intercession.PLACEHOLDER),
                      ),
                    ),
                  ),
                ),
                FlatButton(
                  color: Color(Default.COLOR_GREEN),
                  textColor: Colors.white,
                  padding: EdgeInsets.only(
                    left: SizeConfig.getSafeBlockVerticalBy(7),
                    right: SizeConfig.getSafeBlockVerticalBy(7),
                    top: SizeConfig.getSafeBlockVerticalBy(2),
                    bottom: SizeConfig.getSafeBlockVerticalBy(2),
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  onPressed: () => _saveIntercession(
                      context, _intercessionTextFieldcontroller.text),
                  child: Text(('Senden').toUpperCase()),
                ),
                Padding(
                  padding: EdgeInsets.all(20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Flexible(
                        child: Text(
                          Model.Intercession.EMAIL_TEXT,
                          style: TextStyle(
                            fontSize: SizeConfig.getSafeBlockVerticalBy(
                                Default.SUBSTANDARD_FONT_SIZE),
                          ),
                        ),
                      ),
                      InkWell(
                        splashColor: Color(Default.COLOR_GREEN),
                        onTap: () => TapAction().sendMail(
                            Model.Intercession.EMAIL, Model.Intercession.NAME),
                        onLongPress: () => ClipboardService.copyAndNotify(
                            context: context, text: Model.Intercession.EMAIL),
                        child: Padding(
                          padding: EdgeInsets.only(
                            left: SizeConfig.getSafeBlockVerticalBy(1),
                          ),
                          child: Icon(
                            Icons.email,
                            color: Colors.grey,
                            size: SizeConfig.getSafeBlockVerticalBy(4),
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

    return Scaffold.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Color(Default.COLOR_GREEN),
        content: _notification(Model.Intercession.SUCCESS, Icons.check_circle),
      ),
    );
  }

  ScaffoldFeatureController<SnackBar, SnackBarClosedReason> _sentFailed(
      BuildContext context) {
    return Scaffold.of(context).showSnackBar(
      SnackBar(
          backgroundColor: Colors.red,
          content: _notification(Model.Intercession.ERROR, Icons.error)),
    );
  }

  ListTile _notification(String text, IconData icon) {
    return ListTile(
      leading: Icon(
        icon,
        color: Colors.white,
      ),
      title: Text(
        text,
        style: TextStyle(
          color: Colors.white,
          fontSize:
              SizeConfig.getSafeBlockVerticalBy(Default.STANDARD_FONT_SIZE),
        ),
      ),
    );
  }
}
