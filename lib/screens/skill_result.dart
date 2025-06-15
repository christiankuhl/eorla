import 'package:flutter/material.dart';
import '../widgets/widget_helpers.dart';
import '../widgets/character_card.dart';
import '../models/skill.dart';
import '../models/rules.dart';

class ResultScreen extends StatelessWidget {
  final Skill skill;
  final SkillRoll stats;
  final SkillRollResult rollResults;
  final int modifier;

  const ResultScreen({
    required this.skill,
    required this.stats,
    required this.rollResults,
    required this.modifier,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
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
              skillInfoCard(skill, stats),
              attributesCard(stats, rollResults: rollResults),

              Card(
                margin: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                child: Padding(
                  padding: EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      modifierRow("Modifikator", modifier, () => (), () => ()),
                    ],
                  ),
                ),
              ),

              // Aggregate Result Card
              Card(
                margin: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                child: Container(
                  padding: EdgeInsets.all(16),
                  width: double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Ergebnis',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(rollResults.text(), style: TextStyle(fontSize: 18)),
                      if (rollResults.addText(skill).isNotEmpty) ...[
                        SizedBox(height: 12),
                        Text(
                          rollResults.addText(skill),
                          style: TextStyle(
                            fontSize: 16,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              ),

              // Action Buttons
              SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () => Navigator.pop(context),
                    child: Text('NOCHMAL WÜRFELN'),
                  ),
                  ElevatedButton(
                    onPressed: () => Navigator.popUntil(
                      context,
                      ModalRoute.withName(Navigator.defaultRouteName),
                    ),
                    child: Text('ZURÜCK'),
                  ),
                ],
              ),
              SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}
