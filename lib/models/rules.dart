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

enum DisplayMode { text, colored, fancy }

class GenerericRollResult {
  final List<Dice> dice;
  final String combinedResult;
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
    : super(dice, "$combinedResult", "Schaden");

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
                  text: combinedResult,
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

class AttributeRollResult extends GenerericRollResult {
  final DiceValue? roll;
  final RollEvent event;
  final ExplainedValue targetValue;
  String? resultContext;
  final Dice? checkDice;

  // Override the dice and combinedResult for the superclass
  // ignore: prefer_initializing_formals
  AttributeRollResult(
    this.roll,
    this.event,
    this.targetValue,
    Dice die, {
    this.resultContext,
    this.checkDice,
  }) : super(
         checkDice != null ? [die, checkDice] : [die],
         (() {
           // Use the text() method for combinedResult
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
         })(),
         "I AM ERROR",
       );

  @Deprecated("Get text from combinedResult instead")
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

  @override
  Widget resultsWidget(BuildContext context) {
    return IntrinsicHeight(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: dice
                .map(
                  (d) => Padding(
                    padding: const EdgeInsets.only(left: 12.0, right: 40.0),
                    child: d.displayWidget(
                      context,
                      displayMode: DisplayMode.fancy,
                      topRight: Text("≤ ${targetValue.value}"),
                      bottomRight: d.result <= targetValue.value
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
                    text: combinedResult,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class SkillRollResult extends GenerericRollResult {
  final List<AttributeRollResult> rolls;
  final Quality quality;

  SkillRollResult(this.rolls, this.quality)
    : super(
        [rolls[0].dice[0], rolls[1].dice[0], rolls[2].dice[0]],
        (() {
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
        })(),
        "I AM ERROR",
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

  RichText resultText(BuildContext context) {
    switch (quality.type) {
      case RollEvent.success:
        return RichText(
          text: TextSpan(
            style: Theme.of(context).textTheme.bodyMedium,
            children: [
              TextSpan(
                text: "Erfolg! (",
                style: Theme.of(
                  context,
                ).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w400, fontSize: 18),
              ),
              TextSpan(
                text: "QS: ${quality.qs}",
                style: Theme.of(
                  context,
                ).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w900, fontSize: 18),
              ),
              TextSpan(
                text: ")",
                style: Theme.of(
                  context,
                ).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w400, fontSize: 18),
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
                text: text(),
                style: Theme.of(
                  context,
                ).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600, fontSize: 18),
              ),
            ],
          ),
        );
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

  @override
  Widget resultsWidget(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Column(
          children: rolls
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
        resultText(context),
      ],
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
  final Dice dice1;
  final Dice dice2;
  final Dice dice3;

  ExplainedValue get tgtValue1 {
    return ExplainedValue.base(
      attrValue1,
      "${attr1.short} Basis",
    ).add(modifier, "Modifikator", true).andThen(characterState.explain());
  }

  ExplainedValue get tgtValue2 {
    return ExplainedValue.base(
      attrValue2,
      "${attr2.short} Basis",
    ).add(modifier, "Modifikator", true).andThen(characterState.explain());
  }

  ExplainedValue get tgtValue3 {
    return ExplainedValue.base(
      attrValue3,
      "${attr3.short} Basis",
    ).add(modifier, "Modifikator", true).andThen(characterState.explain());
  }

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
    this.dice1,
    this.dice2,
    this.dice3,
  );

  factory SkillRoll.from(Character character, T skillOrSpell, int modifier) {
    Attribute attr1 = skillOrSpell.attr1;
    Attribute attr2 = skillOrSpell.attr2;
    Attribute attr3 = skillOrSpell.attr3;
    int attrValue1 = character.getAttribute(attr1);
    int attrValue2 = character.getAttribute(attr2);
    int attrValue3 = character.getAttribute(attr3);
    int talentValue = character.getTalentOrSpell(skillOrSpell);

    Dice dice1 = Dice.create(20);
    Dice dice2 = Dice.create(20);
    Dice dice3 = Dice.create(20);

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
      dice1,
      dice2,
      dice3,
    );
  }

  SkillRollResult roll({Random? random, bool ignoreBotch = false}) {
    List<ExplainedValue> explainations = [];
    bool illegal = false;
    for (var effFW in [tgtValue1, tgtValue2, tgtValue3]) {
      ExplainedValue? expl;
      if (effFW.value < 1) {
        expl = effFW.addUnconditional(
          0,
          "Ein Wurf mit einem effektiven FW < 1 darf nicht versucht werden",
          false,
        );
        illegal = true;
      } else {
        expl = effFW;
      }
      explainations.add(expl);
    }
    if (illegal) {
      return SkillRollResult([
        AttributeRollResult(
          null,
          RollEvent.failure,
          explainations[0],
          dice1,
          resultContext: attr1.name,
        ),
        AttributeRollResult(
          null,
          RollEvent.failure,
          explainations[1],
          dice2,
          resultContext: attr2.name,
        ),
        AttributeRollResult(
          null,
          RollEvent.failure,
          explainations[2],
          dice3,
          resultContext: attr3.name,
        ),
      ], Quality(RollEvent.failure, 0));
    }
    random ??= Random();
    int roll1 = dice1.roll(random);
    int roll2 = dice2.roll(random);
    int roll3 = dice3.roll(random);
    int fw =
        talentValue +
        min(tgtValue1.value - roll1, 0).toInt() +
        min(tgtValue2.value - roll2, 0).toInt() +
        min(tgtValue3.value - roll3, 0).toInt();
    List<int> rolls = [roll1, roll2, roll3];
    bool botch = rolls.where((n) => n == 20).length >= 2;
    bool critical = rolls.where((n) => n == 1).length >= 2;
    RollEvent event;
    if (botch && !ignoreBotch) {
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
    return SkillRollResult([
      AttributeRollResult(
        DiceValue(roll1),
        event,
        tgtValue1,
        dice1,
        resultContext: attr1.name,
      ),
      AttributeRollResult(
        DiceValue(roll2),
        event,
        tgtValue2,
        dice2,
        resultContext: attr2.name,
      ),
      AttributeRollResult(
        DiceValue(roll3),
        event,
        tgtValue3,
        dice3,
        resultContext: attr3.name,
      ),
    ], Quality(event, qs));
  }
}

enum RollEvent { success, failure, critical, botch }

class Quality {
  RollEvent type;
  int qs;

  Quality(this.type, this.qs);
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
        tgt = tgt.add(weapon?.at ?? 0, "AT Mod ${weapon?.name}", false);
        break;
      case CombatActionType.parry:
        int pa = (ctValue / 2).ceil() + (max(parryPrimary - 8, 0) / 3).toInt();
        tgt = ExplainedValue.base(pa, "PA Basis");
        tgt = tgt.add(weapon?.pa ?? 0, "PA Mod ${weapon?.name}", false);
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
    tgt = tgt
        .andThen(character.state.explain())
        .add(modifier, "Modifikator", true);
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
  Dice dice = Dice.create(20);
  int roll = dice.roll(random);
  if (target.value < 1) {
    return AttributeRollResult(
      null,
      RollEvent.failure,
      target.addUnconditional(
        0,
        "Ein Wurf mit einem effektiven FW < 1 darf nicht versucht werden",
        true,
      ),
      dice,
    );
  }
  int fw = target.value - roll;
  if (roll == 1) {
    Dice checkDice = D20DiceCritical();
    int roll2 = checkDice.roll(random);
    int fw2 = target.value - roll2;
    if (fw2 >= 0) {
      return AttributeRollResult(
        DiceValue(roll, confirmationThrow: roll2),
        RollEvent.critical,
        target,
        dice,
        checkDice: checkDice,
      );
    } else {
      return AttributeRollResult(
        DiceValue(roll, confirmationThrow: roll2),
        RollEvent.success,
        target,
        dice,
        checkDice: checkDice,
      );
    }
  } else if (roll == 20) {
    Dice checkDice = D20DiceBotch();
    int roll2 = checkDice.roll(random);
    int fw2 = target.value - roll2;
    if (fw2 >= 0 && roll2 != 20) {
      if (fw >= 0) {
        return AttributeRollResult(
          DiceValue(roll, confirmationThrow: roll2),
          RollEvent.success,
          target,
          dice,
          checkDice: checkDice,
        );
      } else {
        return AttributeRollResult(
          DiceValue(roll, confirmationThrow: roll2),
          RollEvent.failure,
          target,
          dice,
          checkDice: checkDice,
        );
      }
    } else {
      return AttributeRollResult(
        DiceValue(roll, confirmationThrow: roll2),
        RollEvent.botch,
        target,
        dice,
        checkDice: checkDice,
      );
    }
  } else {
    if (fw >= 0) {
      return AttributeRollResult(
        DiceValue(roll),
        RollEvent.success,
        target,
        dice,
      );
    } else {
      return AttributeRollResult(
        DiceValue(roll),
        RollEvent.failure,
        target,
        dice,
      );
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
