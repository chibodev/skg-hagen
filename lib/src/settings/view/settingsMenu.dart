import 'package:flutter/material.dart';
import 'package:skg_hagen/src/common/library/globals.dart';
import 'package:skg_hagen/src/common/model/default.dart';
import 'package:skg_hagen/src/common/model/sizeConfig.dart';
import 'package:skg_hagen/src/common/service/client/assetClient.dart';
import 'package:skg_hagen/src/settings/model/settingsList.dart';
import 'package:skg_hagen/src/settings/service/settings.dart';

class SettingsMenu {
  List<SettingsList> choices;
  dynamic pageView;
  BuildContext _context;

  SettingsMenu({@required this.pageView}) {
    _populateSettingsList();
  }

  Widget getMenu() {
    return PopupMenuButton<dynamic>(
        onSelected: _selected,
        itemBuilder: (BuildContext context) {
          SizeConfig().init(context);
          _context = context;
          return choices.map((SettingsList choice) {
            return PopupMenuItem<SettingsList>(
              value: choice,
              child: Text(
                Default?.capitalize(choice.title),
                style: TextStyle(
                  fontSize:
                      SizeConfig.getSafeBlockVerticalBy(appFont.primarySize),
                ),
              ),
            );
          }).toList();
        });
  }

  void _populateSettingsList() async {
    choices = await Settings().getList(AssetClient());
  }

  void _selected(dynamic choice) {
    switch (choice.title) {
      case SettingsList.FONT_SIZE:
        _displayFontSizeEditing();
        break;
    }
  }

  void _displayFontSizeEditing() {
    showDialog(
      context: _context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Color(Default.COLOR_GREEN),
          content: Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                InkWell(
                  onTap: () => Settings().increaseFontSize(page: pageView),
                  child: Icon(
                    Icons.add_circle,
                    color: Colors.white,
                    size: SizeConfig.getSafeBlockVerticalBy(7),
                    semanticLabel: 'Increase',
                  ),
                ),
                InkWell(
                  onTap: () => Settings().decreaseFontSize(page: pageView),
                  child: Icon(
                    Icons.remove_circle,
                    color: Colors.white,
                    size: SizeConfig.getSafeBlockVerticalBy(7),
                    semanticLabel: 'Decrease',
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
