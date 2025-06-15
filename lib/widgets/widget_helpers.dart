import 'package:flutter/material.dart';
import '../models/rules.dart';
import '../models/skill.dart';

Widget modifierRow(
  String label,
  dynamic value,
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
          Container(
            width: 17,
            alignment: Alignment.center,
            child: Text(value.toString()),
          ),
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

Column attributesCard(SkillRoll stats, {SkillRollResult? rollResults}) {
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
  var card = Card(
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
              children: [Text(stats.attr1.short), txt1],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 4.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [Text(stats.attr2.short), txt2],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 4.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [Text(stats.attr3.short), txt3],
            ),
          ),
        ],
      ),
    ),
  );
  var children = [card];
  if (stats.characterState.value() > 0) {
    children.add(statesCard(stats));
  }
  return Column(children: children);
}

Card statesCard(SkillRoll stats) {
  final states = stats.characterState.getTexts();
  String statesText = states.join(", ");
  return Card(
    margin: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
    child: Container(
      padding: EdgeInsets.all(16),
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Zustände',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 4.0),
            child: Text(statesText),
          ),
        ],
      ),
    ),
  );
}

void showErrorDialog(BuildContext context, String message) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Error'),
        content: Text(message),
        actions: [
          TextButton(
            child: Text('OK'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}

GestureDetector mainScreenPanel(
  String title,
  IconData icon,
  Function()? onTap,
) {
  return GestureDetector(
    onTap: onTap,
    child: Card(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 48),
          SizedBox(height: 8),
          Text(title, style: TextStyle(fontSize: 16)),
        ],
      ),
    ),
  );
}

String roman(int num) {
  if (num == 0) {
    return "0";
  }
  if (num < 0) {
    return "-${roman(-num)}";
  }
  return "M1000CM900D500CD400C100XC90L50XL40X10IX9V5IV4I1".replaceAllMapped(
    RegExp(r"([IVXLCDM]+)(\d+)"),
    (match) {
      String result = "";
      int value = int.parse(match.group(2)!);
      while (num >= value) {
        result += match.group(1)!;
        num -= value;
      }
      return result;
    },
  );
}
