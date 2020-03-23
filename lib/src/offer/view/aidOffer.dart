import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:skg_hagen/src/common/model/default.dart';
import 'package:skg_hagen/src/common/model/sizeConfig.dart';
import 'package:skg_hagen/src/common/view/customWidget.dart';
import 'package:skg_hagen/src/offer/controller/aid.dart';
import 'package:skg_hagen/src/offer/model/aidOfferQuestion.dart';
import 'package:skg_hagen/src/offer/model/helper.dart';
import 'package:skg_hagen/src/offer/model/offers.dart';

class AidOffer extends State<Aid> {
  BuildContext _context;
  final List<bool> _checkboxValue = List<bool>();
  final TextEditingController _name = TextEditingController();
  final TextEditingController _age = TextEditingController();
  final TextEditingController _city = TextEditingController();
  final TextEditingController _contact = TextEditingController();
  final TextEditingController _reason = TextEditingController();

  @override
  Widget build(BuildContext context) {
    _context = context;
    SizeConfig().init(context);
    final double thirty = SizeConfig.getSafeBlockVerticalBy(3.5);
    return Scaffold(
      body: Container(
        child: CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              iconTheme: IconThemeData(color: Colors.white),
              pinned: true,
              expandedHeight: SizeConfig.getSafeBlockVerticalBy(20),
              backgroundColor: Color(Default.COLOR_GREEN),
              flexibleSpace: FlexibleSpaceBar(
                title: CustomWidget.getTitle(widget.aidOffer.title),
                background: Image.asset(
                  Offers.IMAGE,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Flexible(
                    child: widget.aidOffer != null
                        ? Padding(
                            padding: EdgeInsets.all(thirty),
                            child: SelectableText(
                              widget.aidOffer.description,
                              style: TextStyle(
                                fontSize: SizeConfig.getSafeBlockVerticalBy(
                                    Default.STANDARD_FONT_SIZE),
                              ),
                            ),
                          )
                        : CustomWidget.centeredNoEntry(),
                  ),
                  widget.aidOfferQuestion != null
                      ? Flexible(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: _buildQuestions(widget.aidOfferQuestion),
                          ),
                        )
                      : Container()
                ],
              ),
            ),
          ],
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

  List<Widget> _buildQuestions(List<AidOfferQuestion> questions) {
    final List<Widget> list = List<Widget>();
    List<Widget> checkBox = List<Widget>();
    List<Widget> textField = List<Widget>();

    final double thirty = SizeConfig.getSafeBlockVerticalBy(3.5);
    final double top = SizeConfig.getSafeBlockVerticalBy(1.0);

    for (int i = 0; i < questions.length; i++) {
      if (questions[i]?.type == 'checkbox') {
        list.add(
          getLabel(thirty, questions[i].question, FontWeight.bold),
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
                child: getLabel(
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
          getLabel(thirty, questions[i].question, FontWeight.bold),
        );
        for (int x = 0; x < questions[i]?.option?.length; x++) {
          final String label = questions[i].option[x];
          final Map<String, dynamic> option =
              _getTextFieldOptionController(label);

          list.add(
            getLabel(thirty, label, FontWeight.normal, top: top, bottom: top),
          );
          list.add(Padding(
            padding: EdgeInsets.only(left: thirty, right: thirty, bottom: top),
            child: TextField(
              controller: option['controller'],
              expands: false,
              keyboardType: option['type'],
              maxLines: null,
              decoration: InputDecoration(icon: option['icon']),
            ),
          ));
          textField = List<Widget>();
        }
      }
    }

    list.add(
      Padding(
        padding: EdgeInsets.all(thirty),
        child: FlatButton(
          color: Color(Default.COLOR_GREEN),
          textColor: Colors.white,
          padding: EdgeInsets.only(
            left: thirty,
            right: SizeConfig.getSafeBlockVerticalBy(7),
            top: SizeConfig.getSafeBlockVerticalBy(2),
            bottom: SizeConfig.getSafeBlockVerticalBy(2),
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.0),
          ),
          onPressed: () {
            if (_isFormValid()) {
              _saveHelper(_context);
            }
          },
          child: Text(('Senden').toUpperCase()),
        ),
      ),
    );
    return list;
  }

  Map<String, dynamic> _getTextFieldOptionController(String name) {
    final Map<String, dynamic> option = Map<String, dynamic>();

    option.putIfAbsent('type', () => TextInputType.multiline);

    switch (name.replaceAll(RegExp(r"\s\b|\b\s|\(|\)"), "").toLowerCase()) {
      case 'name':
        option.putIfAbsent('controller', () => _name);
        option.putIfAbsent('icon', () => Icon(Icons.person));
        break;
      case 'alter':
        option.putIfAbsent('controller', () => _age);
        option.putIfAbsent('icon', () => Icon(Icons.perm_contact_calendar));
        option['type'] = TextInputType.number;
        break;
      case 'wohnortortteil':
        option.putIfAbsent('controller', () => _city);
        option.putIfAbsent('icon', () => Icon(Icons.location_city));
        break;
      case 'sieerreichenmich':
        option.putIfAbsent('controller', () => _contact);
        option.putIfAbsent('icon', () => Icon(Icons.contacts));
        break;
      case 'ichmöchtegernhelfenweil':
        option.putIfAbsent('controller', () => _reason);
        option.putIfAbsent('icon', () => Icon(Icons.info_outline));
        break;
    }

    return option;
  }

  Padding getLabel(double thirty, String text, FontWeight weight,
      {double top = 0.0, double bottom = 0.0}) {
    return Padding(
      padding: EdgeInsets.only(
          left: thirty, right: thirty, top: top, bottom: bottom),
      child: Text(
        text,
        style: TextStyle(
          fontWeight: weight,
          fontSize:
              SizeConfig.getSafeBlockVerticalBy(Default.STANDARD_FONT_SIZE),
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

  void _saveHelper(BuildContext context) {
    final Helper helper = Helper(
        shopping: _checkboxValue[0],
        errands: _checkboxValue[1],
        animalWalk: _checkboxValue[2],
        name: _name.text,
        age: _age.text,
        reason: _reason.text,
        city: _city.text,
        contact: _contact.text);
    //TODO: Save helper info
  }
}
