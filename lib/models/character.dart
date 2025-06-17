import 'package:flutter/material.dart';
import 'dart:convert';
import '../widgets/widget_helpers.dart';
import 'rules.dart';
import 'attributes.dart';
import 'skill.dart';
import 'weapons.dart';
import 'spells.dart';
import 'special_abilities.dart';

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
  CharacterState state;

  Map<Skill, int>? talents;

  Image? avatar;
  String? avatarMimetype;

  List<Weapon>? weapons;
  List<SpecialAbility>? abilities;
  Map<CombatTechnique, int>? combatTechniques;
  Map<Spell, int>? spells;

  Character({
    required this.name,
    this.mu = 0,
    this.kl = 0,
    this.in_ = 0,
    this.ch = 0,
    this.ff = 0,
    this.ge = 0,
    this.ko = 0,
    this.kk = 0,
    required this.state,
    this.talents,
    this.avatar,
    this.avatarMimetype,
    this.weapons,
    this.abilities,
    this.combatTechniques,
    this.spells,
  }) {
    talents ??= {};
    spells ??= {};
    weapons ??= [];
    abilities ??= [];
  }

  factory Character.fromJson(Map<String, dynamic> json) {
    var parts = json["avatar"].split(",");
    var avatarMimetype = parts.first;
    var content = parts.last;
    Character character = Character(
      name: json['name'],
      state: CharacterState.empty(),
      talents: {},
      weapons: [],
      avatar: Image.memory(base64Decode(content)),
      avatarMimetype: avatarMimetype,
      abilities: [],
      combatTechniques: {},
      spells: null,
    );
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
          character.abilities?.add(SpecialAbility(specialCombatAbilities[key]!, item["tier"]));
        }
      }
    });
    json['ct'].forEach((key, value) {
      character.combatTechniques?[combatTechniquesByID[key]!] = value;
    });
    if (json.containsKey("spells")) {
      character.spells = <Spell, int>{ for (var e in json["spells"].entries) spellsById[e.key]!: e.value.toInt() };
    }
    return character;
  }

  Map<String, dynamic> toJson() {
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
      "avatar": avatarMimetype != null
          ? "${avatarMimetype!},${base64Encode((avatar?.image as MemoryImage).bytes)}"
          : null,
      "talents": <String, int>{
        for (var v in talents!.entries) v.key.id: v.value,
      },
      "attr": {"values": values},
      "belongings": {"items": belongings},
      "activatable": abilitiesOut,
      "ct": <String, int>{ for (var v in combatTechniques!.entries) v.key.id: v.value },
    };
    for (Weapon w in weapons ?? []) {
      belongings[w.id] = w.toJson();
    }
    for (SpecialAbility a in abilities ?? []) {
      if (!abilitiesOut.containsKey(a.value.id)) {
        abilitiesOut[a.value.id] = [];
      } 
      abilitiesOut[a.value.id].add(a.toJson());
    }
    if (spells != null) {
      result["spells"] = {for (var s in spells!.entries) s.key.id: s.value};
    } 
    return result;
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
    return combatTechniques?[ct] ?? 6; // TODO: verify default value!
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
}