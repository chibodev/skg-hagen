import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:skg_hagen/src/common/service/assetClient.dart';
import 'package:skg_hagen/src/home/model/cardContent.dart';
import 'package:skg_hagen/src/home/service/singleCard.dart';

import '../../../mock/fileClientMock.dart';

class MockAssetClient extends Mock implements AssetClient {}

void main() {
  test('SingleCard loads mocked yaml to build its content', () async {
    final String filename = 'cards.yaml';

    final AssetClient assetClient = MockAssetClient();
    final SingleCard subject = SingleCard();

    when(assetClient.loadAsset('assets/config/cards.yaml')).thenAnswer(
        (_) async => FileClientMock.loadFromTestResourcePath(filename));

    final List<CardContent> cards = await subject.getAllCards(assetClient);
    final List<String> subtitle = <String>[
      'GOTTESDIENST',
      'VERANSTALTUNG',
      'EVENTS'
    ];

    expect(cards.first.title, 'termine');
    expect(cards.first.subtitle, subtitle);
    expect(cards.first.custom, 'assets/images/termine.jpg');
    expect(cards.first.routeName, '/appointment');
  });
}
