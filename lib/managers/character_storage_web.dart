import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:file_picker/file_picker.dart';
import '../models/character.dart';

Future<Map<String, dynamic>> getOptolithCharacterData() async {
  FilePickerResult? result = await FilePicker.platform.pickFiles(
    type: FileType.custom,
    allowedExtensions: ['json'],
  );

  if (result != null && result.files.single.bytes != null) {
    final content = utf8.decode(result.files.single.bytes!);
    final jsonData = jsonDecode(content);
    return jsonData;
  }

  return {};
}

class CharacterStorage {
  static const String _charactersKey = 'eorla_saved_characters';

  static Future<void> saveCharacters(List<Character> characters) async {
    final prefs = await SharedPreferences.getInstance();
    final jsonList = characters.map((c) => c.toJson()).toList();
    await prefs.setString(_charactersKey, jsonEncode(jsonList));
  }

  static Future<List<Character>> loadCharacters() async {
    final prefs = await SharedPreferences.getInstance();
    final data = prefs.getString(_charactersKey);

    if (data != null) {
      try {
        final List<dynamic> jsonList = jsonDecode(data);
        return jsonList.map((e) => Character.fromJson(e)).toList();
      } catch (e) {
        // Could log or clear corrupted data
      }
    }

    return [];
  }
}
