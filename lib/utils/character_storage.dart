import 'dart:convert';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import '../models/character.dart';

class CharacterStorage {
  static Future<void> saveCharacters(List<Character> characters) async {
    final dir = await getApplicationDocumentsDirectory();
    String path = dir.path;
    for (var character in characters) {
      String name = character.name;
      String fileName = "$path/$name.json";
      var file = File(fileName);
      await file.writeAsString(jsonEncode(character.toJson()));
    }
  }

  static Future<void> deleteCharacter(String characterName) async {
    final dir = await getApplicationDocumentsDirectory();
    String path = dir.path;
    String fileName = "$path/$characterName.json";
    var file = File(fileName);
    await file.delete();
  }

  static Future<List<Character>> loadCharacters() async {
    final dir = await getApplicationDocumentsDirectory();
    List<Character> characters = [];
    dir.listSync().forEach((file) {
      if (file.path.endsWith(".json")) {
        try {
          String contents = (file as File).readAsStringSync();
          final character = Character.fromJson(jsonDecode(contents));
          characters.add(character);
        } catch (e) {
          // TODO: Figure out a better way to do this - i.e. avoid stray corrupted json files in the application directory
        }
      }
    });
    return characters;
  }
}
