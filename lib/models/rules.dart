import 'character.dart';
import 'skill.dart';
import 'attributes.dart';
import 'dart:math';

class SkillRoll {
  final Attribute attr1;
  final Attribute attr2;
  final Attribute attr3;
  final int attrValue1;
  final int attrValue2;
  final int attrValue3;
  final int talentValue;
  final int belastung;
  final int betaeubung;
  final int entrueckung;
  final int furcht;
  final int paralyse;
  final int schmerz;
  final int verwirrung;

  SkillRoll(
    this.attr1,
    this.attr2,
    this.attr3,
    this.attrValue1,
    this.attrValue2,
    this.attrValue3,
    this.talentValue,
    this.belastung,
    this.betaeubung,
    this.entrueckung,
    this.furcht,
    this.paralyse,
    this.schmerz,
    this.verwirrung,
  );

  factory SkillRoll.from(Character character, Skill skill) {
    Attribute attr1 = skill.attr1;
    Attribute attr2 = skill.attr2;
    Attribute attr3 = skill.attr3;
    int attrValue1 = character.getAttribute(attr1);
    int attrValue2 = character.getAttribute(attr2);
    int attrValue3 = character.getAttribute(attr3);
    int talentValue = character.talents![skill] ?? 0;
    int belastung = character.belastung;
    int betaeubung = character.betaeubung;
    int entrueckung = character.entrueckung;
    int furcht = character.furcht;
    int paralyse = character.paralyse;
    int schmerz = character.schmerz;
    int verwirrung = character.verwirrung;
    return SkillRoll(
      attr1,
      attr2,
      attr3,
      attrValue1,
      attrValue2,
      attrValue3,
      talentValue,
      belastung,
      betaeubung,
      entrueckung,
      furcht,
      paralyse,
      schmerz,
      verwirrung,
    );
  }

  RollResult roll(int modifier) {
    int roll1 = Random().nextInt(20) + 1;
    int roll2 = Random().nextInt(20) + 1;
    int roll3 = Random().nextInt(20) + 1;
    int state =
        belastung +
        betaeubung +
        entrueckung +
        furcht +
        paralyse +
        schmerz +
        verwirrung;
    int fw =
        talentValue +
        min(attrValue1 + modifier - state - roll1, 0).toInt() +
        min(attrValue2 + modifier - state - roll2, 0).toInt() +
        min(attrValue3 + modifier - state - roll3, 0).toInt();
    List<int> rolls = [roll1, roll2, roll3];
    bool botch = rolls.where((n) => n == 20).length >= 2;
    bool critical = rolls.where((n) => n == 20).length >= 2;
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
    return RollResult(roll1, roll2, roll3, Quality(event, qs));
  }
}

enum RollEvent { success, failure, critical, botch }

class Quality {
  RollEvent type;
  int qs;

  Quality(this.type, this.qs);
}

class RollResult {
  final int roll1;
  final int roll2;
  final int roll3;
  final Quality quality;

  RollResult(this.roll1, this.roll2, this.roll3, this.quality);

  String text() {
    switch (quality.type) {
      case RollEvent.success:
        return "Erfolg! (QS: ${quality.qs})";
      case RollEvent.failure:
        return "Fehlschlag!";
      case RollEvent.critical:
        return "Kritischer Erfolg!";
      case RollEvent.botch:
        return "Kritischer Fehlschlag";
    }
  }

  String addText(Skill skill) {
    switch (quality.type) {
      case RollEvent.success:
        return "";
      case RollEvent.failure:
        return "";
      case RollEvent.critical:
        return skill.critical;
      case RollEvent.botch:
        return skill.botch;
    }
  }
}
