import 'package:flutter/cupertino.dart';
import 'package:skg_hagen/src/common/library/globals.dart';
import 'package:skg_hagen/src/common/service/client/assetClient.dart';
import 'package:skg_hagen/src/settings/dto/settingsList.dart';
import 'package:yaml/yaml.dart';

class Settings {
  static const String CONFIG_FILE = 'assets/config/settings.yaml';

  Future<List<SettingsList>> getList(AssetClient assetClient) async {
    final String list = await assetClient.loadAsset(CONFIG_FILE);
    final YamlMap listConfig = loadYaml(list);
    final List<SettingsList> settingsList = <SettingsList>[];

    listConfig.forEach((dynamic key, dynamic value) {
      value.forEach((dynamic item) {
        if (SettingsList.VALID_SETTINGS.contains(item)) {
          settingsList.add(SettingsList(title: item));
        }
      });
    });

    return settingsList;
  }

  void increaseFontSize({@required dynamic page}) {
    page?.setState(() => appFont.increaseSize());
  }

  void decreaseFontSize({@required dynamic page}) {
    page?.setState(() => appFont.decreaseSize());
  }
}
