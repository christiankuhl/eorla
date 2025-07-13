import 'package:flutter/material.dart';
import '../models/rules.dart';

enum DisplayMode { text, colored, fancy }

Widget diceResultsWidget(DamageRollResult result, BuildContext context) {
  return IntrinsicHeight(
    child: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: result.dice
              .map(
                (d) => Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                  child: d.displayWidget(
                    context,
                    displayMode: DisplayMode.fancy,
                  ),
                ),
              )
              .toList(),
        ),
        const SizedBox(height: 24),
        RichText(
          text: TextSpan(
            style: Theme.of(context).textTheme.bodyMedium,
            children: [
              const TextSpan(text: "Dein Angriff verursacht "),
              TextSpan(
                text: result.combinedResult,
                style: Theme.of(
                  context,
                ).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold),
              ),
              const TextSpan(text: " Trefferpunkt(e)."),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget attributeRollResult(AttributeRollResult result, BuildContext context) {
  return IntrinsicHeight(
    child: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: result.dice
              .map(
                (d) => Padding(
                  padding: const EdgeInsets.only(left: 12.0, right: 40.0),
                  child: d.displayWidget(
                    context,
                    displayMode: DisplayMode.fancy,
                    topRight: Text("≤ ${result.targetValue.value}"),
                    bottomRight: d.result <= result.targetValue.value
                        ? Icon(Icons.check, color: Colors.green, size: 20.0)
                        : Icon(Icons.close, color: Colors.red, size: 20.0),
                  ),
                ),
              )
              .toList(),
        ),
        const SizedBox(height: 24),
        Center(
          child: RichText(
            text: TextSpan(
              style: Theme.of(context).textTheme.bodyMedium,
              children: [
                TextSpan(
                  text: result.combinedResult,
                  style: Theme.of(
                    context,
                  ).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}

RichText skillRollResultText(SkillRollResult result, BuildContext context) {
  switch (result.quality.type) {
    case RollEvent.success:
      return RichText(
        text: TextSpan(
          style: Theme.of(context).textTheme.bodyMedium,
          children: [
            TextSpan(
              text: "Erfolg! (",
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w400,
                fontSize: 18,
              ),
            ),
            TextSpan(
              text: "QS: ${result.quality.qs}",
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w900,
                fontSize: 18,
              ),
            ),
            TextSpan(
              text: ")",
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w400,
                fontSize: 18,
              ),
            ),
          ],
        ),
      );
    case RollEvent.failure:
    case RollEvent.critical:
    case RollEvent.botch:
      return RichText(
        text: TextSpan(
          style: Theme.of(context).textTheme.bodyMedium,
          children: [
            TextSpan(
              text: result.text(),
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w600,
                fontSize: 18,
              ),
            ),
          ],
        ),
      );
  }
}

Widget skillRollResultWidget(SkillRollResult result, BuildContext context) {
  return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Column(
          children: result.rolls
              .map(
                (roll) => Padding(
                  padding: const EdgeInsets.only(bottom: 15.0, top: 5.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(roll.resultContext ?? "i"),
                      Padding(
                        padding: const EdgeInsets.only(right: 40.0),
                        child: roll.dice[0].displayWidget(
                          context,
                          displayMode: DisplayMode.fancy,
                          topRight: Text("≤ ${roll.targetValue.value}"),
                          bottomRight:
                              roll.dice[0].result <= roll.targetValue.value
                              ? Icon(
                                  Icons.check,
                                  color: Colors.green,
                                  size: 20.0,
                                )
                              : Text(
                                  "- ${roll.dice[0].result - roll.targetValue.value}",
                                  style: TextStyle(
                                    color: Colors.redAccent,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                        ),
                      ),
                    ],
                  ),
                ),
              )
              .toList(),
        ),
        const SizedBox(height: 9),
        result.resultText(context),
      ],
    );
}