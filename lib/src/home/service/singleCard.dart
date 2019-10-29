import 'package:skg_hagen/src/common/service/assetClient.dart';
import 'package:skg_hagen/src/home/model/cardContent.dart';
import 'package:yaml/yaml.dart';

class SingleCard {
  final List<CardContent> _cards = List<CardContent>();
  static const String CONFIG_FILE = 'assets/config/cards.yaml';

  Future<List<CardContent>> getAllCards() async {
    _setCardDetails();
    return _cards;
  }

  void _setCardDetails() async {
    final YamlMap cardConfig = await _loadConfig();

    cardConfig.forEach((dynamic key, dynamic value) {
      final List<String> subtitle = <String>[];
      String img = '', route = '';

      value.forEach((dynamic group, dynamic name) {
        if (name is YamlList) {
          name.forEach((dynamic item) {
            subtitle.add(item.toString().toUpperCase());
          });
        }
        if (name is String && group == 'image') {
          img = name;
        }
        if (name is String && group == 'route') {
          route = name;
        }
      });

      _cards.add(_createNewCard(key, subtitle, "/$route", img));
    });
  }

  Future<YamlMap> _loadConfig() async {
    final String card =
        await AssetClient().loadAsset(CONFIG_FILE);

    final YamlMap cardConfig = loadYaml(card);
    return cardConfig;
  }

  CardContent _createNewCard(
      String title, List<String> subtitle, String routeName,
      [String imagePath]) {
    return CardContent(title, subtitle, routeName, imagePath);
  }
}
