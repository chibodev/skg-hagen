import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:skg_hagen/src/common/service/client/assetClient.dart';
import 'package:skg_hagen/src/settings/model/settingsList.dart';
import 'package:skg_hagen/src/settings/service/settings.dart';

import '../../../mock/fileClientMock.dart';

class MockAssetClient extends Mock implements AssetClient {}

void main() {
  test('Settings loads mocked yaml to build its content', () async {
    final String filename = 'settings.yaml';

    final AssetClient assetClient = MockAssetClient();
    final Settings subject = Settings();

    when(assetClient.loadAsset('assets/config/settings.yaml')).thenAnswer(
        (_) async => FileClientMock.loadFromTestResourcePath(filename));

    final List<SettingsList> settings = await subject.getList(assetClient);

    expect(settings.length, 1);
    expect(settings.first.title, 'schriftgröße');
  });
}
