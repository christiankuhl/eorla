import 'package:flutter/material.dart';
import '../widgets/character_card.dart';
import '../widgets/category_card.dart';
import '../models/skill_groups.dart';
import 'skill_selection_screen.dart';

class SkillGroupSelectionScreen extends StatelessWidget {
  const SkillGroupSelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          CharacterCard(),
          Expanded(
            child: GridView.count(
              crossAxisCount: 2,
              children: skillGroups.keys
                  .map((grp) => SkillGroupCard(
                        skillGroupName: grp.name,
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => SkillSelectionScreen(skillGroup: grp),
                            ),
                          );
                        },
                      ))
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }
}
