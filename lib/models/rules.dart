import 'package:eorla/managers/settings.dart';
import 'package:eorla/models/spells.dart';
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
import '../widgets/dice.dart';
import 'optional_rules.dart';

class DamageRollResult {
  List<Dice> dice;
  ExplainedValue combinedResult;
  DamageRollResult(this.dice, this.combinedResult);

  Widget widget(BuildContext context) {
    return damageResultsWidget(this, context);
  }

  Widget resultText(BuildContext context) {
    return damageText(this, context);
  }
}

class AttributeRollResult {
  final DiceValue? roll;
  final RollEvent event;
  final ExplainedValue targetValue;
  String? resultContext;

  AttributeRollResult(
    this.roll,
    this.event,
    this.targetValue, {
    this.resultContext,
  });

  Widget widget(BuildContext context) {
    return attributeRollResult(this, context);
  }

  Widget resultText(BuildContext context) {
    return attributeResultText(this, context);
  }

  List<Dice> get dice {
    // Confirmation throw => 1. die normal, 2. die event die
    if (roll?.confirmationThrow != null) {
      return [
        Dice.create(20, value: roll),
        Dice.create(20, value: roll, event: event),
      ];
    }
    // Otherwise just return the only die with the event (?)
    // TODO: Confirm if wanted behaviour
    return [Dice.create(20, value: roll, event: event)];
  }

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
      case RollEvent.none:
        return "Kein Ergebis definiert.";
    }
  }
}

class SkillRollResult {
  final List<AttributeRollResult> rolls;
  final Quality quality;

  SkillRollResult(this.rolls, this.quality);

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
      case RollEvent.none:
        return "Kein Ergebis definiert.";
    }
  }

  Widget resultText(BuildContext context) {
    return skillRollResultText(this, context);
  }

  String? addText<T extends Trial>(T skillOrSpell) {
    if (skillOrSpell is SkillWrapper) {
      Skill skill = skillOrSpell.skill;
      switch (quality.type) {
        case RollEvent.success:
          return skill.quality;
        case RollEvent.failure:
          return skill.failed;
        case RollEvent.critical:
          return skill.critical;
        case RollEvent.botch:
          return skill.botch;
        case RollEvent.none:
          return null;
      }
    } else if (skillOrSpell is SpellWrapper) {
      Spell spell = skillOrSpell.spell;
      return spell.ruleText();
    }
    return null;
  }

  Widget widget(BuildContext context) {
    return skillRollResultWidget(rolls, context);
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

  ExplainedValue get tgtValue1 {
    return ExplainedValue.base(
      attrValue1,
      "${attr1.short} Basis",
    ).add(modifier, "Modifikator").andThen(characterState.explain());
  }

  ExplainedValue get tgtValue2 {
    return ExplainedValue.base(
      attrValue2,
      "${attr2.short} Basis",
    ).add(modifier, "Modifikator").andThen(characterState.explain());
  }

  ExplainedValue get tgtValue3 {
    return ExplainedValue.base(
      attrValue3,
      "${attr3.short} Basis",
    ).add(modifier, "Modifikator").andThen(characterState.explain());
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

  bool isRoutine() {
    if (modifier < -3 ||
        attrValue1 < 13 ||
        attrValue2 < 13 ||
        attrValue3 < 13) {
      return false;
    }
    final fwMin = 10 - 3 * min(modifier, 3);
    return talentValue >= fwMin;
  }

  SkillRollResult routine() {
    final fp = (talentValue / 2).round();
    final qs = _qs(fp);
    return SkillRollResult([], Quality(RollEvent.success, qs));
  }

  int _qs(int fw) {
    int qs = max(min((fw - 1) ~/ 3 + 1, 6), 0);
    if (fw == 0) {
      qs = 1;
    }
    return qs;
  }

  SkillRollResult roll({Random? random, bool ignoreBotch = false}) {
    List<ExplainedValue> explanations = [];
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
      explanations.add(expl);
    }
    if (illegal) {
      return SkillRollResult([
        AttributeRollResult(
          null,
          RollEvent.failure,
          explanations[0],
          resultContext: attr1.name,
        ),
        AttributeRollResult(
          null,
          RollEvent.failure,
          explanations[1],
          resultContext: attr2.name,
        ),
        AttributeRollResult(
          null,
          RollEvent.failure,
          explanations[2],
          resultContext: attr3.name,
        ),
      ], Quality(RollEvent.failure, 0));
    }
    random ??= Random();
    int roll1 = random.nextInt(20) + 1;
    int roll2 = random.nextInt(20) + 1;
    int roll3 = random.nextInt(20) + 1;
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
    final qs = _qs(fw);
    return SkillRollResult([
      AttributeRollResult(
        DiceValue(roll1),
        roll1 == 1
            ? RollEvent.critical
            : (roll1 == 20 ? RollEvent.botch : RollEvent.none),
        tgtValue1,
        resultContext: attr1.name,
      ),
      AttributeRollResult(
        DiceValue(roll2),
        roll2 == 1
            ? RollEvent.critical
            : (roll2 == 20 ? RollEvent.botch : RollEvent.none),
        tgtValue2,
        resultContext: attr2.name,
      ),
      AttributeRollResult(
        DiceValue(roll3),
        roll3 == 1
            ? RollEvent.critical
            : (roll3 == 20 ? RollEvent.botch : RollEvent.none),
        tgtValue3,
        resultContext: attr3.name,
      ),
    ], Quality(event, qs));
  }
}

