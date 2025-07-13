import 'package:eorla/models/optolith.dart';
import 'package:flutter/material.dart';
import '../widgets/widget_helpers.dart';
import 'rules.dart';
import 'attributes.dart';
import 'skill.dart';
import 'weapons.dart';
import 'spells.dart';
import 'special_abilities.dart';
import 'avatar.dart';
import 'races.dart';
import 'audit.dart';

class Character {
  final String name;
  int mu;
  int kl;
  int in_;
  int ch;
  int ff;
  int ge;
  int ko;
  int kk;
  int lp;
  Race race;
  CharacterState state;
  Map<Skill, int>? talents;
  Avatar avatar;
  List<Weapon>? weapons;
  List<SpecialAbility>? abilities;
  Map<CombatTechnique, int>? combatTechniques;
  Map<Spell, int>? spells;
  Optolith optolith;

  Character({
    required this.name,
    // 8 is the default value used by Optolith. We need to set this here, since character export in Optolith omits entries
    // that are on their default values.
    this.mu = 8,
    this.kl = 8,
    this.in_ = 8,
    this.ch = 8,
    this.ff = 8,
    this.ge = 8,
    this.ko = 8,
    this.kk = 8,
    this.lp = 0,
    this.race = Race.menschen,
    required this.state,
    this.talents,
    required this.avatar,
    this.weapons,
    this.abilities,
    this.combatTechniques,
    this.spells,
    required this.optolith,
  }) {
    talents ??= {};
    spells ??= {};
    weapons ??= [];
    abilities ??= [];
  }

  factory Character.fromJson(Map<String, dynamic> json) {
    Character character = Character(
      name: json['name'],
      state: CharacterState.empty(),
      talents: {},
      weapons: [],
      avatar: Avatar.fromJson(json["avatar"]),
      abilities: [],
      combatTechniques: {},
      spells: null,
      optolith: Optolith(json),
    );
    character.race = racesById[json["r"]] ?? Race.menschen;
    for (var item in json['attr']['values']) {
      String id = item['id'];
      int value = item['value'];
      String? fieldName = attributeKeys[id]?.short;
      if (fieldName != null) {
        setCharacterField(character, fieldName, value);
      }
    }
    json['talents'].forEach((key, value) {
      var skill = skillKeys[key]!;
      character.talents![skill] = value;
    });
    json['belongings']['items'].forEach((key, value) {
      if (isWeapon(value)) {
        character.weapons?.add(Weapon.fromJson(value));
      }
    });
    json['activatable'].forEach((key, value) {
      if (specialCombatAbilities.containsKey(key)) {
        for (var item in value) {
          if ((item["tier"] ?? 0) > 1) {
            for (var tier = 1; tier <= item["tier"]; tier++) {
              character.abilities?.add(
                SpecialAbility(
                  specialCombatAbilities[key]!,
                  tier,
                  lowerTier: tier < item["tier"],
                ),
              );
            }
          } else {
            character.abilities?.add(
              SpecialAbility(specialCombatAbilities[key]!, item["tier"]),
            );
          }
        }
      }
    });
    json['ct'].forEach((key, value) {
      character.combatTechniques?[combatTechniquesByID[key]!] = value;
    });
    if (json.containsKey("spells")) {
      character.spells = <Spell, int>{
        for (var e in json["spells"].entries)
          spellsById[e.key]!: e.value.toInt(),
      };
    }
    character.lp = character.getHealthMax();
    return character;
  }

  Map<dynamic, dynamic> toJson() {
    var values = [
      {"id": "ATTR_1", "value": mu},
      {"id": "ATTR_2", "value": kl},
      {"id": "ATTR_3", "value": in_},
      {"id": "ATTR_4", "value": ch},
      {"id": "ATTR_5", "value": ff},
      {"id": "ATTR_6", "value": ge},
      {"id": "ATTR_7", "value": ko},
      {"id": "ATTR_8", "value": kk},
    ];
    var belongings = {};
    var abilitiesOut = {};
    var result = {
      "name": name,
      "avatar": avatar.toJson(),
      "talents": <String, int>{
        for (var v in talents!.entries) v.key.id: v.value,
      },
      "attr": <String, dynamic>{"values": values},
      "belongings": {"items": belongings},
      "activatable": abilitiesOut,
      "ct": <String, int>{
        for (var v in combatTechniques!.entries) v.key.id: v.value,
      },
    };
    for (Weapon w in weapons ?? []) {
      belongings[w.id] = w.toJson();
    }
    for (SpecialAbility a in abilities ?? []) {
      if (a.lowerTier) continue;
      if (!abilitiesOut.containsKey(a.value.id)) {
        abilitiesOut[a.value.id] = [];
      }
      abilitiesOut[a.value.id].add(a.toJson());
    }
    if (spells != null) {
      result["spells"] = {for (var s in spells!.entries) s.key.id: s.value};
    }
    return optolith.toJson(result);
  }

  int getAttribute(Attribute attr) {
    switch (attr) {
      case Attribute.charisma:
        return ch;
      case Attribute.fingerfertigkeit:
        return ff;
      case Attribute.gewandtheit:
        return ge;
      case Attribute.intuition:
        return in_;
      case Attribute.klugheit:
        return kl;
      case Attribute.koerperkraft:
        return kk;
      case Attribute.konstitution:
        return ko;
      case Attribute.mut:
        return mu;
    }
  }

  int getCT(CombatTechnique ct) {
    return combatTechniques?[ct] ??
        6; // This is the default value used by Optolith
  }

