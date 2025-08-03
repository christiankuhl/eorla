import 'package:eorla/models/attributes.dart';
import 'package:eorla/models/spells.dart';
import 'character.dart';
import 'skill.dart';
import 'weapons.dart';

typedef UpgradeHandler = void Function()?;
typedef StateCallback = Function(void Function());

enum Upgrade {
  // TODO: This is missing cantrips, blessings, advantages, disadvantages, and special abilities
  attribute(Cost.e),
  skill(null),
  spell(null),
  combatTechnique(null),
  healthPoints(Cost.d),
  astralPoints(Cost.d),
  karmicPoints(Cost.d),
  liturgy(null);

  final Cost? cost;
  const Upgrade(this.cost);
}

enum Sign {
  increment,
  decrement;

  int get value => this == Sign.increment ? 1 : -1;
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
  final int tgtValue = getCurrentValue(type, id, character) + sign.value;
  final cost = calculateUpgradeCost(type, id, character, tgtValue);
  if (!upgradeAllowed(type, id, character, sign, tgtValue) ||
      cost > character.ap) {
    return null;
  }
  UpgradeHandler handler;
  switch (type) {
    case Upgrade.attribute:
      handler = upgradeAttribute(id, character, sign, cost);
      break;
    case Upgrade.skill:
      handler = upgradeSkill(id, character, sign, cost);
      break;
    case Upgrade.spell:
      handler = upgradeSpell(id, character, sign, cost);
      break;
    case Upgrade.liturgy:
      handler = upgradeLiturgy(id, character, sign, cost);
      break;
    case Upgrade.combatTechnique:
      handler = upgradeCombat(id, character, sign, cost);
      break;
    case Upgrade.healthPoints:
      handler = upgradeHealthPoints(id, character, sign, cost);
      break;
    case Upgrade.astralPoints:
      handler = upgradeAstralPoints(id, character, sign, cost);
      break;
    case Upgrade.karmicPoints:
      handler = upgradeKarmicPoints(id, character, sign, cost);
      break;
  }
  return () {
    setState(handler!);
  };
}

int getCurrentValue(Upgrade type, String id, Character character) {
  switch (type) {
    case Upgrade.attribute:
      return character.getAttribute(attributeKeys[id]!);
    case Upgrade.skill:
      return character.getTalentOrSpell(SkillWrapper(skillKeys[id]!));
    case Upgrade.spell:
      return character.getTalentOrSpell(SpellWrapper(spellsById[id]!));
    case Upgrade.liturgy:
      // TODO: Implement liturgies
      return -1;
    case Upgrade.combatTechnique:
      return character.combatTechniques?[combatTechniquesByID[id]!] ?? -1;
    case Upgrade.healthPoints:
      return character.getHealthMax();
    case Upgrade.astralPoints:
    case Upgrade.karmicPoints:
      // TODO: Implement karmic/astral points
      return -1;
  }
}

int calculateUpgradeCost(
  Upgrade type,
  String id,
  Character character,
  int tgtValue,
) {
  if (type.cost != null) {
    return simpleUpgradeCost(tgtValue, type.cost!);
  }
  switch (type) {
    case Upgrade.skill:
      final category = skillKeys[id]!.upgradeCost;
      return simpleUpgradeCost(tgtValue, category);
    case Upgrade.spell:
      // TODO: implement cost determination
      break;
    case Upgrade.liturgy:
      // TODO: implement liturgies
      break;
    case Upgrade.combatTechnique:
      final category = combatTechniquesByID[id]!.upgradeCost;
      return simpleUpgradeCost(tgtValue, category);
    case Upgrade.attribute:
    case Upgrade.healthPoints:
    case Upgrade.astralPoints:
    case Upgrade.karmicPoints:
      assert(false, "This should not occur!");
  }
  return -1;
}

bool upgradeAllowed(
  Upgrade type,
  String id,
  Character character,
  Sign sign,
  int tgtValue,
) {
  if (sign == Sign.decrement) {
    // TODO: We can allow the decrement of values under two conditions:
    // 1) There is track record (i.e. an undo stack element) that we did the upgrade in the first place
    // 2) There is no dependent element above (type, id) in the undo stack
    // Until we have a solid grasp on this, we simply disallow the button.
    return false;
  } else {
    return !limitReached(type, id, tgtValue, character);
  }
}

UpgradeHandler upgradeAttribute(
  String id,
  Character character,
  Sign sign,
  int cost,
) {
  return () {};
}

UpgradeHandler upgradeSkill(
  String id,
  Character character,
  Sign sign,
  int cost,
) {
  return () {};
}

UpgradeHandler upgradeSpell(
  String id,
  Character character,
  Sign sign,
  int cost,
) {
  return () {};
}

UpgradeHandler upgradeLiturgy(
  String id,
  Character character,
  Sign sign,
  int cost,
) {
  return () {};
}

UpgradeHandler upgradeHealthPoints(
  String id,
  Character character,
  Sign sign,
  int cost,
) {
  return () {};
}

UpgradeHandler upgradeKarmicPoints(
  String id,
  Character character,
  Sign sign,
  int cost,
) {
  return () {};
}

UpgradeHandler upgradeAstralPoints(
  String id,
  Character character,
  Sign sign,
  int cost,
) {
  return () {};
}

UpgradeHandler upgradeCombat(
  String id,
  Character character,
  Sign sign,
  int cost,
) {
  return () {};
}

const Map<int, List<int>> _costTable = {
  //Stufe: A B C D E
  // 0 = Aktivierung
  0: [1, 2, 3, 4, 0],
  1: [1, 2, 3, 4, 15],
  2: [1, 2, 3, 4, 15],
  3: [1, 2, 3, 4, 15],
  4: [1, 2, 3, 4, 15],
  5: [1, 2, 3, 4, 15],
  6: [1, 2, 3, 4, 15],
  7: [1, 2, 3, 4, 15],
  8: [1, 2, 3, 4, 15],
  9: [1, 2, 3, 4, 15],
  10: [1, 2, 3, 4, 15],
  11: [1, 2, 3, 4, 15],
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
  if (tgtLvl < 0) {
    tgtLvl = 0;
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
      break;
  }
  return true;
}
