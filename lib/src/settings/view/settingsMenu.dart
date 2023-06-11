import 'package:flutter/material.dart';
import 'package:skg_hagen/src/common/dto/default.dart';
import 'package:skg_hagen/src/common/dto/sizeConfig.dart';
import 'package:skg_hagen/src/common/library/globals.dart';
import 'package:skg_hagen/src/common/service/client/assetClient.dart';
import 'package:skg_hagen/src/settings/dto/settingsList.dart';
import 'package:skg_hagen/src/settings/service/settings.dart';

class SettingsMenu {
  late List<SettingsList> choices;
  dynamic pageView;
  late BuildContext _context;

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
                Default.capitalize(choice.title),
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
          content: StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              Color increaseIconColor = _getIncreaseIconColor();
              Color decreaseIconColor = _getDecreaseIconColor();
              return Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    InkWell(
                      onTap: () {
                        if (!appFont.isIncreaseMaximumReached())
                          Settings().increaseFontSize(page: pageView);
                        setState(
                            () => increaseIconColor = _getIncreaseIconColor());
                      },
                      child: Icon(
                        Icons.add_circle,
                        color: increaseIconColor,
                        size: SizeConfig.getSafeBlockVerticalBy(7),
                        semanticLabel: 'Increase',
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        if (!appFont.isDecreaseMinimumReached())
                          Settings().decreaseFontSize(page: pageView);
                        setState(
                            () => decreaseIconColor = _getDecreaseIconColor());
                      },
                      child: Icon(
                        Icons.remove_circle,
                        color: decreaseIconColor,
                        size: SizeConfig.getSafeBlockVerticalBy(7),
                        semanticLabel: 'Decrease',
                      ),
                    )
                  ],
                ),
              );
            },
          ),
        );
      },
    );
  }

  Color _getIncreaseIconColor() =>
      appFont.isIncreaseMaximumReached() ? Colors.white38 : Colors.white;

  Color _getDecreaseIconColor() =>
      appFont.isDecreaseMinimumReached() ? Colors.white38 : Colors.white;
}
