import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../managers/character_manager.dart';
import '../screens/character_detail.dart';
import '../screens/character_selection.dart';

class CharacterCard extends StatelessWidget {
  const CharacterCard({super.key});

  @override
  Widget build(BuildContext context) {
    final character = Provider.of<CharacterManager>(context).activeCharacter;

    if (character == null) {
      return GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => CharacterSelectionScreen()),
          );
        },
        child: Card(
          margin: EdgeInsets.all(8),
          child: Container(
            padding: EdgeInsets.all(16),
            child: Text('No character selected'),
          ),
        ),
      );
    }

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => CharacterDetailScreen(character: character),
          ),
        );
      },
      child: Card(
        margin: EdgeInsets.all(8),
        child: Row(
          children: [
            Expanded(
              child: Center(
                child: Text(character.name, style: TextStyle(fontSize: 18)),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CircleAvatar(
                backgroundImage: character.avatar?.image,
                radius: 30,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
