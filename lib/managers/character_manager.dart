import 'package:flutter/material.dart';
import '../models/character.dart';

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

  Character? get activeCharacter => _activeCharacter;

  void setActiveCharacter(Character character) {
    _activeCharacter = character;
    notifyListeners();
  }
}
