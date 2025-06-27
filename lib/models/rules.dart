import 'character.dart';
import 'skill.dart';
import 'weapons.dart';
import 'attributes.dart';
import 'special_abilities.dart';
import 'special_abilities_impl.dart';
import 'dart:math';

class Dice {
  final int sides;
  int result = 0;

  Dice(this.sides);

  int roll([Random? rng]) {
    rng ??= Random();
    result = rng.nextInt(sides) + 1;
    return result;
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

  SkillRoll(
    this.attr1,
    this.attr2,
    this.attr3,
    this.attrValue1,
    this.attrValue2,
    this.attrValue3,
    this.talentValue,
    this.characterState,
  );

  factory SkillRoll.from(Character character, T skillOrSpell) {
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
    );
  }

  SkillRollResult roll(int modifier, {Random? random}) {
    for (var attrValue in [attrValue1, attrValue2, attrValue3]) {
      if (attrValue + modifier - characterState.value() < 1) {
        return SkillRollResult(null, null, null, Quality(RollEvent.failure, 0));
      }
    }
    random ??= Random();
    int roll1 = random.nextInt(20) + 1;
    int roll2 = random.nextInt(20) + 1;
    int roll3 = random.nextInt(20) + 1;
    int tgtValue1 = attrValue1 + modifier - characterState.value();
    int tgtValue2 = attrValue2 + modifier - characterState.value();
    int tgtValue3 = attrValue3 + modifier - characterState.value();
    int fw =
        talentValue +
        min(tgtValue1 - roll1, 0).toInt() +
        min(tgtValue2 - roll2, 0).toInt() +
        min(tgtValue3 - roll3, 0).toInt();
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
      tgtValue1: tgtValue1,
      tgtValue2: tgtValue2,
      tgtValue3: tgtValue3,
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
  int? tgtValue1;
  int? tgtValue2;
  int? tgtValue3;

  SkillRollResult(
    this.roll1,
    this.roll2,
    this.roll3,
    this.quality, {
    tgtValue1,
    tgtValue2,
    tgtValue3,
  });

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
  final int targetValue;
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
  final Character character;
  final SpecialAbility? specialAbilityBaseManeuvre;
  final SpecialAbility? specialAbilitySpecialManeuvre;

  CombatRoll(
    this.ct,
    this.ctValue,
    this.attackPrimary,
    this.parryPrimary,
    this.dodge,
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
  ) {
    return CombatRoll.fromTechnique(
      character,
      weapon.ct,
      specialAbilityBaseManeuvre,
      specialAbilitySpecialManeuvre,
      weapon: weapon,
    );
  }

  factory CombatRoll.fromTechnique(
    Character character,
    CombatTechnique ct,
    SpecialAbility? specialAbilityBaseManeuvre, 
    SpecialAbility? specialAbilitySpecialManeuvre, 
    {Weapon? weapon,}
  ) {
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
      character,
      weapon,
      specialAbilityBaseManeuvre,
      specialAbilitySpecialManeuvre,
    );
  }

  int targetValue(CombatActionType action) {
    switch (action) {
      case CombatActionType.attack:
        int at = ctValue + (max(attackPrimary - 8, 0) / 3).toInt();
        if (weapon != null) {
          at += weapon!.at;
        }
        return at;
      case CombatActionType.parry:
        int pa = (ctValue / 2).ceil() + (max(parryPrimary - 8, 0) / 3).toInt();
        if (weapon != null) {
          pa += weapon!.pa;
        }
        return pa;
      case CombatActionType.dodge:
        return dodge;
    }
  }

