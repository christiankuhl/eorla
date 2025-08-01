import 'package:flutter/material.dart';
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

  void deleteCharacter(Character character) async {
    characters.remove(character);

    if (_activeCharacter == character) {
      _activeCharacter = characters.isNotEmpty ? characters.first : null;
    }
    await CharacterStorage.saveCharacters(characters);
    notifyListeners();
  }

  Character? get activeCharacter => _activeCharacter;

  void setActiveCharacter(Character character) {
    _activeCharacter = character;
    notifyListeners();
  }
}
