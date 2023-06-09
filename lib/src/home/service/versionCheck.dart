import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:package_info/package_info.dart';
import 'package:skg_hagen/src/common/library/globals.dart';

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

    try {
      await remoteConfig.setConfigSettings(RemoteConfigSettings(
        fetchTimeout: const Duration(seconds: 10),
        minimumFetchInterval: Duration.zero,
      ));
      await remoteConfig.fetch();
      await remoteConfig.fetchAndActivate();
      final double newVersion = double.parse(
          remoteConfig.getString(REMOTE_PARAM).trim().replaceAll(".", ""));
      if (newVersion > currentVersion) {
        isVersionOld = true;
      }
    } on FirebaseException catch (exception) {
      FirebaseCrashlytics.instance.log(
        exception.toString(),
      );
    } catch (exception) {
      FirebaseCrashlytics.instance.log(
        exception.toString(),
      );
    }

    return isVersionOld;
  }
}
