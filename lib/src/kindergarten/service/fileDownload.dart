import 'dart:io';

import 'package:file_utils/file_utils.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class FileDownload {
  Future<bool> hasPermission(PermissionHandler permissionHandler) async {
    final PermissionGroup permission = PermissionGroup.storage;

    PermissionStatus checkPermission =
        await permissionHandler.checkPermissionStatus(permission);
    if ((PermissionStatus.denied == checkPermission ||
            PermissionStatus.unknown == checkPermission ||
            PermissionStatus.restricted == checkPermission) &&
        checkPermission != PermissionStatus.neverAskAgain) {
      await permissionHandler.requestPermissions(<PermissionGroup>[permission]);
      checkPermission =
          await permissionHandler.checkPermissionStatus(permission);
    }

    return checkPermission == PermissionStatus.granted;
  }

  Future<String> getSaveDirectory() async {
    String saveDir = "";

    saveDir = Platform.isAndroid
        ? (await getExternalStorageDirectory()).path
        : (await getApplicationDocumentsDirectory()).path;

    if (!Directory(saveDir).existsSync()) {
      FileUtils.mkdir(<String>[saveDir]);
    }

    return saveDir;
  }
}
