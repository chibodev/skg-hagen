import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:skg_hagen/src/common/library/globals.dart';
import 'package:skg_hagen/src/common/model/default.dart';
import 'package:skg_hagen/src/common/model/sizeConfig.dart';
import 'package:skg_hagen/src/common/service/client/dioHttpClient.dart';
import 'package:skg_hagen/src/common/service/clipboard.dart';
import 'package:skg_hagen/src/common/service/network.dart';
import 'package:skg_hagen/src/common/service/tapAction.dart';
import 'package:skg_hagen/src/common/view/customWidget.dart';
import 'package:skg_hagen/src/offer/controller/aid.dart';
import 'package:skg_hagen/src/offer/model/aidOffer.dart' as Model;
import 'package:skg_hagen/src/offer/model/aidOfferQuestion.dart';
import 'package:skg_hagen/src/offer/model/helper.dart';
import 'package:skg_hagen/src/offer/model/offers.dart';
import 'package:skg_hagen/src/offer/repository/aidOfferClient.dart';
import 'package:skg_hagen/src/settings/view/settingsMenu.dart';

class AidOffer extends State<Aid> {
  final List<bool> _checkboxValue = List<bool>();
  final TextEditingController _name = TextEditingController();
  final TextEditingController _age = TextEditingController();
  final TextEditingController _city = TextEditingController();
  final TextEditingController _contact = TextEditingController();
  final TextEditingController _reason = TextEditingController();
  SettingsMenu settingsMenu;

  @override
  void initState() {
    super.initState();
    settingsMenu = SettingsMenu(pageView: this);
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    final double thirty = SizeConfig.getSafeBlockVerticalBy(3.5);
    return Scaffold(
      body: Builder(
        builder: (BuildContext contextOfBuilder) => Container(
          child: CustomScrollView(
            slivers: <Widget>[
              SliverAppBar(
                iconTheme: IconThemeData(color: Colors.white),
                pinned: true,
                expandedHeight: SizeConfig.getSafeBlockVerticalBy(20),
                backgroundColor: Color(Default.COLOR_GREEN),
                flexibleSpace: FlexibleSpaceBar(
                  title: CustomWidget.getTitle(Model.AidOffer.NAME),
                  background: Image.asset(
                    Offers.IMAGE,
                    fit: BoxFit.cover,
                  ),
                ),
                actions: <Widget>[settingsMenu.getMenu()],
              ),
              SliverToBoxAdapter(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Flexible(
                      child: widget?.aidOffer != null
                          ? Padding(
                              padding: EdgeInsets.all(thirty),
                              child: SelectableText(
                                widget.aidOffer.description,
                                style: TextStyle(
                                  fontSize: SizeConfig.getSafeBlockVerticalBy(
                                      appFont.primarySize),
                                ),
                              ),
                            )
                          : CustomWidget.centeredNoEntry(),
                    ),
                    widget?.aidOffer != null && widget?.aidOfferQuestion != null
                        ? Flexible(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: _buildQuestions(
                                  contextOfBuilder, widget.aidOfferQuestion),
                            ),
                          )
                        : Container()
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          !widget.dataAvailable ? CustomWidget.noInternet() : Container(),
        ],
      ),
    );
  }

  List<Widget> _buildQuestions(
      BuildContext contextOfBuilder, List<AidOfferQuestion> questions) {
    final List<Widget> list = List<Widget>();
    List<Widget> checkBox = List<Widget>();

    final double thirty = SizeConfig.getSafeBlockVerticalBy(3.5);
    final double top = SizeConfig.getSafeBlockVerticalBy(1.0);

    for (int i = 0; i < questions.length; i++) {
      if (questions[i]?.type == 'checkbox') {
        list.add(
          _getLabel(thirty, questions[i].question, FontWeight.bold),
        );
        for (int x = 0; x < questions[i]?.option?.length; x++) {
          _checkboxValue.add(false);
          checkBox.add(
            Padding(
              padding: EdgeInsets.only(left: thirty),
              child: Checkbox(
                activeColor: Color(Default.COLOR_GREEN),
                value: _checkboxValue[x],
                onChanged: (bool value) {
                  setState(() {
                    _checkboxValue[x] = value;
                  });
                },
              ),
            ),
          );
          checkBox.add(
            Flexible(
                child: _getLabel(
                    thirty, questions[i].option[x], FontWeight.normal)),
          );
          list.add(
            Row(
              children: checkBox,
            ),
          );
          checkBox = List<Widget>();
        }
      }

      if (questions[i]?.type == 'text') {
        list.add(
          _getLabel(thirty, questions[i].question, FontWeight.bold),
        );
        for (int x = 0; x < questions[i]?.option?.length; x++) {
          final String label = questions[i].option[x];
          final Map<String, dynamic> option =
              _getTextFieldOptionController(label);

          list.add(
            _getLabel(thirty, label, FontWeight.normal, top: top, bottom: top),
          );
          list.add(
            Padding(
              padding:
                  EdgeInsets.only(left: thirty, right: thirty, bottom: top),
              child: TextField(
                controller: option['controller'],
                style: TextStyle(
                  fontSize:
                      SizeConfig.getSafeBlockVerticalBy(appFont.secondarySize),
                ),
                expands: false,
                keyboardType: option['type'],
                maxLines: null,
                decoration: InputDecoration(icon: option['icon']),
                maxLength: option['maxLength'],
                inputFormatters: option['inputFormat'],
              ),
            ),
          );
        }
      }
    }

    list.add(
      Padding(
        padding: EdgeInsets.all(thirty),
        child: CustomWidget.getSendButton(contextOfBuilder, _onSendPressed),
      ),
    );

    list.add(
      Padding(
        padding: EdgeInsets.all(thirty),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Flexible(
              child: Text(
                Model.AidOffer.EMAIL_TEXT,
                style: TextStyle(
                  fontSize:
                      SizeConfig.getSafeBlockVerticalBy(appFont.primarySize),
                ),
              ),
            ),
            InkWell(
              splashColor: Color(Default.COLOR_GREEN),
              onTap: () => TapAction().sendMail(widget.aidOffer.email,
                  widget.aidOffer.title, contextOfBuilder,
                  body: Model.AidOffer.EMAIL_BODY),
              onLongPress: () => ClipboardService.copyAndNotify(
                  context: contextOfBuilder, text: widget.aidOffer.email),
              child: Padding(
                padding: EdgeInsets.only(
                  left: SizeConfig.getSafeBlockVerticalBy(1),
                ),
                child: Icon(
                  Icons.email,
                  color: Colors.grey,
                  size: SizeConfig.getSafeBlockVerticalBy(appFont.iconSize),
                  semanticLabel: 'E-Mail',
                ),
              ),
            ),
          ],
        ),
      ),
    );

    return list;
  }

