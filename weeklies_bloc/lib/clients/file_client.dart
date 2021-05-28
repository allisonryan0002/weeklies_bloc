import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'dart:async';

class FileClient {
  static late Future<FileClient> instance = _initialize();
  final Directory dir;

  static Future<FileClient> _initialize() async {
    print("Initialized");
    final dir = await getApplicationDocumentsDirectory();
    return FileClient._(dir);
  }

  FileClient._(this.dir);

  Future<String> read(String filename) async {
    final dir = await getApplicationDocumentsDirectory();
    final file = File('${dir.path}/$filename');
    if (!await file.exists()) {
      await file.create();
    }
    print('Read file');
    return await file.readAsString();
  }

  Future<File> write(String filename, String contents) async {
    final dir = await getApplicationDocumentsDirectory();
    final file = File('${dir.path}/$filename');
    if (!await file.exists()) {
      await file.create();
    }
    print('Wrote to file');
    return file.writeAsString(contents);
  }
}
