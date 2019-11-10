import 'package:skg_hagen/src/common/service/assetClient.dart';
import 'package:skg_hagen/src/legal/model/imprint.dart';
import 'package:skg_hagen/src/legal/model/privacy.dart';

class LegalClient {
  static const String IMPRINT = 'assets/text/imprint.html';
  static const String PRIVACY = 'assets/text/privacy.html';

  Future<Imprint> getImprint(AssetClient assetClient) async {
    final String imprint = await assetClient.loadAsset(IMPRINT);

    return Imprint(imprint: imprint);
  }

  Future<Privacy> getPrivacy(AssetClient assetClient) async {
    final String privacy = await assetClient.loadAsset(PRIVACY);
    return Privacy(privacy: privacy);
  }
}
