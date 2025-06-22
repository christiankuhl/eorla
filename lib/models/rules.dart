import 'character.dart';
import 'skill.dart';
import 'weapons.dart';
import 'attributes.dart';
import 'dart:math';

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
    int fw =
        talentValue +
        min(attrValue1 + modifier - characterState.value() - roll1, 0).toInt() +
        min(attrValue2 + modifier - characterState.value() - roll2, 0).toInt() +
        min(attrValue3 + modifier - characterState.value() - roll3, 0).toInt();
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
    return SkillRollResult(roll1, roll2, roll3, Quality(event, qs));
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

  SkillRollResult(this.roll1, this.roll2, this.roll3, this.quality);

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

  AttributeRollResult(this.roll, this.event);

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
  final CombatTechnique? ct;
  final int ctValue;
  final int parryPrimary;
  final int attackPrimary;
  final int dodge;
  final CharacterState characterState;

  CombatRoll(
    this.ct,
    this.ctValue,
    this.attackPrimary,
    this.parryPrimary,
    this.dodge,
    this.characterState,
    this.weapon,
  );
  // TODO: Sonderfertigkeiten!
  factory CombatRoll.fromWeapon(Character character, Weapon weapon) {
    return CombatRoll.fromTechnique(character, weapon.ct, weapon: weapon);
  }

  factory CombatRoll.fromTechnique(Character character, CombatTechnique ct, {Weapon? weapon}) {
    final attackPrimary = character.getAttribute(
      ct.group == CombatType.melee
          ? Attribute.mut
          : Attribute.fingerfertigkeit,
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
      character.state,
      weapon,
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

  AttributeRollResult roll(CombatActionType action, int modifier) {
    return attributeRoll(targetValue(action), modifier, characterState);
  }
}

AttributeRollResult attributeRoll(
  int atValue,
  int modifier,
  CharacterState characterState,
  {Random? random}
) {
  random ??= Random();
  int roll = random.nextInt(20) + 1;
  if (atValue + modifier - characterState.value() < 1) {
    return AttributeRollResult(null, RollEvent.failure);
  }
  int fw = atValue + modifier - characterState.value() - roll;
  if (roll == 1) {
    int roll2 = random.nextInt(20) + 1;
    int fw2 = atValue + modifier - characterState.value() - roll2;
    if (fw2 >= 0) {
      return AttributeRollResult(roll, RollEvent.critical);
    } else {
      return AttributeRollResult(roll, RollEvent.success);
    }
  } else if (roll == 20) {
    int roll2 = random.nextInt(20) + 1;
    int fw2 = atValue + modifier - characterState.value() - roll2;
    if (fw2 >= 0 && roll2 != 20) {
      if (fw >= 0) {
        return AttributeRollResult(roll, RollEvent.success);
      } else {
        return AttributeRollResult(roll, RollEvent.failure);
      }
    } else {
      return AttributeRollResult(roll, RollEvent.botch);
    }
  } else {
    if (fw >= 0) {
      return AttributeRollResult(roll, RollEvent.success);
    } else {
      return AttributeRollResult(roll, RollEvent.failure);
    }
  }
}

int damageRoll(Weapon weapon, Character character) {
  final primary = weapon.ct.primary
      .map((attr) => character.getAttribute(attr))
      .reduce((a, b) => a > b ? a : b);
  int roll =
      weapon.damageFlat + max(primary - weapon.primaryThreshold, 0).toInt();
  for (var i = 0; i < weapon.damageDice; i++) {
    roll += Random().nextInt(weapon.damageDiceSides) + 1;
  }
  return roll;
}
