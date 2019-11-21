import 'dart:io';

class FileClientMock {
  static Future<String> loadFromTestResourcePath(String filename) async {
    final File file =
        File('${Directory.current.path}/test_resources/$filename');
    return await file.readAsString();
  }
}
