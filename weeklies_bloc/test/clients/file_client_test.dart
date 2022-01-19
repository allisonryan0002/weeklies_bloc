import 'dart:io';
import 'package:file/file.dart' show FileSystem, File;
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
    late File file;

    setUp(() {
      fileSystem = MockFileSystem();
      file = MockFile();
      client = FileClient(dir: Directory(''), fileSystem: fileSystem);
      path = '${client.dir.path}/test.json';
      when(() => fileSystem.file(path)).thenReturn(file);
      when(file.exists).thenAnswer((_) async => true);
      when(() => file.create()).thenAnswer((_) async => file);
    });

    group('read', () {
      const fileContents = 'test';

      setUp(() {
        when(() => file.readAsString()).thenAnswer((_) async => fileContents);
      });

      test('reads from file system', () async {
        expect(await client.read('test.json'), fileContents);
      });

      test('creates new file when file does not exist and reads from file',
          () async {
        when(file.exists).thenAnswer((_) async => false);

        expect(await client.read('test.json'), fileContents);
        verify(() => file.create()).called(1);
      });
    });

    group('write', () {
      const contentToWrite = 'test';

      setUp(() {
        when(() => file.writeAsString(contentToWrite))
            .thenAnswer((_) async => file);
      });
      test('writes to file system', () async {
        await client.write('test.json', contentToWrite);
        verify(() => file.writeAsString(contentToWrite)).called(1);
      });

      test('creates new file when file does not exist and writes to file',
          () async {
        when(file.exists).thenAnswer((_) async => false);

        await client.write('test.json', contentToWrite);
        verify(() => file.create()).called(1);
        verify(() => file.writeAsString(contentToWrite)).called(1);
      });
    });
  });
}
