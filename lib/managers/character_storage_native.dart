import 'dart:convert';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:file_picker/file_picker.dart';
import '../models/character.dart';

const String eorlaSaveFileName = "eorlaCharacters.json";

Future<Map<String, dynamic>> getOptolithCharacterData() async {
  FilePickerResult? result = await FilePicker.platform.pickFiles(
    type: FileType.custom,
    allowedExtensions: ['json'],
  );
  Map<String, dynamic> jsonData = {};
  if (result != null && result.files.single.path != null) {
    final file = File(result.files.single.path!);
    final String content = await file.readAsString();
    jsonData = jsonDecode(content);
  }
  return Future(() => jsonData);
}

class CharacterStorage {
  static Future<void> saveCharacters(List<Character> characters) async {
    final dir = await getApplicationDocumentsDirectory();
    String fileName = "${dir.path}/$eorlaSaveFileName";
    var file = File(fileName);
    await file.writeAsString(
      jsonEncode([for (var character in characters) character.toJson()]),
    );
  }

  static Future<List<Character>> loadCharacters() async {
    List<Character> characters = [];
    final dir = await getApplicationDocumentsDirectory();
    String fileName = "${dir.path}/$eorlaSaveFileName";
    var file = File(fileName);
    if (!file.existsSync()) {
      await file.create();
      return characters;
    }
    String contents = await file.readAsString();
    try {
      dynamic charactersRaw = jsonDecode(contents);
      for (var char in charactersRaw) {
        try {
          final character = Character.fromJson(char);
          characters.add(character);
        } catch (e) {
          // Propagate the error somehow
        }
      }
    } catch (e) {
      return characters;
    }
    return characters;
  }
}
