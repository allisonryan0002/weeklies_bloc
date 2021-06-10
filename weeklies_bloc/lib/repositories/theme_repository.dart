import 'dart:async';
import 'dart:convert';
import 'package:weeklies/models/models.dart';
import 'package:weeklies/clients/clients.dart';

class ThemeRepository {
  // [FileClient] provides access to local storage
  FileClient client;

  ThemeRepository({required this.client});

  // Read theme file contents & convert from json
  Future<ColorThemeOption> loadTheme() async {
    final fileContents = await client.read('myTheme.json');
    if (fileContents.isEmpty) {
      saveTheme(ColorThemeOption.theme1);
      return ColorThemeOption.theme1;
    }

    final jsonContent = JsonDecoder().convert(fileContents);
    return (ColorThemeOptionExtension.fromJson(jsonContent['theme']));
  }

  // Convert [ColorThemeOption] to json & write to theme file
  void saveTheme(ColorThemeOption theme) async {
    final contents = JsonEncoder().convert({'theme': theme.toJson()});
    client.write('myTheme.json', contents);
  }
}
