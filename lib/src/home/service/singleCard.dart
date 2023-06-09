import 'package:skg_hagen/src/common/service/client/assetClient.dart';
import 'package:skg_hagen/src/home/dto/cardContent.dart';
import 'package:yaml/yaml.dart';

class SingleCard {
  static const String CONFIG_FILE = 'assets/config/cards.yaml';

  Future<List<CardContent>> getAllCards(AssetClient assetClient) async {
    final String card = await assetClient.loadAsset(CONFIG_FILE);
    final YamlMap cardConfig = loadYaml(card);

    return buildCards(cardConfig);
  }

  List<CardContent> buildCards(YamlMap cardConfig) {
    final List<CardContent> cards = <CardContent>[];

    cardConfig.forEach((dynamic key, dynamic value) {
      final List<String> subtitle = <String>[];
      String img = '', route = '', cardName = '';

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
        if (name is String && group == 'name') {
          cardName = name;
        }
      });

      cards.add(_createNewCard(key, subtitle, "/$route", cardName, img));
    });

    return cards;
  }

  CardContent _createNewCard(
      String title, List<String> subtitle, String routeName, String name,
      [String? imagePath]) {
    return CardContent(title, subtitle, routeName, name, imagePath);
  }
}
