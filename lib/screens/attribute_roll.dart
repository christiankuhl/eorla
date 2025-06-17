import 'package:flutter/material.dart';
import '../widgets/character_card.dart';
import '../models/attributes.dart';
import '../models/character.dart';
import '../models/rules.dart';
import '../widgets/widget_helpers.dart';

class AttributeRollScreen extends StatefulWidget {
  final Attribute attribute;
  final Character character;

  const AttributeRollScreen({
    required this.attribute,
    required this.character,
    super.key,
  });

  @override
  AttributeRollScreenState createState() => AttributeRollScreenState();
}

class AttributeRollScreenState extends State<AttributeRollScreen> {
  int modifier = 0;

  void performRoll(int modifier) {
    int atValue = widget.character.getAttribute(widget.attribute);
    AttributeRollResult result = attributeRoll(
      atValue,
      modifier,
      widget.character.state,
    );
    String txt =
        "${result.text()} (${atValue + modifier - widget.character.state.value()} → 🎲 ${result.roll ?? '-/-'})";
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(widget.attribute.name),
        content: Text(txt),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
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
                widget.character.getAttribute(widget.attribute),
              ),
              if (widget.character.state.value() > 0)
                statesCard(widget.character.state),

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
