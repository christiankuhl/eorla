import 'attributes.dart';
import 'character.dart';
import 'skill.dart';
import 'spells.dart';
import 'weapons.dart';

typedef UpgradeHandler = void Function()?;
typedef StateCallback = Function(void Function());

enum Upgrade {
  attribute,
  skill,
  spell,
  combatTechnique,
  healthPoints,
  astralPoints,
  karmicPoints,
  liturgy,
  cantrip,
  blessing,
  advantage,
  disadvantage,
  ability;

  @override
  String toString() {
    switch (this) {
      case Upgrade.attribute:
        return "attr";
      case Upgrade.skill:
        return "skill";
      case Upgrade.spell:
        return "spell";
      case Upgrade.combatTechnique:
        return "ct";
      case Upgrade.healthPoints:
        return "health";
      case Upgrade.astralPoints:
        return "astral";
      case Upgrade.karmicPoints:
        return "karma";
      case Upgrade.liturgy:
        return "liturgy";
      case Upgrade.cantrip:
        return "cantrip";
      case Upgrade.blessing:
        return "blessing";
      case Upgrade.advantage:
        return "adv";
      case Upgrade.disadvantage:
        return "disadv";
      case Upgrade.ability:
        return "ability";
    }
  }
}

enum Sign {
  increment,
  decrement;

  int get value => this == Sign.increment ? 1 : -1;
  Sign get inverse => this == Sign.increment ? Sign.decrement : Sign.increment;
  @override
  String toString() => this == Sign.increment ? "+1" : "-1";
}

enum Cost {
  a(0),
  b(1),
  c(2),
  d(3),
  e(4);

  final int idx;
  const Cost(this.idx);
}

UpgradeHandler upgradeHandler(
  Upgrade type,
  String id,
  Character character,
  StateCallback setState, {
  Sign sign = Sign.increment,
}) {
  final int tgtValue =
      character.getCurrentValue(type, id) + (sign.value + 1) ~/ 2;
  final cost = calculateUpgradeCost(type, id, character, tgtValue);
  if (!upgradeAllowed(type, id, character, sign, tgtValue) ||
      cost * sign.value > character.ap) {
    return null;
  }
  return () {
    setState(() {
      character.upgrade(type, id, sign, cost);
      character.compressStack();
    });
  };
}

int calculateUpgradeCost(
  Upgrade type,
  String id,
  Character character,
  int tgtValue,
) {
  Cost category;
  switch (type) {
    case Upgrade.skill:
      category = skillKeys[id]!.upgradeCost;
      break;
    case Upgrade.spell:
      category = spellsById[id]!.upgradeCost;
      break;
    case Upgrade.liturgy:
      // TODO: implement liturgies
      return -1;
    case Upgrade.combatTechnique:
      category = combatTechniquesByID[id]!.upgradeCost;
      break;
    case Upgrade.attribute:
      category = Cost.e;
      break;
    case Upgrade.healthPoints:
    case Upgrade.astralPoints:
    case Upgrade.karmicPoints:
      category = Cost.d;
      break;
    case Upgrade.blessing:
    case Upgrade.cantrip:
      return 1;
    case Upgrade.advantage:
    case Upgrade.disadvantage:
    case Upgrade.ability:
      // TODO: Implement advantage/disadvantage/ability
      return -1;
  }
  return simpleUpgradeCost(tgtValue, category);
}

bool upgradeAllowed(
  Upgrade type,
  String id,
  Character character,
  Sign sign,
  int tgtValue,
) {
  if (sign == Sign.decrement) {
    // We can allow the decrement of values under two conditions:
    // 1) There is track record (i.e. an undo stack element) that we did the upgrade in the first place
    // 2) There is no dependent element above (type, id) in the undo stack
    final lastTouched = character.undoStack!.lastIndexWhere(
      (item) =>
          item.type == type && item.id == id && item.sign == Sign.increment,
    );
    if (lastTouched == -1) {
      return false;
    }
    if (type == Upgrade.attribute) {
      for (
        int idx = lastTouched + 1;
        idx < character.undoStack!.length;
        idx++
      ) {
        final item = character.undoStack![idx];
        if ((item.type == Upgrade.skill ||
                item.type == Upgrade.combatTechnique ||
                item.type == Upgrade.healthPoints) &&
            item.sign == Sign.increment) {
          return false;
        }
      }
    }
    return true;
  } else {
    return !limitReached(type, id, tgtValue, character);
  }
}

const Map<int, List<int>> _costTable = {
  //Stufe: A B C D E
  // 0 = Aktivierung
  0: [1, 2, 3, 4, 0],
  // 1-11 as 12...
  12: [1, 2, 3, 4, 15],
  13: [2, 4, 6, 8, 15],
  14: [3, 6, 9, 12, 15],
  15: [4, 8, 12, 16, 30],
  16: [5, 10, 15, 20, 45],
  17: [6, 12, 18, 24, 60],
  18: [7, 14, 21, 28, 75],
  19: [8, 16, 24, 32, 90],
  20: [9, 18, 27, 36, 105],
  21: [10, 20, 30, 40, 120],
  22: [11, 22, 33, 44, 135],
  23: [12, 24, 36, 48, 150],
  24: [13, 26, 39, 52, 165],
  // 25+ ...
  25: [14, 28, 42, 56, 180],
};

int simpleUpgradeCost(int tgtLvl, Cost category) {
  if (tgtLvl <= 0) {
    tgtLvl = 0;
  } else if (tgtLvl < 12) {
    tgtLvl = 12;
  }
  if (tgtLvl > 25) {
    tgtLvl = 25;
  }
  return _costTable[tgtLvl]![category.idx];
}

bool limitReached(Upgrade type, String id, int tgtValue, Character character) {
  switch (type) {
    case Upgrade.attribute:
      return tgtValue > 20;
    case Upgrade.skill:
      final skill = skillKeys[id]!;
      final v1 = character.getAttribute(skill.attr1);
      final v2 = character.getAttribute(skill.attr2);
      final v3 = character.getAttribute(skill.attr3);
      final limit = [v1, v2, v3].reduce((x, y) => x > y ? x : y) + 2;
      return tgtValue > limit;
    case Upgrade.spell:
    case Upgrade.liturgy:
      // TODO: Zauber und Rituale (ohne Merkmalskenntnis) 14
      // Liturgien und Zeremonien (ohne Aspektkenntnis) 14
      return tgtValue > 14;
    case Upgrade.combatTechnique:
      final ct = combatTechniquesByID[id]!;
      final limit =
          ct.primary
              .map((attr) => character.getAttribute(attr))
              .reduce((a, b) => a > b ? a : b) +
          2;
      return tgtValue > limit;
    case Upgrade.healthPoints:
      final limit = character.getAttribute(Attribute.konstitution);
      return character.boughtHealthPoints + 1 > limit;
    case Upgrade.astralPoints:
    // Astralenergiepunkte Leiteigenschaft
    case Upgrade.karmicPoints:
    // Karmaenergiepunkte Leiteigenschaft
    case Upgrade.cantrip:
    case Upgrade.blessing:
    case Upgrade.advantage:
    case Upgrade.disadvantage:
      return false;
    case Upgrade.ability:
      // TODO: implement per ability check
      return true;
  }
}

class UndoItem {
  final Upgrade type;
  final String id;
  final Sign sign;
  final int cost;

  UndoItem(this.type, this.id, this.sign, this.cost);

  @override
  String toString() {
    return "UndoItem($type, $id, $sign, $cost)";
  }
}
