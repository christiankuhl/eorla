import 'dart:math';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:material_symbols_icons/symbols.dart';
import '../widgets/widget_helpers.dart';
import '../widgets/character_card.dart';
import '../widgets/skill_group_card.dart';
import '../models/skill_groups.dart';
import '../managers/character_manager.dart';
import 'skill_selection.dart';
import 'combat.dart';

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
                builder: (_) => CombatScreen(character: character),
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
                  Expanded(child: CharacterCard()),
                ],
              ),
            ),
            Expanded(
              child: LayoutBuilder(
                builder: (context, constraints) {
                  // Calculate the optimal number of columns
                  const double minItemWidth = 160.0;
                  const double maxItemWidth = 500.0;

                  int crossAxisCount = 1;
                  crossAxisCount = sqrt(
                    constraints.maxWidth *
                        allItems.length /
                        constraints.maxHeight,
                  ).ceil();
                  crossAxisCount = crossAxisCount.clamp(1, allItems.length);

                  double itemWidth = constraints.maxWidth / crossAxisCount;
                  if ((allItems.length / crossAxisCount).ceil() >
                      constraints.maxHeight / itemWidth) {
                    // If the number of items per row exceeds the height, increase the number of columns
                    int numberOfRows =
                        (allItems.length / crossAxisCount).ceil();
                    numberOfRows = numberOfRows.clamp(
                      1,
                      (constraints.maxHeight / itemWidth).ceil() + 1, // Allow for one item of slack. We are in a scroll view, after all
                    );
                    itemWidth =
                        constraints.maxWidth /
                        (allItems.length / numberOfRows).ceil();
                  }
                  if (itemWidth < minItemWidth) {
                    // If the optimal width is less than the minimum, use 1 column
                    crossAxisCount -= 1;
                    itemWidth = constraints.maxWidth / crossAxisCount;
                  } else if (itemWidth > maxItemWidth) {
                    // If the optimal width is greater than the maximum, use all items in one row
                    crossAxisCount = allItems.length;
                    itemWidth = constraints.maxWidth / crossAxisCount;
                  }

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
