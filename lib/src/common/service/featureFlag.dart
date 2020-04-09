import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';

class FeatureFlag {
  static const String KIRCHENJAHR = 'kirchenjahr';

  FeatureFlag._();

  factory FeatureFlag() => _instance;

  static final FeatureFlag _instance = FeatureFlag._();

  Future<bool> isEnabled(String featureName) async {
    final RemoteConfig remoteConfig = await RemoteConfig.instance;
    bool isEnabled = false;
    try {
      await remoteConfig.fetch(expiration: const Duration(seconds: 0));
      await remoteConfig.activateFetched();
      isEnabled = remoteConfig.getString(featureName) == '1' ? true : false;
    } on FetchThrottledException catch (exception) {
      Crashlytics.instance.log(
        exception.toString(),
      );
    } catch (exception) {
      Crashlytics.instance.log(
        exception.toString(),
      );
    }

    return isEnabled;
  }
}
