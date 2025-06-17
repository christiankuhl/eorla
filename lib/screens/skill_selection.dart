import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../managers/character_manager.dart';
import '../widgets/character_card.dart';
import '../widgets/plain_card.dart';
import '../models/skill_groups.dart';
import '../models/skill.dart';
import 'skill_roll.dart';

class SkillSelectionScreen extends StatelessWidget {
  final SkillGroup skillGroup;

  const SkillSelectionScreen({required this.skillGroup, super.key});

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
                child: Text(skillGroup.name, style: TextStyle(fontSize: 24)),
              ),
            ),
            Expanded(
              child: ListView(
                children: (skillGroups[skillGroup] ?? [])
                    .map(
                      (skill) => PlainCard(
                        itemName: skill.name,
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => RollScreen(
                                skillOrSpell: SkillWrapper(skill),
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
