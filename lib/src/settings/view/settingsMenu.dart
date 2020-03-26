import 'package:flutter/material.dart';
import 'package:skg_hagen/src/common/library/globals.dart';
import 'package:skg_hagen/src/common/model/default.dart';
import 'package:skg_hagen/src/common/model/sizeConfig.dart';
import 'package:skg_hagen/src/common/service/client/assetClient.dart';
import 'package:skg_hagen/src/settings/model/settingsList.dart';
import 'package:skg_hagen/src/settings/service/settings.dart';

class SettingsMenu {
  List<SettingsList> choices;

  SettingsMenu() {
    _populateSettingsList();
  }

  Widget getMenu() {
    return PopupMenuButton<dynamic>(
        onSelected: _selected,
        itemBuilder: (BuildContext context) {
          SizeConfig().init(context);
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
    print(choice?.title);
  }
}
