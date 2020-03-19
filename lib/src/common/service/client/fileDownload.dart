import 'dart:io';

import 'package:dio/dio.dart';
import 'package:file_utils/file_utils.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class FileDownload {
  static const int COMPLETED = 100;
  static int progress = 0;

  Future<bool> hasPermission() async {
    final PermissionHandler permissionHandler = PermissionHandler();
    final PermissionGroup permission = PermissionGroup.storage;
    PermissionStatus checkPermission =
        await permissionHandler.checkPermissionStatus(permission);
    if ((PermissionStatus.denied == checkPermission ||
            PermissionStatus.unknown == checkPermission ||
            PermissionStatus.restricted == checkPermission) &&
        checkPermission != PermissionStatus.neverAskAgain) {
      await permissionHandler
          .requestPermissions(<PermissionGroup>[permission]);
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

  Future<bool> downloadFile(String fileUrl, String filePath) async {
    return await Dio()
            .download(fileUrl, filePath,
                onReceiveProgress: (int receivedBytes, int totalBytes) {
              FileDownload.progress =
                  ((receivedBytes / totalBytes) * 100).toInt();
            })
            .then(
              (Response<dynamic> response) => FileDownload.progress,
            )
            .catchError((dynamic onError) {
              Crashlytics.instance.log(
                onError.error.toString(),
              );
            }) ==
        FileDownload.COMPLETED;
  }
}
