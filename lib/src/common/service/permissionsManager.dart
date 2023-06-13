import 'package:permission_handler/permission_handler.dart';

class PermissionsManager {
  Future<PermissionStatus> status(Permission permission) {
    return permission.status;
  }

  Future<PermissionStatus> request(Permission permission) {
    return permission.request();
  }
}
