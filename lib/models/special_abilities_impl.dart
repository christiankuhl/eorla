import 'dart:math';
import '../models/rules.dart';
import '../models/special_abilities.dart';
import '../models/weapons.dart';
import '../models/skill.dart';
import '../models/character.dart';

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
  final int tpMod;
  final List<AttributeRollResult> Function(CombatRoll, CombatActionType)?
  callback;
  final int modifier;
  final int Function(int, Character, Weapon)? tpcallback;

  SpecialAbilityImpact(
    this.atMod,
    this.paMod,
    this.awMod,
    this.tpMod,
    this.modifier,
    this.callback,
    this.tpcallback,
  );

  factory SpecialAbilityImpact.none(int modifier) {
    return SpecialAbilityImpact(0, 0, 0, 0, modifier, null, null);
  }

  factory SpecialAbilityImpact.fromActive(
    SpecialAbility spec,
    CombatTechnique? ct,
    Weapon? weapon,
    int modifier,
  ) {
    if (!abilityImpactsTechnique(spec, ct, weapon)) {
      return SpecialAbilityImpact.none(modifier);
    }

    int atMod = 0;
    int paMod = 0;
    int awMod = 0;
    int tpMod = 0;
    List<AttributeRollResult> Function(CombatRoll, CombatActionType)? callback;
    int Function(int, Character, Weapon)? tpcallback;

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
        tpMod = Random().nextInt(6) + 1;
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
        tpcallback = (roll, character, _) =>
            roll + (character.getSpeed() / 2).round() + 2;
        break;
      case SpecialAbilityBase.vorstoss:
        atMod = 2;
        paMod = -20;
        awMod = -20;
        break;
      case SpecialAbilityBase.zuFallBringen:
        atMod = -4;
        tpcallback = (_, _, _) => Random().nextInt(3) + 1;
        break;
      case SpecialAbilityBase.ballistischerSchuss:
      case SpecialAbilityBase.klingensturm:
      case SpecialAbilityBase.auflaufen:
      case SpecialAbilityBase.weitwurf:
        atMod = -2;
        break;
      case SpecialAbilityBase.betaeubungsschlag:
        atMod = -2;
        tpcallback = (_, _, _) => Random().nextInt(3) + 1;
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
        callback = alternateCombatTechnique(
          CombatTechnique.raufen,
          modifier - 2,
        );
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
        callback = alternateCombatTechnique(
          CombatTechnique.raufen,
          modifier - 2,
          paMod: paMod,
          awMod: awMod,
        );
        break;
      case SpecialAbilityBase.kraftvollerSpeerwurf:
        tpMod = 2;
        break;
      case SpecialAbilityBase.schildschlag:
        tpcallback = (roll, _, weapon) => 2 * roll;
        // TODO: TP *= 2 + kleinen/mittleren/großen Schild +–0/+1/+2 TP
        break;
      case SpecialAbilityBase.umrennen:
        atMod = -2;
        tpcallback = (roll, _, _) => (roll / 2).round();
        break;
      case SpecialAbilityBase.umwickeln:
        callback = probe(Skill.kraftakt, modifier);
        tpcallback = (_, _, _) => 0;
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
      modifier,
      callback,
      tpcallback,
    );
  }

  //FIXME: use callback.
  /// Returns the applicable modifier for a given [CombatRoll] and [CombatActionType].
  ///
  /// If a [callback] is not provided, this method returns the default modifier
  /// based on the [action] type:
  /// - For [CombatActionType.attack], returns [atMod].
  /// - For [CombatActionType.parry], returns [paMod].
  /// - For other action types, returns 0.
  ///
  /// If a [callback] is provided, it is intended to return a modifier based on
  /// the [roll] and [action], but this functionality is currently not implemented.
  ///
  /// Returns 0 if no applicable modifier is found.
  int getApplicableMod(CombatRoll roll, CombatActionType action) {
    if (callback == null) {
      switch (action) {
        case CombatActionType.attack:
          return atMod;
        case CombatActionType.parry:
          return paMod;
        default:
      }
    } else {
      //TODO: Modify callbacks to return a modifier.
      //return callback!(roll, action);
    }
    return 0;
  }

  // TODO: remove me!
  @Deprecated('Use getApplicableMod to get an integer modifier instead.')
  List<AttributeRollResult> apply(CombatRoll roll, CombatActionType action) {
    if (callback == null) {
      int tgt = roll.targetValue(action);
      switch (action) {
        case CombatActionType.attack:
          tgt += atMod;
          break;
        case CombatActionType.parry:
          tgt += paMod;
          break;
        default:
      }
      return [attributeRoll(tgt, modifier, roll.character.state)];
    } else {
      return callback!(roll, action);
    }
  }

  // TODO: Check if any tpcallback uses roll parameter.
  int applyDamage(Weapon weapon, Character character) {
    int roll = 0;
    if (tpcallback == null) {
      return roll + tpMod;
    }
    return tpcallback!(roll, character, weapon);
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
      return ct.group == CombatType.melee; // TODO: one handed weapons only
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
      return defaultDefense(roll, action, paMod, awMod, modifier);
    }
    List<AttributeRollResult> results = [];
    for (var (mod, context) in atModsWithContext) {
      int tgt = roll.targetValue(action) + mod;
      var res = attributeRoll(tgt, modifier, roll.character.state);
      res.context = context;
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
      return defaultDefense(roll, action, paMod, awMod, modifier);
    }
    final engine = SkillRoll.from(roll.character, SkillWrapper(skill));
    final probeResult = engine.roll(modifier);
    List<AttributeRollResult> result = [];
    result.add(
      AttributeRollResult(
        probeResult.roll1,
        probeResult.quality.type,
        probeResult.tgtValue1 ?? -1,
        context: engine.attr1.short,
      ),
    );
    result.add(
      AttributeRollResult(
        probeResult.roll2,
        probeResult.quality.type,
        probeResult.tgtValue2 ?? -1,
        context: engine.attr2.short,
      ),
    );
    result.add(
      AttributeRollResult(
        probeResult.roll3,
        probeResult.quality.type,
        probeResult.tgtValue3 ?? -1,
        context: engine.attr3.short,
      ),
    );
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
      return defaultDefense(roll, action, paMod, awMod, modifier);
    }
    final engine = CombatRoll.fromTechnique(roll.character, ct, null, null);
    return engine.roll(action, modifier);
  };
}

List<AttributeRollResult> defaultDefense(
  CombatRoll roll,
  CombatActionType action,
  int paMod,
  int awMod,
  int modifier,
) {
  int tgt = roll.targetValue(action);
  switch (action) {
    case CombatActionType.parry:
      tgt += paMod;
      break;
    case CombatActionType.dodge:
      tgt += awMod;
    default:
      break;
  }
  return [attributeRoll(tgt, modifier, roll.character.state)];
}
