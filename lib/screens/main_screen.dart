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
    final allItems = [
      ...skillGroups.keys.map(
        (grp) => Opacity(
          opacity: character != null ? 1.0 : 0.5,
          child: SkillGroupCard(
            skillGroup: grp,
            onTap: () {
              if (character != null) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => SkillSelectionScreen(skillGroup: grp),
                  ),
                );
              }
            },
          ),
        ),
      ),
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
    ];

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(
              height: 100,
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
              child: LayoutBuilder(
                builder: (context, constraints) {
                  // Calculate the optimal number of columns
                  const double minItemWidth = 160.0; // Adjust as needed
                  int crossAxisCount = (constraints.maxWidth / minItemWidth).floor();
                  crossAxisCount = crossAxisCount.clamp(1, allItems.length);

                  return GridView.count(
                    crossAxisCount: crossAxisCount,
                    childAspectRatio: 1,
                    children: allItems,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
