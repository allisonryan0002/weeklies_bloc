import 'dart:async';
import 'package:file/file.dart' hide Directory;
import 'dart:io' show Directory;

class FileClient {
  final Directory dir;
  final FileSystem fileSystem;

  FileClient({required this.dir, required this.fileSystem});

  Future<String> read(String filename) async {
    final file = fileSystem.file('${dir.path}/$filename');
    if (!await file.exists()) {
      await file.create();
    }
    return await file.readAsString();
  }

  Future<File> write(String filename, String contents) async {
    final file = fileSystem.file('${dir.path}/$filename');
    if (!await file.exists()) {
      await file.create();
    }
    return file.writeAsString(contents);
  }
}
