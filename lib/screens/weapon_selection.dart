import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../managers/character_manager.dart';
import '../widgets/character_card.dart';
import '../widgets/weapon_card.dart';
import 'combat.dart';

class WeaponSelectionScreen extends StatelessWidget {

  const WeaponSelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final character = Provider.of<CharacterManager>(context).activeCharacter;
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(
              height: 100, // Adjust as needed for your CharacterCard
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  IconButton(
                    icon: Icon(Icons.arrow_back),
                    onPressed: () => Navigator.of(context).pop(),
                    iconSize: 32,
                  ),
                  Expanded(
                    child: CharacterCard(),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text("Waffen", style: TextStyle(fontSize: 24)),
              ),
            ),
            Expanded(
              child: ListView(
                children: (character?.weapons ?? [])
                    .map(
                      (weapon) => WeaponCard(
                        weaponName: weapon.name,
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => CombatScreen(
                                weapon: weapon,
                                character: character!,
                              ),
                            ),
                          );
                        },
                      ),
                    )
                    .toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
