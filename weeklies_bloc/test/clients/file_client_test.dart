import 'dart:io';
import 'package:file/file.dart' show FileSystem, File;
import 'package:file/memory.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:weeklies/clients/clients.dart';

class MockFileSystem extends Mock implements FileSystem {}

class MockFile extends Mock implements File {}

void main() {
  group('FileClient', () {
    late FileClient client;
    late FileSystem fileSystem;
    late String path;

    setUp(() {
      fileSystem = MemoryFileSystem();
      client = FileClient(dir: Directory(''), fileSystem: fileSystem);
      path = '${client.dir.path}/test.json';
    });
    group('read', () {
      test('reads from file system', () async {
        fileSystem.file(path)..writeAsString('contents');
        expect(await client.read('test.json'), 'contents');
      });

      test('handles error', () async {
        final fileSystem = MockFileSystem();
        final file = MockFile();
        when(() => fileSystem.file(path)).thenReturn(file);
        when(() => file.exists()).thenThrow(Exception());
        final client = FileClient(dir: Directory(''), fileSystem: fileSystem);
        try {
          await client.read('test.json');
          fail("exception not thrown");
        } catch (e) {
          assert(e is Exception);
        }
      });
    });

    test('writes to file system', () async {
      await client.write('test.json', 'contents');
      expect(await fileSystem.file(path).readAsString(), 'contents');
    });
  });
}
