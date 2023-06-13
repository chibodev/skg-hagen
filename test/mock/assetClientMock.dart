import 'dart:async';

import 'package:mockito/mockito.dart';
import 'package:skg_hagen/src/common/service/client/assetClient.dart';

class MockAssetClient extends Mock implements AssetClient {
  @override
  Future<String> loadAsset(String? path) {
    return super.noSuchMethod(Invocation.method(#loadAsset, <String?>[path]),
        returnValue: Future<String>.value(''));
  }
}
