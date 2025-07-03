import 'dart:math';
import 'package:eorla/models/avatar.dart';
import 'package:eorla/models/character.dart';
import 'package:eorla/models/optolith.dart';
import 'package:eorla/models/audit.dart';
import 'package:test/test.dart';
import 'package:eorla/models/rules.dart';
import 'package:eorla/models/skill.dart';
import 'package:eorla/models/attributes.dart';

void main() {
  group('SkillRoll', () {
    late SkillRoll engine;
    setUp(() {
      var dd = durchschnittsdoedel();
      engine = SkillRoll.from(dd, SkillWrapper(Skill.betoeren), 0);
    });
    test('constructs correctly from Character', () {
      expect(engine.attrValue1, equals(11));
      expect(engine.attrValue2, equals(8));
      expect(engine.attrValue3, equals(8));
      expect(engine.attr1, equals(Attribute.mut));
      expect(engine.attr2, equals(Attribute.charisma));
      expect(engine.attr3, equals(Attribute.charisma));
      expect(engine.characterState.verwirrung, equals(4));
    });
    test("detects two 1s as critical", () {
      final result = engine.roll(random: Deterministic([1, 1, 20]));
      expect(result.quality.type, equals(RollEvent.critical));
    });
    test("detects two 20s as botch, regardless of remaining FW", () {
      final result = engine.roll(random: Deterministic([20, 1, 20]));
      expect(result.quality.type, equals(RollEvent.botch));
      engine.modifier = 20;
      final botchDespiteSuccess = engine.roll(random: Deterministic([20, 1, 20]));
      expect(botchDespiteSuccess.quality.type, equals(RollEvent.botch));
      engine.modifier = 0;
    });
    test("detects EFW < 1 as fail", () {
      // Modifier of -4 must lead to auto-fail of the CH trial, w/o looking at dice.
      engine.modifier = -4;
      final result = engine.roll(random: Deterministic([1, 1, 1]));
      expect(result.quality.type, equals(RollEvent.failure));
      engine.modifier = -3;
      final critical = engine.roll(random: Deterministic([1, 1, 1]));
      expect(critical.quality.type, equals(RollEvent.critical));
      engine.modifier = 0;
    });
    test("computes QS correctly", () {
      var dd = durchschnittsdoedel();
      final streetsmarts = SkillRoll.from(dd, SkillWrapper(Skill.gassenwissen), 0);
      // Dödel stats: KL 9 / IN 10 / CH 8 / Verwirrung 4 / Gassenwissen 6
      // roll 5, 6, 4 => QS = 2
      final qs2 = streetsmarts.roll(random: Deterministic([5, 6, 4]));
      expect(qs2.quality.type, equals(RollEvent.success));
      expect(qs2.quality.qs, equals(2));
      // roll 8, 6, 4 => QS = 1
      final qs1 = streetsmarts.roll(random: Deterministic([8, 6, 4]));
      expect(qs1.quality.type, equals(RollEvent.success));
      expect(qs1.quality.qs, equals(1));
      // roll 8, 6, 4 / modifier = -1 => FWeff = 0 => QS = 1
      engine.modifier = -1;
      final qs0 = streetsmarts.roll(random: Deterministic([8, 6, 4]));
      expect(qs0.quality.type, equals(RollEvent.success));
      expect(qs0.quality.qs, equals(1));
    });
  });

  group('attributeRoll', () {
    test("detects a 1 and a pass as critical, and success otherwise", () {
      final crit = attributeRoll(attributeWithModifier(10), random: Deterministic([1, 5]));
      expect(crit.event, equals(RollEvent.critical));
      final success = attributeRoll(attributeWithModifier(10), random: Deterministic([1, 11]));
      expect(success.event, equals(RollEvent.success));
    });
    test("detects a 20 and a fail as botch, regardless of remaining FW", () {
      final regularBotch = attributeRoll(attributeWithModifier(10), random: Deterministic([20, 15]));
      expect(regularBotch.event, equals(RollEvent.botch));
      final exceptionalBotch = attributeRoll(attributeWithModifier(10, modifier: 10), random: Deterministic([20, 20]));
      expect(exceptionalBotch.event, equals(RollEvent.botch));
      final regularFail = attributeRoll(attributeWithModifier(10), random: Deterministic([20, 5]));
      expect(regularFail.event, equals(RollEvent.failure));
    });
    test("detects EFW < 1 as fail", () {
      final result = attributeRoll(attributeWithModifier(5, modifier: -5), random: Deterministic([1, 1, 1]));
      expect(result.targetValue.value, lessThan(1));
      expect(result.targetValue.explanation.last.explanation, equals("Ein Wurf mit einem effektiven FW < 1 darf nicht versucht werden"));
      expect(result.event, equals(RollEvent.failure));
      final critical = attributeRoll(attributeWithModifier(5, modifier: -4), random: Deterministic([1, 1, 1]));
      expect(critical.event, equals(RollEvent.critical));
    });
  });
}

Character durchschnittsdoedel() {
  return Character(
    avatar: Avatar.empty(),
    name: "Dödel",
    mu: 11,
    kl: 9,
    in_: 10,
    ch: 8,
    ff: 10,
    ge: 10,
    ko: 10,
    kk: 10,
    state: CharacterState(0, 0, 0, 0, 0, 0, 4),
    talents: {Skill.gassenwissen: 6},
    optolith: Optolith({}),
  );
}

class Deterministic implements Random {
  List<int> future;
  Deterministic(this.future) {
    future = future.reversed.map((n) => n - 1).toList();
  }

  @override
  int nextInt(int max) {
    return future.removeLast();
  }

  @override
  bool nextBool() {
    throw UnimplementedError();
  }

  @override
  double nextDouble() {
    throw UnimplementedError();
  }
}

ExplainedValue attributeWithModifier(int attrValue, {int modifier = 0}) {
  ExplainedValue value = ExplainedValue.base(attrValue, "base");
  if (modifier != 0) {
    value = value.addUnconditional(modifier, "modifier", true);
  }
  return value;
}