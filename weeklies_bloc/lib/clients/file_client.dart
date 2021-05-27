import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'dart:async';

class FileClient {
  static late Future<FileClient> instance = _initialize();

  static Future<FileClient> _initialize() async {
    return FileClient._(basePath: await getApplicationDocumentsDirectory());
  }

  FileClient._({required this.basePath});

  /// Base path where files are stored.
  final Directory basePath;

  Future<String> read(String filename) async {
    final file = File('${basePath.path}/$filename');
    return await file.readAsString();
  }

  Future<File> write(String filename, String contents) async {
    final file = File('${basePath.path}/$filename');
    return file.writeAsString(contents);
  }
}
