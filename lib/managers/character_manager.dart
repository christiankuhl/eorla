import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'dart:io';
import 'dart:convert';
import '../models/character.dart';
import 'character_storage.dart';

class CharacterManager extends ChangeNotifier {
  List<Character> characters = [];

  Character? _activeCharacter;

  CharacterManager({required this.characters}) {
    if (characters.isNotEmpty) {
      _activeCharacter = characters.first;
    }
  }

  void addCharacter(Character character) {
    characters.add(character);
  }

  Future<void> saveCharacters() async {
    await CharacterStorage.saveCharacters(characters);
    notifyListeners();
  }

  void deleteCharacter(Character character) async {
    characters.remove(character);

    if (_activeCharacter == character) {
      _activeCharacter = characters.isNotEmpty ? characters.first : null;
    }
    await saveCharacters();
  }

  Character? get activeCharacter => _activeCharacter;

  void setActiveCharacter(Character character) {
    _activeCharacter = character;
    notifyListeners();
  }

  Future<void> shareCharacterJson() async {
    if (_activeCharacter == null) {
      return;
    }
    try {
      final jsonString = jsonEncode(_activeCharacter!.toJson());
      final String fileName = "${_activeCharacter!.name}.json";
      final dir = await getTemporaryDirectory();
      final file = File('${dir.path}/$fileName');
      await file.writeAsString(jsonString);

      await SharePlus.instance.share(
        ShareParams(
          text: "Export '$fileName'",
          subject: "Charakter-Export",
          files: [XFile(file.path)],
        ),
      );
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
