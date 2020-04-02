import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:package_info/package_info.dart';

class VersionCheck {
  static const String REMOTE_PARAM = 'force_update_current_version';
  bool updateLater = false;

  VersionCheck._();

  factory VersionCheck() => _instance;

  static final VersionCheck _instance = VersionCheck._();

  Future<bool> isVersionOld() async {
    bool isVersionOld = false;
    final PackageInfo info = await PackageInfo.fromPlatform();
    final double currentVersion =
        double.parse(info.version.trim().replaceAll(".", ""));

    final RemoteConfig remoteConfig = await RemoteConfig.instance;

    try {
      await remoteConfig.fetch(expiration: const Duration(seconds: 0));
      await remoteConfig.activateFetched();
      remoteConfig.getString(REMOTE_PARAM);
      final double newVersion = double.parse(
          remoteConfig.getString(REMOTE_PARAM).trim().replaceAll(".", ""));
      if (newVersion > currentVersion) {
        isVersionOld = true;
      }
    } on FetchThrottledException catch (exception) {
      Crashlytics.instance.log(
        exception.toString(),
      );
    } catch (exception) {
      Crashlytics.instance.log(
        exception.toString(),
      );
    }

    return isVersionOld;
  }
}
