import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:skg_hagen/src/kindergarten/service/fileDownload.dart';

class MockPermissionHandler extends Mock implements PermissionHandler {}

void main() {
  FileDownload subject;
  MockPermissionHandler mockPermissionHandler;
  final PermissionGroup permission = PermissionGroup.storage;

  setUpAll(() {
    subject = FileDownload();
    mockPermissionHandler = MockPermissionHandler();
  });

  test('Permission test', () async {
    when(mockPermissionHandler.checkPermissionStatus(permission))
        .thenAnswer((_) async => PermissionStatus.granted);
    expect(true, await subject.hasPermission(mockPermissionHandler));
    final bool granted = await subject.hasPermission(mockPermissionHandler);
    reset(mockPermissionHandler);

    when(mockPermissionHandler.checkPermissionStatus(permission))
        .thenAnswer((_) async => PermissionStatus.denied);
    final bool denied = await subject.hasPermission(mockPermissionHandler);
    reset(mockPermissionHandler);

    when(mockPermissionHandler.checkPermissionStatus(permission))
        .thenAnswer((_) async => PermissionStatus.denied);
    final bool unknown = await subject.hasPermission(mockPermissionHandler);
    reset(mockPermissionHandler);

    when(mockPermissionHandler.checkPermissionStatus(permission))
        .thenAnswer((_) async => PermissionStatus.denied);
    final bool restricted = await subject.hasPermission(mockPermissionHandler);
    reset(mockPermissionHandler);

    when(mockPermissionHandler.checkPermissionStatus(permission))
        .thenAnswer((_) async => PermissionStatus.denied);
    final bool neverAskAgain = await subject.hasPermission(mockPermissionHandler);

    expect(true, granted);
    expect(false, denied);
    expect(false, unknown);
    expect(false, restricted);
    expect(false, neverAskAgain);
  });
}
