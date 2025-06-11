import 'package:flutter/material.dart';
import '../widgets/character_card.dart';
import '../models/skill.dart';

class ResultScreen extends StatelessWidget {
  final String talentName;
  final String category;
  final int talentValue;
  final List<Map<String, dynamic>> attributes;
  final int modifier;
  final List<int> rollResults;
  final String aggregateResult;
  final String specialText;

  ResultScreen({
    required this.talentName,
    required this.category,
    required this.talentValue,
    required this.attributes,
    required this.modifier,
    required this.rollResults,
    required this.aggregateResult,
    required this.specialText,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          CharacterCard(),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              '${category} → ${talentName}',
              style: TextStyle(fontSize: 24),
            ),
          ),
          Text('Talent Value (FW): $talentValue'),
          SizedBox(height: 8),
          ...attributes.asMap().entries.map((entry) {
            int index = entry.key;
            Map<String, dynamic> attr = entry.value;
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('${attr['label']} : ${attr['value']} → 🎲 ${rollResults[index]}'),
              ],
            );
          }),
          SizedBox(height: 16),
          Text('GM Modifier used: $modifier'),
          SizedBox(height: 16),
          Text('Aggregate Result: $aggregateResult', style: TextStyle(fontSize: 20)),
          if (specialText.isNotEmpty)
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(specialText),
            ),
          SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: () => Navigator.pop(context),
                child: Text('ROLL AGAIN'),
              ),
              ElevatedButton(
                onPressed: () => Navigator.popUntil(
                  context,
                  ModalRoute.withName(Navigator.defaultRouteName),
                ),
                child: Text('CHANGE TALENT'),
              ),
            ],
          ),
          SizedBox(height: 16),
        ],
      ),
    );
  }
}
