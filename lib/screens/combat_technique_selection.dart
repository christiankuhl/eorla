import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../managers/character_manager.dart';
import '../widgets/character_card.dart';
import '../widgets/weapon_card.dart';
import '../models/weapons.dart';

class CombatTechniqueSelectionScreen extends StatelessWidget {
  const CombatTechniqueSelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final character = Provider.of<CharacterManager>(context).activeCharacter;
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(
              height: 100,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  IconButton(
                    icon: Icon(Icons.arrow_back),
                    onPressed: () => Navigator.of(context).pop(),
                    iconSize: 32,
                  ),
                  Expanded(child: CharacterCard()),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text("Kampftechniken", style: TextStyle(fontSize: 24)),
              ),
            ),
            Expanded(
              child: ListView(
                children:
                    (combatTechniquesByID)
                        .map(
                          (id, ct) => MapEntry(
                            ct,
                            WeaponCard(
                              weaponName: ct.name,
                              onTap: () {
                                Navigator.pop(context, ct);
                              },
                            ),
                          ),
                        )
                        .values
                        .toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
