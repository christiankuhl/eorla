import 'package:flutter/material.dart';
import '../models/rules.dart';
import '../models/attributes.dart';
import '../models/character.dart';
import '../models/audit.dart';
import '../models/probabilities.dart';

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

Card skillInfoCard<T extends Trial>(
  T skillOrSpell,
  SkillRoll stats,
  bool nerdMode,
) {
  return Card(
    margin: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
    child: Container(
      padding: EdgeInsets.all(16),
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  skillOrSpell.name,
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ),
              if (nerdMode) statsBox(stats),
            ],
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

Card attributeInfoCard(
  Attribute attr,
  ExplainedValue targetValue,
  bool nerdMode,
) {
  return Card(
    margin: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
    child: Container(
      padding: EdgeInsets.all(16),
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  attr.name,
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ),
              if (nerdMode) statsBoxAttribute(targetValue.value),
            ],
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
    txt1 = colouredValue(stats.tgtValue1);
    txt2 = colouredValue(stats.tgtValue2);
    txt3 = colouredValue(stats.tgtValue3);
  } else {
    txt1 = Text.rich(
      TextSpan(
        children: [
          TextSpan(
            text: "${rollResults.rolls[0].targetValue.value}",
            style: tgtValueColour(rollResults.rolls[0].targetValue),
          ),
          TextSpan(text: " → 🎲 ${rollResults.rolls[0].roll ?? '-/-'}"),
        ],
      ),
    );
    txt2 = Text.rich(
      TextSpan(
        children: [
          TextSpan(
            text: "${rollResults.rolls[1].targetValue.value}",
            style: tgtValueColour(rollResults.rolls[1].targetValue),
          ),
          TextSpan(text: " → 🎲 ${rollResults.rolls[1].roll ?? '-/-'}"),
        ],
      ),
    );
    txt3 = Text.rich(
      TextSpan(
        children: [
          TextSpan(
            text: "${rollResults.rolls[2].targetValue.value}",
            style: tgtValueColour(rollResults.rolls[2].targetValue),
          ),
          TextSpan(text: " → 🎲 ${rollResults.rolls[2].roll ?? '-/-'}"),
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

Text colouredValue(ExplainedValue v) {
  return Text(
    (v.value < 1) ? "0" : v.value.toString(),
    style: tgtValueColour(v),
  );
}

// void showDetailDialog(
//   String title,
//   Widget dice,
//   Widget resultText,
//   String detail,
//   BuildContext context,
// ) {
//   showDialog(
//     context: context,
//     builder: (_) {
//       bool expanded = false;

//       return StatefulBuilder(
//         builder: (context, setState) => AlertDialog(
//           title: Text(title, style: Theme.of(context).textTheme.titleLarge),
//           content: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               dice,
//               Row(
//                 children: [
//                   Expanded(child: resultText),
//                   IconButton(
//                     icon: Icon(
//                       expanded ? Icons.expand_less : Icons.expand_more,
//                     ),
//                     onPressed: () => setState(() => expanded = !expanded),
//                   ),
//                 ],
//               ),
//               if (expanded)
//                 Padding(
//                   padding: const EdgeInsets.only(top: 12.0),
//                   child: Text(
//                     detail,
//                     style: Theme.of(context).textTheme.bodySmall,
//                   ),
//                 ),
//             ],
//           ),
//           actions: [
//             TextButton(
//               onPressed: () => Navigator.pop(context),
//               child: Text('OK'),
//             ),
//           ],
//         ),
//       );
//     },
//   );
// }

void showDetailDialog(
  String title,
  Widget dice,
  Widget resultText,
  String auditTrailText,
  String? rulebookText,
  BuildContext context, {
  bool startExpanded = false,
  int initialTabIndex = 0, // 0 = Audit, 1 = Rulebook
}) {
  showDialog(
    context: context,
    builder: (_) {
      bool expanded = startExpanded;
      int selectedTab = initialTabIndex;

      return StatefulBuilder(
        builder: (context, setState) => AlertDialog(
          title: Text(title, style: Theme.of(context).textTheme.titleLarge),
          content: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 240),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                dice,
                Row(
                  children: [
                    Expanded(child: resultText),
                    IconButton(
                      icon: Icon(
                        expanded ? Icons.expand_less : Icons.expand_more,
                      ),
                      onPressed: () => setState(() => expanded = !expanded),
                    ),
                  ],
                ),
                if (expanded)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const SizedBox(height: 12),
                      Container(
                        decoration: BoxDecoration(
                          color: Theme.of(
                            context,
                          ).colorScheme.surfaceContainerHighest,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          children: [
                            if (rulebookText != null)
                              _TabButton(
                                label: 'Regeln',
                                selected: selectedTab == 0,
                                onTap: () => setState(() => selectedTab = 0),
                              ),
                            _TabButton(
                              label: 'Zielwerte',
                              selected: selectedTab == 1,
                              onTap: () => setState(
                                () =>
                                    selectedTab = rulebookText != null ? 1 : 0,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 12),
                      IndexedStack(
                        index: selectedTab,
                        children: [
                          if (rulebookText != null)
                            Text(
                              rulebookText,
                              style: Theme.of(context).textTheme.bodySmall,
                              softWrap: true,
                            ),
                          Text(
                            auditTrailText,
                            style: Theme.of(context).textTheme.bodySmall,
                            softWrap: true,
                          ),
                        ],
                      ),
                    ],
                  ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('OK'),
            ),
          ],
        ),
      );
    },
  );
}

class _TabButton extends StatelessWidget {
  final String label;
  final bool selected;
  final VoidCallback onTap;

  const _TabButton({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Expanded(
      child: InkWell(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 4),
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: selected
                    ? theme.colorScheme.primary
                    : Colors.transparent,
                width: 2,
              ),
            ),
          ),
          child: Center(
            child: Text(
              label,
              style: theme.textTheme.bodyMedium?.copyWith(
                fontWeight: selected ? FontWeight.w600 : FontWeight.w400,
                color: selected
                    ? theme.colorScheme.primary
                    : theme.textTheme.bodyMedium?.color,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

void showSimpleDialog(
  String title,
  Widget dice,
  Widget resultText,
  BuildContext context,
) {
  showDialog(
    context: context,
    builder: (_) => AlertDialog(
      title: Text(title, style: Theme.of(context).textTheme.titleLarge),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [dice, resultText],
      ),
      actions: [
        TextButton(onPressed: () => Navigator.pop(context), child: Text('OK')),
      ],
    ),
  );
}

Widget statsBox(SkillRoll stats) {
  final p = SkillRollProbability(stats);
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        "P(E) = ${(100 * p.success()).toStringAsFixed(1)}%",
        style: TextStyle(
          fontSize: 10,
          color: Color.fromARGB(128, 255, 255, 255),
        ),
      ),
      Text(
        "E(QS) = ${(p.expectedQS()).toStringAsFixed(2)}",
        style: TextStyle(
          fontSize: 10,
          color: Color.fromARGB(128, 255, 255, 255),
        ),
      ),
    ],
  );
}

Widget statsBoxAttribute(int targetValue) {
  return Text(
    "P(E) = ${(100 * attributeRollSuccess(targetValue)).toStringAsFixed(1)}%",
    style: TextStyle(fontSize: 10, color: Color.fromARGB(128, 255, 255, 255)),
  );
}
