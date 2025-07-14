import '../models/rules.dart';
import '../models/special_abilities.dart';
import '../models/weapons.dart';
import '../models/skill.dart';
import '../models/character.dart';
import '../models/audit.dart';
import 'dice.dart';

sealed class ApplicableCombatTechniques {
  const ApplicableCombatTechniques();

  const factory ApplicableCombatTechniques.all() = _All;
  const factory ApplicableCombatTechniques.melee() = _Melee;
  const factory ApplicableCombatTechniques.ranged() = _Ranged;
  const factory ApplicableCombatTechniques.meleeWithParry() = _MeleeWithParry;
  const factory ApplicableCombatTechniques.meleeOneHanded() = _MeleeOneHanded;
  const factory ApplicableCombatTechniques.explicitById(List<String> ids) =
      _Explicit;
  const factory ApplicableCombatTechniques.explicitText(String text) =
      _ExplicitText;
}

class _All extends ApplicableCombatTechniques {
  const _All();
}

class _Melee extends ApplicableCombatTechniques {
  const _Melee();
}

class _Ranged extends ApplicableCombatTechniques {
  const _Ranged();
}

class _MeleeWithParry extends ApplicableCombatTechniques {
  const _MeleeWithParry();
}

class _MeleeOneHanded extends ApplicableCombatTechniques {
  const _MeleeOneHanded();
}

class _Explicit extends ApplicableCombatTechniques {
  final List<String> ids;
  const _Explicit(this.ids);
}

class _ExplicitText extends ApplicableCombatTechniques {
  final String text;
  const _ExplicitText(this.text);
}

class SpecialAbilityImpact {
  final int atMod;
  final int paMod;
  final int awMod;
  final int tpMod; // flat tp modifier, applied before multiplier
  final double tpMult; // tp multiplier
  final int tpModAfterMultiplier; // flat tp modifier, applied after multiplier
  final List<Dice> additionalDice;
  final bool additionalDiceReplaceOriginal;
  final int modifier;
  final List<AttributeRollResult> Function(CombatRoll, CombatActionType)?
  callback;
  final int Function(Character)? tpcallback;

  SpecialAbilityImpact(
    this.atMod,
    this.paMod,
    this.awMod,
    this.tpMod,
    this.tpMult,
    this.tpModAfterMultiplier,
    this.additionalDice,
    this.additionalDiceReplaceOriginal,
    this.modifier,
    this.callback,
    this.tpcallback,
  );

  factory SpecialAbilityImpact.none(int modifier) {
    return SpecialAbilityImpact(
      0,
      0,
      0,
      0,
      1,
      0,
      [],
      false,
      modifier,
      null,
      null,
    );
  }

