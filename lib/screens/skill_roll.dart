import 'package:flutter/material.dart';
import '../widgets/character_card.dart';
import '../models/skill.dart';
import '../models/character.dart';
import '../models/rules.dart';
import '../widgets/widget_helpers.dart';
import 'skill_result.dart';

class RollScreen extends StatefulWidget {
  final Skill skill;
  final Character character;

  const RollScreen({required this.skill, required this.character, super.key});

  @override
  RollScreenState createState() => RollScreenState();
}

class RollScreenState extends State<RollScreen> {
  int modifier = 0;

  void performRoll(int modifier) {
    SkillRoll engine = SkillRoll.from(widget.character, widget.skill);
    RollResult rollResults = engine.roll(modifier);

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => ResultScreen(
          skill: widget.skill,
          stats: engine,
          rollResults: rollResults,
          modifier: modifier,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    SkillRoll stats = SkillRoll.from(widget.character, widget.skill);
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              CharacterCard(),

              skillInfoCard(widget.skill, stats),
              attributesCard(stats),

              Card(
                margin: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                child: Padding(
                  padding: EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      modifierRow(
                        "Modifikator",
                        modifier,
                        () => setState(() {
                          modifier++;
                        }),
                        () => setState(() {
                          modifier--;
                        }),
                      ),
                    ],
                  ),
                ),
              ),

              SizedBox(height: 24),
              ElevatedButton(
                onPressed: () => performRoll(modifier),
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 64, vertical: 16),
                ),
                child: Text('WÜRFELN', style: TextStyle(fontSize: 32)),
              ),

              SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}
