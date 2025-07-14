import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../managers/character_manager.dart';
import '../managers/settings.dart';
import '../models/attributes.dart';
import '../models/rules.dart';
import '../models/audit.dart';
import '../models/character.dart';
import '../widgets/character_card.dart';
import '../widgets/widget_helpers.dart';
import 'dice_rolls.dart';

class AttributeRollScreen extends StatefulWidget {
  final Attribute attribute;

  const AttributeRollScreen({
    required this.attribute,
    super.key,
  });

  @override
  AttributeRollScreenState createState() => AttributeRollScreenState();
}

class AttributeRollScreenState extends State<AttributeRollScreen> {
  int modifier = 0;

  Future<void> performRoll(Character character, int modifier) async {
    ExplainedValue attrValue = attributeTargetValue(
      character,
      widget.attribute,
      modifier,
    );
    AttributeRollResult result = attributeRoll(attrValue);

    String detail = attrValue.explanation
        .map((c) => "${c.value}\t\t${c.explanation}")
        .join("\n");

    await fadeDice(context, DiceAnimation.d20);

    if (!mounted) {
      return;
    }

    showDetailDialog(
      widget.attribute.name,
      result.widget(context),
      result.resultText(context),
      detail,
      null,
      context,
    );
  }

  @override
  Widget build(BuildContext context) {
    final character = Provider.of<CharacterManager>(context).activeCharacter!;
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

              attributeInfoCard(
                widget.attribute,
                ExplainedValue.base(
                      character.getAttribute(widget.attribute),
                      "${widget.attribute.short} Basis",
                    )
                    .add(modifier, "Modifikator", true)
                    .andThen(character.state.explain()),
                Provider.of<AppSettings>(context).nerdMode,
              ),
              if (character.state.value() > 0)
                statesCard(character.state),

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
                key: const Key("attribute_roll_button"),
                onPressed: () => performRoll(character, modifier),
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
