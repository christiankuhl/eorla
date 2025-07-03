import 'package:flutter/material.dart';
import '../models/rules.dart';
import '../models/attributes.dart';
import '../models/character.dart';
import '../models/audit.dart';

final styleGood = TextStyle(color: const Color.fromARGB(255, 109, 195, 101));
final styleBad = TextStyle(color: const Color.fromARGB(255, 218, 100, 100));

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

Card skillInfoCard<T extends Trial>(T skillOrSpell, SkillRoll stats) {
  return Card(
    margin: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
    child: Container(
      padding: EdgeInsets.all(16),
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            skillOrSpell.name,
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

Card attributeInfoCard(Attribute attr, ExplainedValue targetValue) {
  return Card(
    margin: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
    child: Container(
      padding: EdgeInsets.all(16),
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            attr.name,
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8),
          Text.rich(
            TextSpan(
              text: '${attr.short}: ',
              style: TextStyle(fontSize: 18),
              children: [
                TextSpan(
                  text: "${targetValue.value}",
                  style: tgtValueColour(targetValue),
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}

Column attributesCard(SkillRoll stats, {SkillRollResult? rollResults}) {
  Text txt1, txt2, txt3;
  if (rollResults == null) {
    SkillRollResult res = stats
        .roll(); // TODO: this is a bit hackish, ideally SkillRoll would have getters for the target values
    txt1 = colouredValue(res.tgtValue1);
    txt2 = colouredValue(res.tgtValue2);
    txt3 = colouredValue(res.tgtValue3);
  } else {
    txt1 = Text.rich(
      TextSpan(
        children: [
          TextSpan(
            text: "${rollResults.tgtValue1.value}",
            style: tgtValueColour(rollResults.tgtValue1),
          ),
          TextSpan(text: " → 🎲 ${rollResults.roll1 ?? '-/-'}"),
        ],
      ),
    );
    txt2 = Text.rich(
      TextSpan(
        children: [
          TextSpan(
            text: "${rollResults.tgtValue2.value}",
            style: tgtValueColour(rollResults.tgtValue2),
          ),
          TextSpan(text: " → 🎲 ${rollResults.roll2 ?? '-/-'}"),
        ],
      ),
    );
    txt3 = Text.rich(
      TextSpan(
        children: [
          TextSpan(
            text: "${rollResults.tgtValue3.value}",
            style: tgtValueColour(rollResults.tgtValue3),
          ),
          TextSpan(text: " → 🎲 ${rollResults.roll3 ?? '-/-'}"),
        ],
      ),
    );
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
    children.add(statesCard(stats.characterState));
  }
  return Column(children: children);
}

Card statesCard(CharacterState state) {
  final states = state.getTexts();
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

Widget actionButton(IconData icon, VoidCallback onPressed, bool active) {
  return Opacity(
    opacity: active ? 1.0 : 0.5,
    child: ElevatedButton(
      onPressed: active ? onPressed : null,
      style: ElevatedButton.styleFrom(
        shape: CircleBorder(),
        padding: EdgeInsets.all(12),
        elevation: 2,
      ),
      child: Icon(icon),
    ),
  );
}

TextStyle? tgtValueColour(ExplainedValue value) {
  int totalMod = value.explanation
      .where((comp) => comp.isMod)
      .map((comp) => comp.value)
      .fold(0, (x, y) => x + y);

  TextStyle? style;
  if (totalMod > 0) {
    style = styleGood;
  } else if (totalMod < 0) {
    style = styleBad;
  }
  return style;
}

Text colouredValue(ExplainedValue value) {
  return Text(value.value.toString(), style: tgtValueColour(value));
}

void showDetailDialog(
  String title,
  String txt,
  String detail,
  BuildContext context,
) {
  showDialog(
    context: context,
    builder: (_) {
      bool expanded = false;

      return StatefulBuilder(
        builder: (context, setState) => AlertDialog(
          title: Text(title),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  Expanded(child: Text(txt)),
                  IconButton(
                    icon: Icon(
                      expanded ? Icons.expand_less : Icons.expand_more,
                    ),
                    onPressed: () => setState(() => expanded = !expanded),
                  ),
                ],
              ),
              if (expanded)
                Padding(
                  padding: const EdgeInsets.only(top: 12.0),
                  child: Text(
                    detail,
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('OK'),
            ),
          ],
        ),
      );
    },
  );
}

void showSimpleDialog(String title, String txt, BuildContext context) {
  showDialog(
    context: context,
    builder: (_) => AlertDialog(
      title: Text(title),
      content: Text(txt),
      actions: [
        TextButton(onPressed: () => Navigator.pop(context), child: Text('OK')),
      ],
    ),
  );
}