  bool hasSpells() {
    return spells != null && spells!.isNotEmpty;
  }

  int getTalentOrSpell(Trial talentOrSpell) {
    if (talentOrSpell is SkillWrapper) {
      return talents![talentOrSpell.skill] ?? 0;
    } else if (talentOrSpell is SpellWrapper) {
      return spells![talentOrSpell.spell] ?? 0;
    } else {
      throw UnsupportedError('Unknown type ${talentOrSpell.runtimeType}');
    }
  }

  int getSpeed() {
    int base = race.mov;
    Map<String, dynamic> activatables = optolith.data["activatable"];
    final bool maimed = activatables.containsKey("DISADV_51");
    if (maimed) base = (base / 2).round();
    final bool nimble = activatables.containsKey("ADV_9");
    final bool lightfooted = activatables.containsKey("ADV_92");
    final bool slow = activatables.containsKey("DISADV_4");
    if (nimble) base += 1;
    if (lightfooted) base += 1;
    if (slow) base -= 1;
    return base;
  }

  int getHealthMax() {
    int base = race.lp + 2 * ko;
    Map<String, dynamic> activatables = optolith.data["activatable"];
    final incLP = activatables["ADV_25"] ?? [];
    final decLP = activatables["DISADV_28"] ?? [];
    final int lostLP = (optolith.data["attr"]["permanentLP"] ?? {"lost": 0})["lost"];
    base -= lostLP;
    if (incLP.length == 1) base += (activatables["ADV_25"][0]["tier"] ?? 0) as int;
    if (decLP.length == 1) base -= (activatables["DISADV_28"][0]["tier"] ?? 0) as int;
    final int addedLP = optolith.data["attr"]["lp"];
    base += addedLP;
    return base;
  }
}

void setCharacterField(Character character, String fieldName, int value) {
  switch (fieldName) {
    case "MU":
      character.mu = value;
      break;
    case "KL":
      character.kl = value;
      break;
    case "IN":
      character.in_ = value;
      break;
    case "CH":
      character.ch = value;
      break;
    case "FF":
      character.ff = value;
      break;
    case "GE":
      character.ge = value;
      break;
    case "KO":
      character.ko = value;
      break;
    case "KK":
      character.kk = value;
      break;
    default:
      debugPrint('Unknown field: $fieldName');
  }
}

bool isWeapon(Map<String, dynamic> item) {
  return item.containsKey("combatTechnique");
}

class CharacterState {
  int belastung = 0;
  int betaeubung = 0;
  int entrueckung = 0;
  int furcht = 0;
  int paralyse = 0;
  int schmerz = 0;
  int verwirrung = 0;

  CharacterState(
    this.belastung,
    this.betaeubung,
    this.entrueckung,
    this.furcht,
    this.paralyse,
    this.schmerz,
    this.verwirrung,
  );

  factory CharacterState.empty() {
    return CharacterState(0, 0, 0, 0, 0, 0, 0);
  }

  int value() {
    return belastung +
        betaeubung +
        entrueckung +
        furcht +
        paralyse +
        schmerz +
        verwirrung;
  }

  List<String> getTexts() {
    List<String> states = [];
    if (belastung > 0) {
      states.add("Belastung Stufe ${roman(belastung)}");
    }
    if (betaeubung > 0) {
      states.add("Betäubung Stufe ${roman(betaeubung)}");
    }
    if (entrueckung > 0) {
      states.add("Entrückung Stufe ${roman(entrueckung)}");
    }
    if (furcht > 0) {
      states.add("Furcht Stufe ${roman(furcht)}");
    }
    if (paralyse > 0) {
      states.add("Paralyse Stufe ${roman(paralyse)}");
    }
    if (schmerz > 0) {
      states.add("Schmerz Stufe ${roman(schmerz)}");
    }
    if (verwirrung > 0) {
      states.add("Verwirrung Stufe ${roman(verwirrung)}");
    }
    return states;
  }

  List<ComponentWithExplanation> explain() {
    List<ComponentWithExplanation> states = [];
    if (belastung > 0) {
      states.add(ComponentWithExplanation(-belastung, "Belastung Stufe ${roman(belastung)}", true));
    }
    if (betaeubung > 0) {
      states.add(ComponentWithExplanation(-betaeubung, "Betäubung Stufe ${roman(betaeubung)}", true));
    }
    if (entrueckung > 0) {
      states.add(ComponentWithExplanation(-entrueckung, "Entrückung Stufe ${roman(entrueckung)}", true));
    }
    if (furcht > 0) {
      states.add(ComponentWithExplanation(-furcht, "Furcht Stufe ${roman(furcht)}", true));
    }
    if (paralyse > 0) {
      states.add(ComponentWithExplanation(-paralyse, "Paralyse Stufe ${roman(paralyse)}", true));
    }
    if (schmerz > 0) {
      states.add(ComponentWithExplanation(-schmerz, "Schmerz Stufe ${roman(schmerz)}", true));
    }
    if (verwirrung > 0) {
      states.add(ComponentWithExplanation(-verwirrung, "Verwirrung Stufe ${roman(verwirrung)}", true));
    }
    return states;
  }
}

int painLevel(Character c) {
  final m = c.getHealthMax();
  final lvls = [(0.75*m).round(), (0.5*m).round(), (0.25*m).round(), 5, -1];
  final lvl = lvls.indexWhere((l) => l < c.lp);
  return lvl;
}