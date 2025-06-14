import 'package:flutter/material.dart';
import 'dart:convert';
import '../models/attributes.dart';
import '../models/skill.dart';
import '../models/weapons.dart';

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

  int belastung;
  int betaeubung;
  int entrueckung;
  int furcht;
  int paralyse;
  int schmerz;
  int verwirrung;

  Map<Skill, int>? talents;

  Image? avatar;
  String? avatarMimetype;

  List<Weapon>? weapons;

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
    this.talents,
    this.belastung = 0,
    this.betaeubung = 0,
    this.entrueckung = 0,
    this.furcht = 0,
    this.paralyse = 0,
    this.schmerz = 0,
    this.verwirrung = 0,
    this.avatar,
    this.avatarMimetype,
    this.weapons,
  });

  factory Character.fromJson(Map<String, dynamic> json) {
    var parts = json["avatar"].split(",");
    var avatarMimetype = parts.first;
    var content = parts.last;
    Character character = Character(
      name: json['name'],
      talents: {},
      weapons: [],
      avatar: Image.memory(base64Decode(content)),
      avatarMimetype: avatarMimetype,
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
    var result = {
      "name": name,
      "avatar": avatarMimetype != null
          ? "${avatarMimetype!},${base64Encode((avatar?.image as MemoryImage).bytes)}"
          : null,
      "talents": <String, int>{
        for (var v in talents!.entries) v.key.id: v.value,
      },
      "attr": {"values": values},
    };
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