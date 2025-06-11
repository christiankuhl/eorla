import 'dart:math';
import 'package:flutter/material.dart';
import '../widgets/character_card.dart';
import '../models/skill.dart';
import 'result_screen.dart';

class RollScreen extends StatefulWidget {
  final String talentName;
  final String category;
  final int talentValue;
  final List<Map<String, dynamic>> attributes; // [{'label': 'MU', 'value': 13}, ...]

  RollScreen({
    required this.talentName,
    required this.category,
    required this.talentValue,
    required this.attributes,
  });

  @override
  _RollScreenState createState() => _RollScreenState();
}

class _RollScreenState extends State<RollScreen> {
  final TextEditingController modifierController = TextEditingController(text: '0');

  void performRoll() {
    // pass data to ResultScreen, for now dummy roll results
    List<int> rollResults = List.generate(3, (_) => Random().nextInt(20) + 1);
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => ResultScreen(
          talentName: widget.talentName,
          category: widget.category,
          talentValue: widget.talentValue,
          attributes: widget.attributes,
          modifier: int.tryParse(modifierController.text) ?? 0,
          rollResults: rollResults,
          aggregateResult: "SUCCESS (QS=3)", // Placeholder
          specialText: "", // Placeholder
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          CharacterCard(),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              '${widget.category} → ${widget.talentName}',
              style: TextStyle(fontSize: 24),
            ),
          ),
          Text('Talent Value (FW): ${widget.talentValue}'),
          SizedBox(height: 8),
          ...widget.attributes.map((attr) => Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('${attr['label']} : ${attr['value']}'),
                ],
              )),
          SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: TextField(
              controller: modifierController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'GM Modifier',
              ),
            ),
          ),
          SizedBox(height: 24),
          ElevatedButton(
            onPressed: performRoll,
            child: Text('ROLL', style: TextStyle(fontSize: 32)),
          ),
        ],
      ),
    );
  }
}
