import 'package:flutter/material.dart';
import '../models/rules.dart';
import '../models/skill.dart';

Widget modifierRow(
  String label,
  int value,
  VoidCallback onIncrement,
  VoidCallback onDecrement,
) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Text(label),
      Row(
        children: [
          IconButton(icon: Icon(Icons.remove), onPressed: onDecrement),
          Text(value.toString()),
          IconButton(icon: Icon(Icons.add), onPressed: onIncrement),
        ],
      ),
    ],
  );
}

Card skillInfoCard(Skill skill, SkillRoll stats) {
  return Card(
    margin: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
    child: Container(
      padding: EdgeInsets.all(16),
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '$skill',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8),
          Text(
            'Fertigkeitswert (FW): ${stats.talentValue}',
            style: TextStyle(fontSize: 18),
          ),
        ],
      ),
    ),
  );
}

Card attributesCard(SkillRoll stats, {RollResult? rollResults}) {
  Text txt1, txt2, txt3;
  if (rollResults == null) {
    txt1 = Text(stats.attrValue1.toString());
    txt2 = Text(stats.attrValue2.toString());
    txt3 = Text(stats.attrValue3.toString());
  } else {
    txt1 = Text("${stats.attrValue1.toString()} → 🎲 ${rollResults.roll1}");
    txt2 = Text("${stats.attrValue2.toString()} → 🎲 ${rollResults.roll2}");
    txt3 = Text("${stats.attrValue3.toString()} → 🎲 ${rollResults.roll3}");
  }
  return Card(
    margin: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
    child: Container(
      padding: EdgeInsets.all(16),
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Eigenschaften',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 4.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(stats.attr1.short),
                txt1,
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 4.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(stats.attr2.short),
                txt2,
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 4.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(stats.attr3.short),
                txt3,
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
