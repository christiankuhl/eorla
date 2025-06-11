import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../managers/character_manager.dart';
import 'dart:convert';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import '../models/character.dart';
import '../utils/character_storage.dart';
import '../screens/character_detail_screen.dart';

class CharacterSelectionScreen extends StatelessWidget {
  const CharacterSelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final manager = Provider.of<CharacterManager>(context);

    return Scaffold(
      appBar: AppBar(title: Text('Choose Character')),
      body: ListView.builder(
        itemCount: manager.characters.length + 1,
        itemBuilder: (context, index) {
          if (index == manager.characters.length) {
            return ListTile(
              leading: CircleAvatar(child: Icon(Icons.upload)),
              title: Text("Import Character"),
              onTap: () {
                importCharacter(context);
              },
            );
          } else {
            final character = manager.characters[index];
            return ListTile(
              leading: CircleAvatar(
                backgroundImage: character.avatar?.image,
                child: character.avatar == null ? Icon(Icons.person) : null,
              ),
              title: Text(character.name),
              onTap: () {
                manager.setActiveCharacter(character);
                Navigator.pop(context);
              },
            );
          }
        },
      ),
    );
  }

  Future<void> importCharacter(BuildContext context) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['json'],
    );

    if (result != null && result.files.single.path != null) {
      final file = File(result.files.single.path!);
      final String content = await file.readAsString();
      final Map<String, dynamic> jsonData = jsonDecode(content);

      try {
        final Character newCharacter = Character.fromJson(jsonData);

        final manager = Provider.of<CharacterManager>(context, listen: false);
        manager.addCharacter(newCharacter);
        await CharacterStorage.saveCharacters(manager.characters);
        manager.setActiveCharacter(newCharacter);
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (_) => CharacterDetailScreen(character: newCharacter),
          ),
        );
      } catch (e) {
        debugPrint('Error importing character: $e');
      }
    }
  }
}
