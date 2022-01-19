import 'dart:async';
import 'dart:convert';

import 'package:weeklies/clients/clients.dart';
import 'package:weeklies/models/models.dart';

class ThemeRepository {
  ThemeRepository({required this.client});

  // [FileClient] provides access to local storage
  FileClient client;

  // Read theme file contents & convert from json
  Future<ColorThemeOption> loadTheme() async {
    final fileContents = await client.read('myTheme.json');
    if (fileContents.isEmpty) {
      saveTheme(ColorThemeOption.theme1);
      return ColorThemeOption.theme1;
    }

    final jsonContent =
        const JsonDecoder().convert(fileContents) as Map<String, String>;
    return ColorThemeOptionExtension.fromJson(jsonContent['theme']!);
  }

  // Convert [ColorThemeOption] to json & write to theme file
  // ignore: avoid_void_async
  void saveTheme(ColorThemeOption theme) async {
    final contents = const JsonEncoder().convert({'theme': theme.toJson()});
    await client.write('myTheme.json', contents);
  }
}
