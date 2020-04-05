import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:skg_hagen/src/common/service/client/assetClient.dart';
import 'package:skg_hagen/src/legal/dto/imprint.dart';
import 'package:skg_hagen/src/legal/dto/privacy.dart';
import 'package:skg_hagen/src/legal/repository/legalClient.dart';

import '../../mock/fileClientMock.dart';

class MockAssetClient extends Mock implements AssetClient {}

void main() {
  test('LegalClient successfully retrieves imprint', () async {
    final String filename = 'imprint.html';

    final AssetClient assetClient = MockAssetClient();
    final LegalClient subject = LegalClient();

    when(assetClient.loadAsset('assets/text/imprint.html')).thenAnswer(
        (_) async => FileClientMock.loadFromTestResourcePath(filename));

    final Imprint imprint = await subject.getImprint(assetClient);

    expect(
        imprint.imprint.contains(
            'des öffentlichen Rechts. Sie wird vertreten durch die Vorsitzende'),
        true);
  });

  test('LegalClient successfully retrieves privacy', () async {
    final String filename = 'privacy.html';

    final AssetClient assetClient = MockAssetClient();
    final LegalClient subject = LegalClient();

    when(assetClient.loadAsset('assets/text/privacy.html')).thenAnswer(
        (_) async => FileClientMock.loadFromTestResourcePath(filename));

    final Privacy privacy = await subject.getPrivacy(assetClient);

    expect(
        privacy.privacy.contains(
            'Mit der folgenden Datenschutzerklärung möchten wir Sie darüber aufklären, welche Arten Ihrer personenbezogenen Daten'),
        true);
  });
}
