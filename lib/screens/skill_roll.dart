import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../widgets/character_card.dart';
import '../widgets/widget_helpers.dart';
import '../managers/settings.dart';
import '../managers/character_manager.dart';
import '../models/rules.dart';
import '../models/character.dart';
import '../models/skill.dart';
import 'dice_rolls.dart';

class RollScreen<T extends Trial> extends StatefulWidget {
  final T skillOrSpell;

  const RollScreen({required this.skillOrSpell, super.key});

  @override
  RollScreenState createState() => RollScreenState();
}

class RollScreenState extends State<RollScreen> {
  int modifier = 0;

  void performRoll(
    Character character,
    int modifier, {
    bool useAnimations = true,
  }) async {
    SkillRoll engine = SkillRoll.from(character, widget.skillOrSpell, modifier);
    SkillRollResult rollResults = engine.roll();

    List<AttributeRollResult> results = rollResults.rolls;
    String detail = results
        .map((r) {
          String expl = r.targetValue.explanation
              .map((c) => "${c.value}\t\t${c.explanation}")
              .join("\n");
          return "${r.resultContext}:\n$expl";
        })
        .join("\n\n");

    if (useAnimations) {
      await fadeDice(context, DiceAnimation.d20);
    }

    if (!mounted) {
      return;
    }

    showDetailDialog(
      "${widget.skillOrSpell.name} (FW ${engine.talentValue})",
      rollResults.widget(context),
      rollResults.resultText(context),
      detail,
      rollResults.addText(widget.skillOrSpell),
      context,
    );
  }

  @override
  Widget build(BuildContext context) {
    final character = Provider.of<CharacterManager>(context).activeCharacter!;
    bool useAnimations = Provider.of<AppSettings>(context).useAnimations;
    SkillRoll stats = SkillRoll.from(character, widget.skillOrSpell, modifier);
    bool isRoutine = widget.skillOrSpell is SkillWrapper && stats.isRoutine();
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

              skillInfoCard(
                widget.skillOrSpell,
                stats,
                Provider.of<AppSettings>(context).nerdMode,
              ),
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
                key: const Key("skill_roll_button"),
                onPressed: () => performRoll(
                  character,
                  modifier,
                  useAnimations: useAnimations,
                ),
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 64, vertical: 16),
                ),
                child: Text('WÜRFELN', style: TextStyle(fontSize: 32)),
              ),
              if (isRoutine) SizedBox(height: 24),
              if (isRoutine)
                ElevatedButton(
                  key: const Key("routine_button"),
                  onPressed: () => performRoutineTrial(),
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(horizontal: 64, vertical: 16),
                  ),
                  child: Text('ROUTINE', style: TextStyle(fontSize: 32)),
                ),
              SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }

  void performRoutineTrial() {}
}
