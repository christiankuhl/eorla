import 'package:flutter/material.dart';
import 'character.dart';
import 'skill.dart';
import 'weapons.dart';
import 'attributes.dart';
import 'special_abilities.dart';
import 'special_abilities_impl.dart';
import 'dart:math';
import 'dice.dart';
import 'audit.dart';

class GenerericRollResult {
  final List<Dice> dice;
  final int combinedResult;
  final String title;

  GenerericRollResult(this.dice, this.combinedResult, this.title);

  Widget titleAsWidget(BuildContext context) {
    return Text(title);
  }

  // All RollResults should have a function displaying its output
  // Subclasses may override this to return any Flutter Widget for display, if they also handle the dice List being empty.
  Widget contentAsWidget(BuildContext context) {
    if (dice.isEmpty) {
      return Text("No dice rolled.");
    }
    // If any of the dice result is still the default of -999999 return error Text
    if (dice.any((d) => d.result == -999999)) {
      return Text("Error: Some dice have not been rolled.");
    }
    return resultsWidget(context);
  }

  // Subclasses may override this to return any Flutter Widget for display.
  Widget resultsWidget(BuildContext context) {
    final rolls = dice.map((d) => d.result).join(", ");
    return Text("Rolls: [$rolls], Combined Result: $combinedResult");
  }
}

class DamageRollResult extends GenerericRollResult {
  DamageRollResult(List<Dice> dice, int combinedResult)
    : super(dice, combinedResult, "Schaden");

