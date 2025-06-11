import 'package:flutter/material.dart';
import 'dart:convert';
import '../models/attributes.dart';
import '../models/skill.dart';

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

  Character({
    required this.name,
    this.mu = 0,
    this.kl = 0,
    this.in_ = 10,
    this.ch = 10,
    this.ff = 10,
    this.ge = 10,
    this.ko = 10,
    this.kk = 10,
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
  });

  factory Character.fromJson(Map<String, dynamic> json) {
    var parts = json["avatar"].split(",");
    var avatarMimetype = parts.first;
    var content = parts.last;
    Character character = Character(
      name: json['name'],
      talents: {},
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
    return character;
  }

  Map<String, dynamic> toJson() {
    var result = {
      "name": name,
      "avatar": avatarMimetype != null ? "${avatarMimetype!},${base64Encode((avatar?.image as MemoryImage).bytes)}" : null,
      "talents": {},
      "attr": {"values": []}
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