  void _onSendPressed(BuildContext contextOfBuilder) {
    if (_isFormValid()) {
      _saveHelper(contextOfBuilder);
    } else {
      CustomWidget.showNotification(contextOfBuilder, Model.AidOffer.INCOMPLETE,
          Icons.warning, Colors.redAccent);
    }
  }

  Map<String, dynamic> _getTextFieldOptionController(String name) {
    final Map<String, dynamic> option = Map<String, dynamic>();

    option.putIfAbsent('type', () => TextInputType.multiline);
    option.putIfAbsent('maxLength', () => null);
    option.putIfAbsent('inputFormat', () => null);

    switch (name.replaceAll(RegExp(r"\s\b|\b\s|\(|\)"), "").toLowerCase()) {
      case 'name':
        option.putIfAbsent('controller', () => _name);
        option.putIfAbsent('icon', () => Icon(Icons.person));
        break;
      case 'alter':
        option.putIfAbsent('controller', () => _age);
        option.putIfAbsent('icon', () => Icon(Icons.perm_contact_calendar));
        option['type'] = TextInputType.number;
        option['maxLength'] = 2;
        option['inputFormat'] = <TextInputFormatter>[
          WhitelistingTextInputFormatter.digitsOnly
        ];
        break;
      case 'wohnortortteil':
        option.putIfAbsent('controller', () => _city);
        option.putIfAbsent('icon', () => Icon(Icons.location_city));
        break;
      case 'sieerreichenmich':
        option.putIfAbsent('controller', () => _contact);
        option.putIfAbsent('icon', () => Icon(Icons.contacts));
        option['type'] = TextInputType.emailAddress;
        break;
      case 'ichmöchtegernhelfenweil':
        option.putIfAbsent('controller', () => _reason);
        option.putIfAbsent('icon', () => Icon(Icons.info_outline));
        break;
    }

    return option;
  }

  Padding _getLabel(double thirty, String text, FontWeight weight,
      {double top = 0.0, double bottom = 0.0}) {
    return Padding(
      padding: EdgeInsets.only(
          left: thirty, right: thirty, top: top, bottom: bottom),
      child: Text(
        text,
        style: TextStyle(
          fontWeight: weight,
          fontSize: SizeConfig.getSafeBlockVerticalBy(appFont.primarySize),
        ),
      ),
    );
  }

  bool _isFormValid() {
    return (_name.text.isEmpty ||
            _age.text.isEmpty ||
            _city.text.isEmpty ||
            _contact.text.isEmpty ||
            _reason.text.isEmpty)
        ? false
        : true;
  }

  void _saveHelper(BuildContext context) async {
    final Helper helper = Helper(
        shopping: _checkboxValue[0],
        errands: _checkboxValue[1],
        animalWalk: _checkboxValue[2],
        name: _name.text,
        age: _age.text,
        reason: _reason.text,
        city: _city.text,
        contact: _contact.text);

    String text = Model.AidOffer.ERROR;
    Color backgroundColor = Colors.red;
    IconData icon = Icons.error;

    final bool sentSuccess =
        await AidOfferClient().saveHelper(DioHTTPClient(), Network(), helper);

    if (sentSuccess) {
      text = Model.AidOffer.SUCCESS;
      icon = Icons.check_circle;
      backgroundColor = Color(Default.COLOR_GREEN);
      _name.clear();
      _age.clear();
      _reason.clear();
      _city.clear();
      _contact.clear();
      _checkboxValue.clear();
      final FocusScopeNode currentFocus = FocusScope.of(context);
      if (!currentFocus.hasPrimaryFocus) {
        currentFocus.unfocus();
      }
    }

    CustomWidget.showNotification(context, text, icon, backgroundColor);
  }
}
