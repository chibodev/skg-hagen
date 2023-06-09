import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:skg_hagen/src/common/service/permissionsManager.dart';
import 'package:skg_hagen/src/kindergarten/service/fileDownload.dart';

class MockPermissionHandler extends Mock implements PermissionsManager {
  @override
  Future<PermissionStatus> request(Permission? permission) {
    return super.noSuchMethod(
        Invocation.method(#request, <Permission?>[permission]),
        returnValue:
            Future<PermissionStatus>.value(PermissionStatus.restricted));
  }
}

void main() {
  late FileDownload subject;
  late MockPermissionHandler mockPermissionHandler;
  final Permission permissionStorage = Permission.storage;

  setUpAll(() {
    subject = FileDownload();
    mockPermissionHandler = MockPermissionHandler();
  });

  test('Permission test', () async {
    when(mockPermissionHandler.request(permissionStorage))
        .thenAnswer((_) async => PermissionStatus.granted);
    final bool granted = await subject.hasPermission(mockPermissionHandler);
    reset(mockPermissionHandler);

    when(mockPermissionHandler.request(permissionStorage))
        .thenAnswer((_) async => PermissionStatus.denied);
    final bool denied = await subject.hasPermission(mockPermissionHandler);
    reset(mockPermissionHandler);

    when(mockPermissionHandler.request(permissionStorage))
        .thenAnswer((_) async => PermissionStatus.limited);
    final bool limited = await subject.hasPermission(mockPermissionHandler);
    reset(mockPermissionHandler);

    when(mockPermissionHandler.request(permissionStorage))
        .thenAnswer((_) async => PermissionStatus.restricted);
    final bool restricted = await subject.hasPermission(mockPermissionHandler);
    reset(mockPermissionHandler);

    when(mockPermissionHandler.request(permissionStorage))
        .thenAnswer((_) async => PermissionStatus.provisional);
    final bool provisional = await subject.hasPermission(mockPermissionHandler);

    when(mockPermissionHandler.request(permissionStorage))
        .thenAnswer((_) async => PermissionStatus.permanentlyDenied);
    final bool permanentlyDenied =
        await subject.hasPermission(mockPermissionHandler);

    expect(true, granted);
    expect(false, denied);
    expect(false, limited);
    expect(false, restricted);
    expect(false, provisional);
    expect(false, permanentlyDenied);
  });
}
