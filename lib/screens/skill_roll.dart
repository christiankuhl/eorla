import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../widgets/character_card.dart';
import '../models/character.dart';
import '../models/rules.dart';
import '../widgets/widget_helpers.dart';
import '../managers/settings.dart';
import 'dice_rolls.dart';
import 'skill_result.dart';

class RollScreen<T extends Trial> extends StatefulWidget {
  final T skillOrSpell;
  final Character character;

  const RollScreen({
    required this.skillOrSpell,
    required this.character,
    super.key,
  });

  @override
  RollScreenState createState() => RollScreenState();
}

class RollScreenState extends State<RollScreen> {
  int modifier = 0;

  void performRoll(int modifier) {
    SkillRoll engine = SkillRoll.from(widget.character, widget.skillOrSpell, modifier);
    SkillRollResult rollResults = engine.roll();

    fadeDice(
      context,
      ResultScreen(
        skillOrSpell: widget.skillOrSpell,
        stats: engine,
        rollResults: rollResults,
        modifier: modifier,
      ),
      DiceAnimation.d20,
    );
  }

  @override
  Widget build(BuildContext context) {
    SkillRoll stats = SkillRoll.from(widget.character, widget.skillOrSpell, modifier);
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
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
                    Expanded(child: CharacterCard()),
                  ],
                ),
              ),

              skillInfoCard(widget.skillOrSpell, stats, Provider.of<AppSettings>(context).nerdMode),
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