  @override
  Widget resultsWidget(BuildContext context) {
    return IntrinsicHeight(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: dice
                .map(
                  (d) => Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0),
                    child: d.displayWidget(context, DiceDisplayMode.fancy),
                  ),
                )
                .toList(),
          ),
          const SizedBox(height: 8),
          RichText(
            text: TextSpan(
              style: Theme.of(context).textTheme.bodyMedium,
              children: [
                const TextSpan(text: "Dein Angriff verursacht "),
                TextSpan(
                  text: "$combinedResult",
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
}

abstract class Trial {
  Attribute get attr1;
  Attribute get attr2;
  Attribute get attr3;
  String get name;
}

class SkillRoll<T extends Trial> {
  final Attribute attr1;
  final Attribute attr2;
  final Attribute attr3;
  final int attrValue1;
  final int attrValue2;
  final int attrValue3;
  final int talentValue;
  final CharacterState characterState;
  int modifier;

  SkillRoll(
    this.attr1,
    this.attr2,
    this.attr3,
    this.attrValue1,
    this.attrValue2,
    this.attrValue3,
    this.talentValue,
    this.characterState,
    this.modifier,
  );

  factory SkillRoll.from(Character character, T skillOrSpell, int modifier) {
    Attribute attr1 = skillOrSpell.attr1;
    Attribute attr2 = skillOrSpell.attr2;
    Attribute attr3 = skillOrSpell.attr3;
    int attrValue1 = character.getAttribute(attr1);
    int attrValue2 = character.getAttribute(attr2);
    int attrValue3 = character.getAttribute(attr3);
    int talentValue = character.getTalentOrSpell(skillOrSpell);

    return SkillRoll(
      attr1,
      attr2,
      attr3,
      attrValue1,
      attrValue2,
      attrValue3,
      talentValue,
      character.state,
      modifier,
    );
  }

  SkillRollResult roll({Random? random}) {
    List<ExplainedValue> expls = [];
    bool illegal = false;
    for (var (attr, attrValue) in [
      (attr1, attrValue1),
      (attr2, attrValue2),
      (attr3, attrValue3),
    ]) {
      ExplainedValue? expl;
      var effFW = attrValue + modifier - characterState.value();
      if (effFW < 1) {
        expl = ExplainedValue.base(
          effFW,
          "Ein Wurf mit einem effektiven FW < 1 darf nicht versucht werden",
        );
        illegal = true;
      } else {
        expl = ExplainedValue.base(effFW, attr.name);
      }
      expls.add(expl);
    }
    if (illegal) {
      return SkillRollResult(
        null,
        null,
        null,
        Quality(RollEvent.failure, 0),
        expls[0],
        expls[1],
        expls[2],
      );
    }
    random ??= Random();
    int roll1 = random.nextInt(20) + 1;
    int roll2 = random.nextInt(20) + 1;
    int roll3 = random.nextInt(20) + 1;
    List<ComponentWithExplanation> characterStates = characterState.explain();
    ExplainedValue tgtValue1 = ExplainedValue.base(
      attrValue1,
      attr1.name,
    ).add(modifier, "Modifikator", true).andThen(characterStates);
    ExplainedValue tgtValue2 = ExplainedValue.base(
      attrValue2,
      attr2.name,
    ).add(modifier, "Modifikator", true).andThen(characterStates);
    ExplainedValue tgtValue3 = ExplainedValue.base(
      attrValue3,
      attr3.name,
    ).add(modifier, "Modifikator", true).andThen(characterStates);
    int fw =
        talentValue +
        min(tgtValue1.value - roll1, 0).toInt() +
        min(tgtValue2.value - roll2, 0).toInt() +
        min(tgtValue3.value - roll3, 0).toInt();
    List<int> rolls = [roll1, roll2, roll3];
    bool botch = rolls.where((n) => n == 20).length >= 2;
    bool critical = rolls.where((n) => n == 1).length >= 2;
    RollEvent event;
    if (botch) {
      event = RollEvent.botch;
    } else if (critical) {
      event = RollEvent.critical;
    } else if (fw < 0) {
      event = RollEvent.failure;
    } else {
      event = RollEvent.success;
    }
    int qs = max(min((fw - 1) ~/ 3 + 1, 6), 0);
    if (fw == 0) {
      qs = 1;
    }
    return SkillRollResult(
      roll1,
      roll2,
      roll3,
      Quality(event, qs),
      tgtValue1,
      tgtValue2,
      tgtValue3,
    );
  }
}

enum RollEvent { success, failure, critical, botch }

class Quality {
  RollEvent type;
  int qs;

  Quality(this.type, this.qs);
}

class SkillRollResult {
  final int? roll1;
  final int? roll2;
  final int? roll3;
  final Quality quality;
  final ExplainedValue tgtValue1;
  final ExplainedValue tgtValue2;
  final ExplainedValue tgtValue3;

  SkillRollResult(
    this.roll1,
    this.roll2,
    this.roll3,
    this.quality,
    this.tgtValue1,
    this.tgtValue2,
    this.tgtValue3,
  );

  String text() {
    switch (quality.type) {
      case RollEvent.success:
        return "Erfolg! (QS: ${quality.qs})";
      case RollEvent.failure:
        return "Fehlschlag!";
      case RollEvent.critical:
        return "Kritischer Erfolg!";
      case RollEvent.botch:
        return "Kritischer Fehlschlag!";
    }
  }

  String addText<T extends Trial>(T skillOrSpell) {
    if (skillOrSpell is Skill) {
      switch (quality.type) {
        case RollEvent.success:
          return "";
        case RollEvent.failure:
          return "";
        case RollEvent.critical:
          return (skillOrSpell as Skill).critical;
        case RollEvent.botch:
          return (skillOrSpell as Skill).botch;
      }
    } else {
      return "";
    }
  }
}

class AttributeRollResult {
  final int? roll;
  final RollEvent event;
  final ExplainedValue targetValue;
  String? context;

  AttributeRollResult(this.roll, this.event, this.targetValue, {context});

  String text() {
    switch (event) {
      case RollEvent.success:
        return "Erfolg!";
      case RollEvent.failure:
        return "Fehlschlag!";
      case RollEvent.critical:
        return "Kritischer Erfolg!";
      case RollEvent.botch:
        return "Kritischer Fehlschlag!";
    }
  }
}

class CombatRoll {
  final Weapon? weapon;
  final CombatTechnique ct;
  final int ctValue;
  final int parryPrimary;
  final int attackPrimary;
  final int dodge;
  final int modifier;
  final Character character;
  final SpecialAbility? specialAbilityBaseManeuvre;
  final SpecialAbility? specialAbilitySpecialManeuvre;

  CombatRoll(
    this.ct,
    this.ctValue,
    this.attackPrimary,
    this.parryPrimary,
    this.dodge,
    this.modifier,
    this.character,
    this.weapon,
    this.specialAbilityBaseManeuvre,
    this.specialAbilitySpecialManeuvre,
  );
  factory CombatRoll.fromWeapon(
    Character character,
    Weapon weapon,
    SpecialAbility? specialAbilityBaseManeuvre,
    SpecialAbility? specialAbilitySpecialManeuvre,
    int modifier,
  ) {
    return CombatRoll.fromTechnique(
      character,
      weapon.ct,
      specialAbilityBaseManeuvre,
      specialAbilitySpecialManeuvre,
      modifier,
      weapon: weapon,
    );
  }

  factory CombatRoll.fromTechnique(
    Character character,
    CombatTechnique ct,
    SpecialAbility? specialAbilityBaseManeuvre,
    SpecialAbility? specialAbilitySpecialManeuvre,
    int modifier, {
    Weapon? weapon,
  }) {
    final attackPrimary = character.getAttribute(
      ct.group == CombatType.melee ? Attribute.mut : Attribute.fingerfertigkeit,
    );
    final parryPrimary = ct.primary
        .map((attr) => character.getAttribute(attr))
        .reduce((a, b) => a > b ? a : b);
    return CombatRoll(
      ct,
      character.getCT(ct),
      attackPrimary,
      parryPrimary,
      (character.ge / 2).round(),
      modifier,
      character,
      weapon,
      specialAbilityBaseManeuvre,
      specialAbilitySpecialManeuvre,
    );
  }

  ExplainedValue targetValue(CombatActionType action) {
    ExplainedValue? tgt;
    switch (action) {
      case CombatActionType.attack:
        int at = ctValue + (max(attackPrimary - 8, 0) / 3).toInt();
        tgt = ExplainedValue.base(at, "AT ${ct.name}");
        tgt = tgt.add(
          weapon?.at ?? 0,
          "AT Mod ${weapon!.name}",
          false,
        );
        break;
      case CombatActionType.parry:
        int pa = (ctValue / 2).ceil() + (max(parryPrimary - 8, 0) / 3).toInt();
        tgt = ExplainedValue.base(pa, "PA Basis");
        tgt = tgt.add(
          weapon?.pa ?? 0,
          "PA Mod ${weapon!.name}",
          false,
        );
        break;
      case CombatActionType.dodge:
        tgt = ExplainedValue.base(dodge, "AW Basis");
        break;
    }
    if (specialAbilityBaseManeuvre != null) {
      SpecialAbilityImpact impact = SpecialAbilityImpact.derive(
        specialAbilityBaseManeuvre!,
        ct,
        weapon,
        0,
      );
      int modifierBaseManeuvre = impact.getApplicableMod(action);
      tgt = tgt.add(
        modifierBaseManeuvre,
        specialAbilityBaseManeuvre!.toString(),
        true,
      );
    }
    if (specialAbilitySpecialManeuvre != null) {
      SpecialAbilityImpact impact = SpecialAbilityImpact.derive(
        specialAbilitySpecialManeuvre!,
        ct,
        weapon,
        0,
      );
      int modifierSpecialManeuvre = impact.getApplicableMod(action);
      tgt = tgt.add(
        modifierSpecialManeuvre,
        specialAbilitySpecialManeuvre!.toString(),
        true,
      );
    }
    tgt = tgt.add(modifier, "Modifikator", true);
    return tgt;
  }

  /// Rolls for an attribute check based on the given [CombatActionType] [action].
  /// Returns a list of [AttributeRollResult] representing the roll outcomes.
  List<AttributeRollResult> roll(CombatActionType action) {
    ExplainedValue target = targetValue(action);

    if (specialAbilityBaseManeuvre != null) {
      SpecialAbilityImpact impact = SpecialAbilityImpact.derive(
        specialAbilityBaseManeuvre!,
        ct,
        weapon,
        modifier,
      );
      if (impact.callback != null) {
        return impact.callback!(this, action);
      }
    }
    if (specialAbilitySpecialManeuvre != null) {
      SpecialAbilityImpact impact = SpecialAbilityImpact.derive(
        specialAbilitySpecialManeuvre!,
        ct,
        weapon,
        modifier,
      );
      if (impact.callback != null) {
        return impact.callback!(this, action);
      }
    }

    return [attributeRoll(target)];
  }
}

ExplainedValue attributeTargetValue(
  Character character,
  Attribute attribute,
  int modifier,
) {
  return ExplainedValue.base(
    character.getAttribute(attribute),
    "${attribute.name} Basis",
  ).add(modifier, "Modifikator", true).andThen(character.state.explain());
}

AttributeRollResult attributeRoll(ExplainedValue target, {Random? random}) {
  random ??= Random();
  int roll = random.nextInt(20) + 1;
  if (target.value < 1) {
    return AttributeRollResult(
      null,
      RollEvent.failure,
      target.addUnconditional(
        0,
        "Ein Wurf mit einem effektiven FW < 1 darf nicht versucht werden",
        true,
      ),
    );
  }
  int fw = target.value - roll;
  if (roll == 1) {
    int roll2 = random.nextInt(20) + 1;
    int fw2 = target.value - roll2;
    if (fw2 >= 0) {
      return AttributeRollResult(roll, RollEvent.critical, target);
    } else {
      return AttributeRollResult(roll, RollEvent.success, target);
    }
  } else if (roll == 20) {
    int roll2 = random.nextInt(20) + 1;
    int fw2 = target.value - roll2;
    if (fw2 >= 0 && roll2 != 20) {
      if (fw >= 0) {
        return AttributeRollResult(roll, RollEvent.success, target);
      } else {
        return AttributeRollResult(roll, RollEvent.failure, target);
      }
    } else {
      return AttributeRollResult(roll, RollEvent.botch, target);
    }
  } else {
    if (fw >= 0) {
      return AttributeRollResult(roll, RollEvent.success, target);
    } else {
      return AttributeRollResult(roll, RollEvent.failure, target);
    }
  }
}

/// Calculates the total damage dealt by a weapon, considering the character's attributes and any special abilities.
///
/// [weapon] - The weapon used for the attack.
/// [character] - The character performing the attack.
/// [specialAbilityBaseManeuvre] - An optional special ability that modifies the base attack.
/// [specialAbilitySpecialManeuvre] - An optional special ability that modifies the special attack.
///
/// Returns the total damage as an integer.
DamageRollResult damageRoll(
  Weapon weapon,
  Character character,
  SpecialAbility? specialAbilityBaseManeuvre,
  SpecialAbility? specialAbilitySpecialManeuvre, {
  Random? random,
}) {
  final primary = weapon.ct.primary
      .map((attr) => character.getAttribute(attr))
      .reduce((a, b) => a > b ? a : b);

  random ??= Random();
  int result = 0;
  int tpMod = 0;
  double tpMult = 1;
  int tpModAfterMultiplier = 0;
  int tpFlat =
      weapon.damageFlat + max(primary - weapon.primaryThreshold, 0).toInt();
  List<Dice> damageDice = [];
  for (var i = 0; i < weapon.damageDice; i++) {
    damageDice.add(Dice.create(weapon.damageDiceSides));
  }

  // Check impact from base maneuvre
  if (specialAbilityBaseManeuvre != null) {
    SpecialAbilityImpact impact = SpecialAbilityImpact.derive(
      specialAbilityBaseManeuvre,
      weapon.ct,
      weapon,
      0,
    );
    if (impact.tpcallback != null) {
      tpMod += impact.tpcallback!(character);
    }
    tpMod += impact.tpMod;
    tpMult *= impact.tpMult;
    tpModAfterMultiplier += impact.tpModAfterMultiplier;
    if (impact.additionalDiceReplaceOriginal) {
      damageDice = impact.additionalDice;
      //TODO: Check if we want this behaviour.
      tpFlat = 0;
    } else {
      damageDice.addAll(impact.additionalDice);
    }
  }
  // Check impact from special maneuvre
  if (specialAbilitySpecialManeuvre != null) {
    SpecialAbilityImpact impact = SpecialAbilityImpact.derive(
      specialAbilitySpecialManeuvre,
      weapon.ct,
      weapon,
      0,
    );
    if (impact.tpcallback != null) {
      tpMod += impact.tpcallback!(character);
    }
    tpMod += impact.tpMod;
    tpMult *= impact.tpMult;
    tpModAfterMultiplier += impact.tpModAfterMultiplier;
    if (impact.additionalDiceReplaceOriginal) {
      damageDice = impact.additionalDice;
      //TODO: Check if we want this behaviour.
      tpFlat = 0;
    } else {
      damageDice.addAll(impact.additionalDice);
    }
  }

  // Roll all dice and add their results to the result variable
  for (var dice in damageDice) {
    result += dice.roll(random);
  }
  // Apply modifiers and multipliers
  result = ((result + tpFlat + tpMod) * tpMult).round() + tpModAfterMultiplier;

  return DamageRollResult(damageDice, result);
}

RichText damageRollTextGenerator(
  Weapon weapon,
  Character character,
  SpecialAbility? specialAbilityBaseManeuvre,
  SpecialAbility? specialAbilitySpecialManeuvre,
  TextStyle? styleNormal, {
  TextStyle? styleGood,
  TextStyle? styleBad,
}) {
  final primary = weapon.ct.primary
      .map((attr) => character.getAttribute(attr))
      .reduce((a, b) => a > b ? a : b);

  int tpMod = 0;
  double tpMult = 1;
  int tpModAfterMultiplier = 0;
  int tpFlat =
      weapon.damageFlat + max(primary - weapon.primaryThreshold, 0).toInt();
  List<Dice> damageDice = [];
  int diceChange = 0;
  for (var i = 0; i < weapon.damageDice; i++) {
    damageDice.add(Dice.create(weapon.damageDiceSides));
  }

  // Check impact from base maneuvre
  if (specialAbilityBaseManeuvre != null) {
    SpecialAbilityImpact impact = SpecialAbilityImpact.derive(
      specialAbilityBaseManeuvre,
      weapon.ct,
      weapon,
      0,
    );
    if (impact.tpcallback != null) {
      tpMod += impact.tpcallback!(character);
    }
    tpMod += impact.tpMod;
    tpMult *= impact.tpMult;
    tpModAfterMultiplier += impact.tpModAfterMultiplier;
    if (impact.additionalDiceReplaceOriginal) {
      damageDice = impact.additionalDice;
      //TODO: Check if we want this behaviour.
      tpFlat = 0;
      diceChange = -5;
    } else {
      damageDice.addAll(impact.additionalDice);
      if (impact.additionalDice.isNotEmpty) {
        diceChange += 1;
      }
    }
  }
  // Check impact from special maneuvre
  if (specialAbilitySpecialManeuvre != null) {
    SpecialAbilityImpact impact = SpecialAbilityImpact.derive(
      specialAbilitySpecialManeuvre,
      weapon.ct,
      weapon,
      0,
    );
    if (impact.tpcallback != null) {
      tpMod += impact.tpcallback!(character);
    }
    tpMod += impact.tpMod;
    tpMult *= impact.tpMult;
    tpModAfterMultiplier += impact.tpModAfterMultiplier;
    if (impact.additionalDiceReplaceOriginal) {
      damageDice = impact.additionalDice;
      //TODO: Check if we want this behaviour.
      tpFlat = 0;
      diceChange = -5;
    } else {
      damageDice.addAll(impact.additionalDice);
      if (impact.additionalDice.isNotEmpty) {
        diceChange += 1;
      }
    }
  }

  List<TextSpan> result = [];
  if (tpMult == 1) {
    result.add(
      TextSpan(
        text: diceCountString(damageDice),
        style: diceChange == 0
            ? null
            : (diceChange <= 0 ? styleBad : styleGood),
      ),
    );
    if (tpFlat + tpMod + tpModAfterMultiplier != 0) {
      if (result.isNotEmpty && tpFlat + tpMod + tpModAfterMultiplier > 0) {
        result.add(const TextSpan(text: "+"));
      }
      result.add(
        TextSpan(
          text: "${tpFlat + tpMod + tpModAfterMultiplier}",
          style: tpMod + tpModAfterMultiplier == 0
              ? null
              : (tpMod + tpModAfterMultiplier <= 0 ? styleBad : styleGood),
        ),
      );
    }
  } else {
    String diceText = diceCountString(damageDice);
    if (diceText != "") {
      result.add(const TextSpan(text: "("));
      result.add(
        TextSpan(
          text: diceText,
          style: diceChange == 0
              ? null
              : (diceChange <= 0 ? styleBad : styleGood),
        ),
      );
    }
    if (tpFlat + tpMod != 0) {
      if (result.isNotEmpty && tpFlat + tpMod > 0) {
        result.add(const TextSpan(text: "+"));
        result.add(
          TextSpan(
            text: "${tpFlat + tpMod}",
            style: tpMod == 0 ? null : (tpMod <= 0 ? styleBad : styleGood),
          ),
        );
        result.add(const TextSpan(text: ")*"));
      }
    }
    if (result.isNotEmpty) {
      result.add(
        TextSpan(
          text: tpMult.toStringAsFixed(
            tpMult.truncateToDouble() == tpMult ? 0 : 1,
          ),
          style: tpMult <= 1 ? styleBad : styleGood,
        ),
      );
    }
    if (result.isNotEmpty && tpModAfterMultiplier != 0) {
      result.add(const TextSpan(text: "+"));
    }
    if (result.isEmpty || tpModAfterMultiplier != 0) {
      result.add(
        TextSpan(
          text: tpModAfterMultiplier.toString(),
          style: tpModAfterMultiplier <= 0 ? styleBad : styleGood,
        ),
      );
    }
  }

  return RichText(
    text: TextSpan(style: styleNormal, children: result),
  );
}

String diceCountString(List<Dice> damageDice) {
  final Map<int, int> counts = {};
  for (final dice in damageDice) {
    counts[dice.sides] = (counts[dice.sides] ?? 0) + 1;
  }
  // Example output: "2W6 + 1W8"
  return counts.entries.map((e) => "${e.value}W${e.key}").join("+");
}
