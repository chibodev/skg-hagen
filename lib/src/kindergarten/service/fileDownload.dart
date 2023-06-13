import 'dart:io';

import 'package:file_utils/file_utils.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:skg_hagen/src/common/service/permissionsManager.dart';

class FileDownload {
  Future<bool> hasPermission(PermissionsManager permissionHandler) async {
    final PermissionStatus checkPermission =
        await permissionHandler.request(Permission.storage);
    return checkPermission == PermissionStatus.granted;
  }

  Future<String> getSaveDirectory() async {
    String? saveDir = "";

    saveDir = Platform.isAndroid
        ? (await getExternalStorageDirectory())?.path
        : (await getApplicationDocumentsDirectory()).path;

    if (saveDir != null && !Directory(saveDir).existsSync()) {
      FileUtils.mkdir(<String>[saveDir]);
    }

    return saveDir ?? "";
  }
}
