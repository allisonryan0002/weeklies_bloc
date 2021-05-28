import 'dart:io';
import 'package:flutter/services.dart';
import 'package:test/test.dart';
import 'package:weeklies/clients/clients.dart';

void main() {
  group('FileClient', () {
    setUpAll(() async {
      // Create a temporary directory.
      final directory = await Directory.systemTemp.createTemp();

      // Mock out the MethodChannel for the path_provider plugin.
      const MethodChannel('plugins.flutter.io/path_provider')
          .setMockMethodCallHandler((MethodCall methodCall) async {
        // If you're getting the apps documents directory, return the path to the
        // temp directory on the test environment instead.
        if (methodCall.method == 'getApplicationDocumentsDirectory') {
          return directory.path;
        }
        return null;
      });
    });

    test('read....', () {
      //Need to setup FileClient here with directory from above?
    });
    test('write....', () {});
  });
}
