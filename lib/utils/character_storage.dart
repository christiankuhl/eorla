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
      print("Written $name.json");
    }
  }

  static Future<List<Character>> loadCharacters() async {
      final dir = await getApplicationDocumentsDirectory();
      List<Character> characters = [];
      dir.listSync().forEach((file) {
        if (file.path.endsWith(".json")) {          
          try {
            String contents = (file as File).readAsStringSync();
            print("Read $file");
            final character = Character.fromJson(jsonDecode(contents));
            characters.add(character);
          } catch (e) {
            print('Error loading characters: $e');
          }
        }
      });
      print("Loaded $characters");
      return characters;
  }
}
