import 'package:skg_hagen/src/common/service/client/assetClient.dart';
import 'package:skg_hagen/src/settings/model/settingsList.dart';
import 'package:yaml/yaml.dart';

class Settings {
  static const String CONFIG_FILE = 'assets/config/settings.yaml';

  Future<List<SettingsList>> getList(AssetClient assetClient) async {
    final String list = await assetClient.loadAsset(CONFIG_FILE);
    final YamlMap listConfig = loadYaml(list);

    return buildList(listConfig);
  }

  List<SettingsList> buildList(YamlMap listConfig) {
    final List<SettingsList> settingsList = List<SettingsList>();

    listConfig.forEach((dynamic key, dynamic value) {
      value.forEach((dynamic item) {
        settingsList.add(SettingsList(title: item));
      });
    });

    return settingsList;
  }
}
