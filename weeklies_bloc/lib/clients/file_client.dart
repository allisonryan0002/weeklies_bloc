import 'dart:async';
import 'dart:io' show Directory;

import 'package:file/file.dart' hide Directory;

class FileClient {
  FileClient({required this.dir, required this.fileSystem});

  final Directory dir;
  final FileSystem fileSystem;

  Future<String> read(String filename) async {
    final file = fileSystem.file('${dir.path}/$filename');
    if (!await file.exists()) {
      await file.create();
    }
    return file.readAsString();
  }

  Future<File> write(String filename, String contents) async {
    final file = fileSystem.file('${dir.path}/$filename');
    if (!await file.exists()) {
      await file.create();
    }
    return file.writeAsString(contents);
  }
}
