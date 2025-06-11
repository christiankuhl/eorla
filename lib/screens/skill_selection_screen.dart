import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../managers/character_manager.dart';
import '../widgets/character_card.dart';
import '../widgets/skill_card.dart';
import '../models/skill_groups.dart';
import 'roll_screen.dart';

class SkillSelectionScreen extends StatelessWidget {
  final SkillGroup skillGroup;

  const SkillSelectionScreen({required this.skillGroup, super.key});

  @override
  Widget build(BuildContext context) {
    final character = Provider.of<CharacterManager>(context).activeCharacter;
    return Scaffold(
      body: Column(
        children: [
          CharacterCard(),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(skillGroup.name, style: TextStyle(fontSize: 24)),
            ),
          ),
          Expanded(
            child: ListView(
              children: (skillGroups[skillGroup] ?? [])
                  .map(
                    (skill) => SkillCard(
                      skillName: skill.name,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) =>
                                RollScreen(skill: skill, character: character!),
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
    );
  }
}
