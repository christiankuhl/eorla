import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../managers/character_manager.dart';
import '../widgets/widget_helpers.dart';
import '../models/character.dart';
import '../managers/character_storage.dart';
import 'character_detail.dart';

class CharacterSelectionScreen extends StatelessWidget {
  const CharacterSelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final manager = Provider.of<CharacterManager>(context);

    return Scaffold(
      appBar: AppBar(title: Text('Charakter auswählen')),
      body: ListView.builder(
        itemCount: manager.characters.length + 1,
        itemBuilder: (context, index) {
          if (index == manager.characters.length) {
            return ListTile(
              leading: CircleAvatar(child: Icon(Icons.upload)),
              title: Text("Charakter importieren"),
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
              trailing: IconButton(
                icon: Icon(Icons.delete, color: Colors.red),
                onPressed: () async {
                  bool confirmed = await showDeleteConfirmation(
                    context,
                    character.name,
                  );
                  if (confirmed && context.mounted) {
                    final manager = Provider.of<CharacterManager>(
                      context,
                      listen: false,
                    );
                    manager.deleteCharacter(character);
                    await CharacterStorage.deleteCharacter(character.name);
                  }
                },
              ),
              title: Text(character.name),
              onTap: () {
                manager.setActiveCharacter(character);
                Navigator.popUntil(
                  context,
                  ModalRoute.withName(Navigator.defaultRouteName),
                );
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => CharacterDetailScreen(character: character),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }

  Future<void> importCharacter(BuildContext context) async {
    final Map<String, dynamic> jsonData = await getOptolithCharacterData();
    if (jsonData.isEmpty) return;
    try {
      // TODO: Figure out async boundary
      if (context.mounted) {
        showLoadingDialog(context);
        final Character newCharacter = await Future.delayed(
          Duration(milliseconds: 100),
          () => Character.fromJson(jsonData),
        );

        if (context.mounted) {
          final manager = Provider.of<CharacterManager>(context, listen: false);
          manager.addCharacter(newCharacter);
          await CharacterStorage.saveCharacters(manager.characters);
          manager.setActiveCharacter(newCharacter);
          if (context.mounted) {
            Navigator.popUntil(
              context,
              ModalRoute.withName(Navigator.defaultRouteName),
            );
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => CharacterDetailScreen(character: newCharacter),
              ),
            );
          }
        }
      }
    } catch (e) {
      if (context.mounted) {
        Navigator.of(context).pop();
        showErrorDialog(
          context,
          "Importing the character produced the following error:\n$e",
        );
      }
    }
  }
}

Future<void> showLoadingDialog(
  BuildContext context, {
  String message = 'Charakter wird importiert...',
}) {
  return showDialog(
    context: context,
    barrierDismissible: false, // Prevent user from closing it manually
    builder: (BuildContext context) {
      return AlertDialog(
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircularProgressIndicator(),
            SizedBox(height: 16),
            Text(message),
          ],
        ),
      );
    },
  );
}

Future<bool> showDeleteConfirmation(BuildContext context, String name) async {
  return await showDialog<bool>(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Charakter löschen'),
            content: Text('Charakter "$name" wirklich löschen?'),
            actions: [
              TextButton(
                child: Text('Nein'),
                onPressed: () {
                  Navigator.of(context).pop(false);
                },
              ),
              TextButton(
                child: Text('Ja', style: TextStyle(color: Colors.red)),
                onPressed: () {
                  Navigator.of(context).pop(true);
                },
              ),
            ],
          );
        },
      ) ??
      false; // In case user dismisses dialog → treat as Cancel
}
