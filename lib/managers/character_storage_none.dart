import '../models/character.dart';

class CharacterStorage {
  static Future<void> saveCharacters(List<Character> characters) async {
    throw UnsupportedError("Unsupported platform");
  }

  static Future<List<Character>> loadCharacters() async {
    throw UnsupportedError("Unsupported platform");
  }

  static Future<List<Character>> deleteCharacter(String name) async {
    throw UnsupportedError("Unsupported platform");
  }
}

Future<Map<String, dynamic>> getOptolithCharacterData() async {
  throw UnsupportedError("Unsupported platform");
}