import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../widgets/character_card.dart';
import '../widgets/skill_group_card.dart';
import '../models/skill_groups.dart';
import '../managers/character_manager.dart';
import 'skill_selection_screen.dart';

class SkillGroupSelectionScreen extends StatelessWidget {
  const SkillGroupSelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final character = Provider.of<CharacterManager>(context).activeCharacter;
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            CharacterCard(),
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                children: skillGroups.keys
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
                    .toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
