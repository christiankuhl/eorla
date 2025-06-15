import 'package:eorla/screens/weapon_selection.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:material_symbols_icons/symbols.dart';
import '../widgets/widget_helpers.dart';
import '../widgets/character_card.dart';
import '../widgets/skill_group_card.dart';
import '../models/skill_groups.dart';
import '../managers/character_manager.dart';
import 'skill_selection.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

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
                  SizedBox(
                    width: 48,
                    height: 48,
                    child: Icon(Icons.home, size: 32), 
                  ),
                  Expanded(
                    child: CharacterCard(),
                  ),
                ],
              ),
            ),
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                children:
                    skillGroups.keys
                        .map(
                          (grp) => Opacity(
                            opacity: character != null ? 1.0 : 0.5,
                            child: SkillGroupCard(
                              skillGroup: grp,
                              onTap: () {
                                if (character != null) {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) =>
                                          SkillSelectionScreen(skillGroup: grp),
                                    ),
                                  );
                                }
                              },
                            ),
                          ),
                        )
                        .toList() +
                    [
                      Opacity(
                        opacity: character != null ? 1.0 : 0.5,
                        child: mainScreenPanel("Kampf", Symbols.swords, () {
                          if (character != null) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => WeaponSelectionScreen(),
                              ),
                            );
                          }
                        }),
                      ),
                    ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