enum RollEvent { success, failure, critical, botch, none }

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
        tgt = tgt.add(weapon?.at ?? 0, "AT Mod ${weapon?.name}", isMod: false);
        break;
      case CombatActionType.parry:
        int pa = (ctValue / 2).ceil() + (max(parryPrimary - 8, 0) / 3).toInt();
        tgt = ExplainedValue.base(pa, "PA Basis");
        tgt = tgt.add(weapon?.pa ?? 0, "PA Mod ${weapon?.name}", isMod: false);
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
      );
    }
    tgt = tgt.andThen(character.state.explain()).add(modifier, "Modifikator");
    return tgt;
  }

  /// Rolls for an attribute check based on the given [CombatActionType] [action].
  /// Returns a list of [AttributeRollResult] representing the roll outcomes.
  List<AttributeRollResult> roll(CombatActionType action, {Random? random}) {
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

    return [attributeRoll(target, random: random)];
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
  ).add(modifier, "Modifikator").andThen(character.state.explain());
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
    );
  }
  int fw = target.value - roll;
  if (roll == 1) {
    int roll2 = Dice.create(20, event: RollEvent.critical).roll(random);
    int fw2 = target.value - roll2;
    if (fw2 >= 0) {
      return AttributeRollResult(
        DiceValue(roll, confirmationThrow: roll2),
        RollEvent.critical,
        target,
      );
    } else {
      return AttributeRollResult(
        DiceValue(roll, confirmationThrow: roll2),
        RollEvent.success,
        target,
      );
    }
  } else if (roll == 20) {
    int roll2 = Dice.create(20, event: RollEvent.botch).roll(random);
    int fw2 = target.value - roll2;
    if (fw2 >= 0 && roll2 != 20) {
      return AttributeRollResult(
        DiceValue(roll, confirmationThrow: roll2),
        RollEvent.failure,
        target,
      );
    } else {
      return AttributeRollResult(
        DiceValue(roll, confirmationThrow: roll2),
        RollEvent.botch,
        target,
      );
    }
  } else {
    if (fw >= 0) {
      return AttributeRollResult(DiceValue(roll), RollEvent.success, target);
    } else {
      return AttributeRollResult(DiceValue(roll), RollEvent.failure, target);
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
  ExplainedValue result = ExplainedValue.empty();
  List<Dice> damageDice = [];
  for (var i = 0; i < weapon.damageDice; i++) {
    Dice die = Dice.create(weapon.damageDiceSides);
    damageDice.add(die);
    result = result.add(
      die.roll(random),
      "${weapon.name} Würfel${weapon.damageDice > 1 ? i + 1 : ''}",
      isMod: false,
    );
  }
  result = result.add(weapon.damageFlat, "${weapon.name} Basis", isMod: false);
  result = result.add(
    max(primary - weapon.primaryThreshold, 0).toInt(),
    "Schadensbonus",
  );

  // Check impact from base maneuvre
  if (specialAbilityBaseManeuvre != null) {
    SpecialAbilityImpact impact = SpecialAbilityImpact.derive(
      specialAbilityBaseManeuvre,
      weapon.ct,
      weapon,
      0,
    );
    if (impact.tpcallback != null) {
      result = result.add(
        impact.tpcallback!(character),
        specialAbilityBaseManeuvre.toString(),
      );
    }
    if (impact.additionalDiceReplaceOriginal) {
      result = ExplainedValue.empty();
      damageDice = impact.additionalDice;
    } else {
      damageDice.addAll(impact.additionalDice);
    }
    for (var (i, die) in impact.additionalDice.indexed) {
      result = result.add(
        die.roll(random),
        "${specialAbilityBaseManeuvre.toString()} Würfel${impact.additionalDice.length > 1 ? i + 1 : ''}",
        isMod: false,
      );
    }
    result = result.add(impact.tpMod, specialAbilityBaseManeuvre.toString());
    result = result.mul(impact.tpMult, specialAbilityBaseManeuvre.toString());
    result = result.add(
      impact.tpModAfterMultiplier,
      specialAbilityBaseManeuvre.toString(),
    );
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
      result = result.add(
        impact.tpcallback!(character),
        specialAbilitySpecialManeuvre.toString(),
      );
    }
    if (impact.additionalDiceReplaceOriginal) {
      result = ExplainedValue.empty();
      damageDice = impact.additionalDice;
    } else {
      damageDice.addAll(impact.additionalDice);
    }
    for (var (i, die) in impact.additionalDice.indexed) {
      result = result.add(
        die.roll(random),
        "${specialAbilitySpecialManeuvre.toString()} Würfel${impact.additionalDice.length > 1 ? i + 1 : ''}",
        isMod: false,
      );
    }
    result = result.add(impact.tpMod, specialAbilitySpecialManeuvre.toString());
    result = result.mul(
      impact.tpMult,
      specialAbilitySpecialManeuvre.toString(),
    );
    result = result.add(
      impact.tpModAfterMultiplier,
      specialAbilitySpecialManeuvre.toString(),
    );
  }
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

String? getRuleText(
  AttributeRollResult result,
  CombatActionType action,
  CombatTechnique technique,
  Weapon? weapon,
  AppSettings settings, {
  Random? random,
}) {
  RuleMixin ruleEnum;
  CombatRuleType ruleType;
  random ??= Random();
  int w6() => random!.nextInt(6) + 1;
  int twoW6 = w6() + w6();
  switch (result.event) {
    case RollEvent.critical:
      ruleType = settings.critRules;
      switch (action) {
        case CombatActionType.attack:
          ruleEnum = CriticalAttack.from(twoW6);
          break;
        case CombatActionType.dodge:
        case CombatActionType.parry:
          if (technique.group == CombatType.range) {
            ruleEnum = CriticalDefenseRanged.from(twoW6);
          } else {
            ruleEnum = CriticalDefenseMelee.from(twoW6);
          }
          break;
      }
      break;
    case RollEvent.botch:
      ruleType = settings.botchRules;
      switch (action) {
        case CombatActionType.attack:
          if (technique.group == CombatType.range) {
            ruleEnum = BotchedAttackRanged.from(twoW6);
          } else {
            if ((weapon == null || technique == CombatTechnique.raufen) &&
                twoW6 < 7) {
              twoW6 += 5;
            }
            ruleEnum = BotchedAttackMelee.from(twoW6);
          }
          break;
        case CombatActionType.dodge:
        case CombatActionType.parry:
          if (technique == CombatTechnique.schilde) {
            if (action == CombatActionType.dodge && twoW6 < 7) {
              twoW6 += 5;
            }
            ruleEnum = BotchedDefenseShield.from(twoW6);
          } else {
            if ((weapon == null || technique == CombatTechnique.raufen) &&
                twoW6 < 7) {
              twoW6 += 5;
            }
            ruleEnum = BotchedDefenseNoShield.from(twoW6);
          }
          break;
      }
      break;
    default:
      return null;
  }

  switch (ruleType) {
    case CombatRuleType.normal:
      final (title, effect) = ruleEnum.normalRule();
      return "$title\n\n$effect";
    case CombatRuleType.table:
      return "${ruleEnum.title}\n\n${ruleEnum.effect}";
    case CombatRuleType.focus:
      final (title, effect) = ruleEnum.focusRule(random.nextInt(20) + 1);
      return "$title\n\n$effect";
  }
}
