import 'dart:io';

class FileClientMock {
  static Future<String> loadFromTestResourcePath(String filename) async {
    final File file = File('${_getPath()}/$filename');
    return await file.readAsString();
  }

  static String _getPath() {
    String path = "${Directory.current.path}/test/test_resources";

    if (!Directory(path).existsSync()) {
      path = "${Directory.current.path}/test_resources";
    }

    return path;
  }
}
