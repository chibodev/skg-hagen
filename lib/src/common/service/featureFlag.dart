import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:skg_hagen/src/common/library/globals.dart';

class FeatureFlag {
  static const String KIRCHENJAHR = 'kirchenjahr';

  FeatureFlag._();

  factory FeatureFlag() => _instance;

  static final FeatureFlag _instance = FeatureFlag._();

  Future<bool> isEnabled(String featureName) async {
    bool isEnabled = false;
    try {
      await remoteConfig.setConfigSettings(RemoteConfigSettings(
        fetchTimeout: const Duration(seconds: 10),
        minimumFetchInterval: Duration.zero,
      ));
      await remoteConfig.fetch();
      await remoteConfig.fetchAndActivate();
      isEnabled = remoteConfig.getString(featureName) == '1' ? true : false;
    } on FirebaseException catch (exception) {
      FirebaseCrashlytics.instance.log(
        exception.toString(),
      );
    } catch (exception) {
      FirebaseCrashlytics.instance.log(
        exception.toString(),
      );
    }

    return isEnabled;
  }
}