  /// Rolls for an attribute check based on the given [action] and [modifier].
  ///
  /// This method calculates the target value for the roll, applies any modifiers
  /// from special abilities (both base and special maneuvers), and returns a list
  /// of [AttributeRollResult] objects representing the outcome(s) of the roll.
  ///
  /// If a special ability impact provides a callback, that callback is used to
  /// determine the roll results. Otherwise, applicable modifiers from special
  /// abilities are added to the [modifier] parameter.
  ///
  /// - [action]: The type of combat action being performed.
  /// - [modifier]: The base modifier to apply to the roll.
  ///
  /// Returns a list of [AttributeRollResult] representing the roll outcomes.
  List<AttributeRollResult> roll(CombatActionType action, int modifier) {
    int target = targetValue(action);
    int modifierBaseManeuvre = 0;
    int modifierSpecialManeuvre = 0;
    if (specialAbilityBaseManeuvre != null) {
      SpecialAbilityImpact impact = SpecialAbilityImpact.fromActive(
        specialAbilityBaseManeuvre!,
        ct,
        weapon,
        modifier, //FIXME: should not be neccessairy
      );
      if (impact.callback != null) {
        // the impact define all rolls
        return impact.callback!(this, action);
      }
      modifierBaseManeuvre = impact.getApplicableMod(this, action);
    }
    if (specialAbilitySpecialManeuvre != null) {
      SpecialAbilityImpact impact = SpecialAbilityImpact.fromActive(
        specialAbilitySpecialManeuvre!,
        ct,
        weapon,
        modifier, //FIXME: should not be neccessairy
      );
      if (impact.callback != null) {
        // the impact define all rolls
        return impact.callback!(this, action);
      }
      modifierSpecialManeuvre = impact.getApplicableMod(this, action);
    }

    return [attributeRoll(target, modifier+modifierBaseManeuvre+modifierSpecialManeuvre, character.state)];
  }
}

//TODO: prettify this
AttributeRollResult attributeRoll(
  int attrValue,
  int modifier,
  CharacterState characterState, {
  Random? random,
}) {
  random ??= Random();
  int roll = random.nextInt(20) + 1;
  if (attrValue + modifier - characterState.value() < 1) {
    return AttributeRollResult(null, RollEvent.failure, attrValue + modifier);
  }
  int fw = attrValue + modifier - characterState.value() - roll;
  if (roll == 1) {
    int roll2 = random.nextInt(20) + 1;
    int fw2 = attrValue + modifier - characterState.value() - roll2;
    if (fw2 >= 0) {
      return AttributeRollResult(roll, RollEvent.critical, attrValue + modifier);
    } else {
      return AttributeRollResult(roll, RollEvent.success, attrValue + modifier);
    }
  } else if (roll == 20) {
    int roll2 = random.nextInt(20) + 1;
    int fw2 = attrValue + modifier - characterState.value() - roll2;
    if (fw2 >= 0 && roll2 != 20) {
      if (fw >= 0) {
        return AttributeRollResult(roll, RollEvent.success, attrValue + modifier);
      } else {
        return AttributeRollResult(roll, RollEvent.failure, attrValue + modifier);
      }
    } else {
      return AttributeRollResult(roll, RollEvent.botch, attrValue + modifier);
    }
  } else {
    if (fw >= 0) {
      return AttributeRollResult(roll, RollEvent.success, attrValue + modifier);
    } else {
      return AttributeRollResult(roll, RollEvent.failure, attrValue + modifier);
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
int damageRoll(
  Weapon weapon,
  Character character,
  SpecialAbility? specialAbilityBaseManeuvre,
  SpecialAbility? specialAbilitySpecialManeuvre,
  {Random? random,}
) {
  final primary = weapon.ct.primary
      .map((attr) => character.getAttribute(attr))
      .reduce((a, b) => a > b ? a : b);

  random ??= Random();
  int result = 0;
  int tpMod = 0;
  double tpMult = 1;
  int tpModAfterMultiplier = 0;
  int tpFlat = weapon.damageFlat + max(primary - weapon.primaryThreshold, 0).toInt();
  List<Dice> damageDice = [];
  for (var i = 0; i < weapon.damageDice; i++) {
    damageDice.add(Dice(weapon.damageDiceSides));
  }

  // Check impact from base maneuvre
  if (specialAbilityBaseManeuvre != null) {
    SpecialAbilityImpact impact = SpecialAbilityImpact.fromActive(
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
    SpecialAbilityImpact impact = SpecialAbilityImpact.fromActive(
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
  
  return result;
}
