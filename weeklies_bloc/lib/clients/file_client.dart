import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'dart:async';

class FileClient {
  // static Future<FileClient> instance = _initialize();
  // final Directory dir;

  // static Future<FileClient> _initialize() async {
  //   print("Initialized");
  //   final dir = await getApplicationDocumentsDirectory();
  //   return FileClient._(dir);
  // }

  // FileClient._(this.dir);

  //Made static and added top line

  static Future<String> read(String filename) async {
    final dir = await getApplicationDocumentsDirectory();
    final file = File('${dir.path}/$filename');
    return await file.readAsString();
  }

  static Future<File> write(String filename, String contents) async {
    final dir = await getApplicationDocumentsDirectory();
    final file = File('${dir.path}/$filename');
    return file.writeAsString(contents);
  }
}