  factory SpecialAbilityImpact.derive(
    SpecialAbility? spec,
    CombatTechnique? ct,
    Weapon? weapon,
    int modifier,
  ) {
    if (spec == null) {
      return SpecialAbilityImpact.none(modifier);
    }
    if (!abilityImpactsTechnique(spec, ct, weapon)) {
      return SpecialAbilityImpact.none(modifier);
    }

    int atMod = 0;
    int paMod = 0;
    int awMod = 0;
    int tpMod = 0;
    double tpMult = 1;
    int tpModAfterMultiplier = 0;
    List<Dice> additionalDice = [];
    bool additionalDiceReplaceOriginal = false;
    List<AttributeRollResult> Function(CombatRoll, CombatActionType)? callback;
    int Function(Character)? tpcallback;

    switch (spec.value) {
      case SpecialAbilityBase.eisenhagel:
      case SpecialAbilityBase.gegenhalten:
      case SpecialAbilityBase.schildspalter:
      case SpecialAbilityBase.schwitzkasten:
      case SpecialAbilityBase.unterlaufen:
      case SpecialAbilityBase.wurf:
        break;
      case SpecialAbilityBase.entwaffnen:
        callback = multiAttack([
          (-4, "Gegen Einhandwaffen"),
          (-6, "Gegen Zweihandwaffen"),
        ], modifier);
        break;
      case SpecialAbilityBase.finte:
        atMod = -(spec.tier ?? 0);
        break;
      case SpecialAbilityBase.haltegriff:
        callback = alternateCombatTechnique(CombatTechnique.raufen, modifier);
        break;
      case SpecialAbilityBase.hammerschlag:
      case SpecialAbilityBase.todesstoss:
        atMod = -2;
        additionalDice = [Dice.create(6)];
        break;
      case SpecialAbilityBase.lanzenangriff:
        // TODO: Probe auf Reiten -> Angriff Kriegslanze ->  TP um 2 + GS/2 des Reittiers
        break;
      case SpecialAbilityBase.praeziserSchussWurf:
      case SpecialAbilityBase.praeziserStich:
      case SpecialAbilityBase.wuchtschlag:
        atMod = -2 * (spec.tier ?? 0);
        tpMod = 2 * (spec.tier ?? 0);
        break;
      case SpecialAbilityBase.riposte:
        paMod = -2;
        break;
      case SpecialAbilityBase.rundumschlag:
        List<(int, String)> attacks = [
          (-2, "Erste Attacke"),
          (-6, "Zweite Attacke"),
          if (spec.tier == 2) (-10, "Dritte Attacke"),
        ];
        callback = multiAttack(attacks, modifier);
        break;
      case SpecialAbilityBase.sturmangriff:
        tpcallback = (character) => (character.getSpeed() / 2).round() + 2;
        break;
      case SpecialAbilityBase.vorstoss:
        atMod = 2;
        paMod = -20;
        awMod = -20;
        break;
      case SpecialAbilityBase.zuFallBringen:
        atMod = -4;
        additionalDice = [Dice.create(3)];
        additionalDiceReplaceOriginal = true;
        break;
      case SpecialAbilityBase.ballistischerSchuss:
      case SpecialAbilityBase.klingensturm:
      case SpecialAbilityBase.auflaufen:
      case SpecialAbilityBase.weitwurf:
        atMod = -2;
        break;
      case SpecialAbilityBase.betaeubungsschlag:
        atMod = -2;
        additionalDice = [Dice.create(3)];
        additionalDiceReplaceOriginal = true;
        break;
      case SpecialAbilityBase.festnageln:
      case SpecialAbilityBase.herunterstossen:
        atMod = -4;
        break;
      case SpecialAbilityBase.gezielterAngriff:
      case SpecialAbilityBase.gezielterSchuss:
        callback = multiAttack([
          (-10, "Kopf"),
          (-4, "Torso"),
          (-8, "Arme"),
          (-8, "Beine"),
        ], modifier);
        break;
      case SpecialAbilityBase.ausfall:
        List<(int, String)> attacks = [
          (-2, "Einleitende Attacke"),
          (-4, "Erste Zusatzattacke"),
          if (spec.tier == 2) (-6, "Zweite Zusatzattacke"),
        ];
        callback = multiAttack(attacks, modifier, paMod: -20, awMod: -20);
        break;
      case SpecialAbilityBase.blutgraetsche:
        atMod = -2;
        tpMod = 1;
        break;
      case SpecialAbilityBase.doppelangriff:
        List<(int, String)> attacks = [(-2, "Linke Hand"), (2, "Rechte Hand")];
        callback = multiAttack(attacks, modifier, paMod: -20, awMod: -20);
        break;
      case SpecialAbilityBase.durchgezogenerTritt:
      case SpecialAbilityBase.ellbogenangriff:
        atMod = -(spec.tier ?? 0);
        tpMod = spec.tier ?? 0;
        break;
      case SpecialAbilityBase.graetsche:
        paMod = -2;
        awMod = -2;
        atMod = -2;
        break;
      case SpecialAbilityBase.kraftvollerSpeerwurf:
        tpMod = 2;
        break;
      case SpecialAbilityBase.schildschlag:
        tpMult = 2;
        // TODO: TP *= 2 + kleinen/mittleren/großen Schild +–0/+1/+2 TP for other than default shields
        if (weapon != null) {
          switch (weapon.name) {
            case "Holzschild":
            case "Lederschild":
              tpModAfterMultiplier = 0;
              break;
            case "Thorwalerschild":
              tpModAfterMultiplier = 1;
              break;
            case "Großschild":
              tpModAfterMultiplier = 2;
              break;
            default:
              break;
          }
        }
        break;
      case SpecialAbilityBase.umrennen:
        atMod = -2;
        tpMult = 0.5;
        break;
      case SpecialAbilityBase.umwickeln:
        callback = probe(Skill.kraftakt, modifier);
        tpMult = 0;
        // TODO: AT/PA Gegner -= QS/2 (Probe Kraftakt)
        break;
      case SpecialAbilityBase.wirbelangriff:
        tpMod = -2;
        List<(int, String)> attacks = [
          (-2, "Erste Attacke"),
          (-4, "Zweite Attacke"),
          if (spec.tier == 2) (-6, "Dritte Attacke"),
        ];
        callback = multiAttack(attacks, modifier);
        break;
      default:
        break;
    }

    return SpecialAbilityImpact(
      atMod,
      paMod,
      awMod,
      tpMod,
      tpMult,
      tpModAfterMultiplier,
      additionalDice,
      additionalDiceReplaceOriginal,
      modifier,
      callback,
      tpcallback,
    );
  }

  int getApplicableMod(CombatActionType action) {
    switch (action) {
      case CombatActionType.attack:
        return atMod;
      case CombatActionType.parry:
        return paMod;
      case CombatActionType.dodge:
        return awMod;
    }
  }
}

bool abilityImpactsTechnique(
  SpecialAbility spec,
  CombatTechnique? ct,
  Weapon? weapon,
) {
  if (ct == null) {
    return true;
  }
  switch (spec.value.ct) {
    case _All():
      return true;
    case _Melee():
      return ct.group == CombatType.melee;
    case _MeleeOneHanded():
      return oneHandedCTs.contains(ct.id);
    case _MeleeWithParry():
      return ct.group == CombatType.melee && !ct.hasNoParry;
    case _Ranged():
      return ct.group == CombatType.range;
    case _Explicit(ids: final ids):
      return ids.contains(ct.id);
    case _ExplicitText():
      if (ct.id == "SA_158") {
        // Eisenhagel: "Diskusse (nur Stufe I), Wurfwaffen"
      } else if (ct.id == "SA_879") {
        // Kraftvoller Speerwurf: "Wurfwaffen (nur Wurfspeere)"
      } else {
        return false;
      }
  }
  return false;
}

List<AttributeRollResult> Function(CombatRoll, CombatActionType) multiAttack(
  List<(int, String)> atModsWithContext,
  int modifier, {
  int paMod = 0,
  int awMod = 0,
}) {
  return (CombatRoll roll, CombatActionType action) {
    if (action != CombatActionType.attack) {
      return [attributeRoll(roll.targetValue(action))];
    }
    List<AttributeRollResult> results = [];
    for (var (mod, context) in atModsWithContext) {
      ExplainedValue tgt = roll
          .targetValue(action)
          .addUnconditional(mod, context, true);
      var res = attributeRoll(tgt);
      res.resultContext = context;
      results.add(res);
    }
    return results;
  };
}

List<AttributeRollResult> Function(CombatRoll, CombatActionType) probe(
  Skill skill,
  int modifier, {
  int paMod = 0,
  int awMod = 0,
}) {
  return (CombatRoll roll, CombatActionType action) {
    if (action != CombatActionType.attack) {
      return [attributeRoll(roll.targetValue(action))];
    }
    final engine = SkillRoll.from(
      roll.character,
      SkillWrapper(skill),
      modifier,
    );
    final probeResult = engine.roll();
    List<AttributeRollResult> result = probeResult.rolls;
    return result;
  };
}

List<AttributeRollResult> Function(CombatRoll, CombatActionType)
alternateCombatTechnique(
  CombatTechnique ct,
  int modifier, {
  int paMod = 0,
  int awMod = 0,
}) {
  return (CombatRoll roll, CombatActionType action) {
    if (action != CombatActionType.attack) {
      return [attributeRoll(roll.targetValue(action))];
    }
    final engine = CombatRoll.fromTechnique(
      roll.character,
      ct,
      null,
      null,
      modifier,
    );
    return engine.roll(action);
  };
}
