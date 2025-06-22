import 'dart:math';
import 'package:eorla/models/avatar.dart';
import 'package:eorla/models/character.dart';
import 'package:eorla/models/optolith.dart';
import 'package:test/test.dart';
import 'package:eorla/models/rules.dart';
import 'package:eorla/models/skill.dart';
import 'package:eorla/models/attributes.dart';

void main() {
  group('SkillRoll', () {
    late SkillRoll engine;
    setUp(() {
      var dd = durchschnittsdoedel();
      engine = SkillRoll.from(dd, SkillWrapper(Skill.betoeren));
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
      final result = engine.roll(0, random: Deterministic([1, 1, 20]));
      expect(result.quality.type, equals(RollEvent.critical));
    });
    test("detects two 20s as botch, regardless of remaining FW", () {
      final result = engine.roll(0, random: Deterministic([20, 1, 20]));
      expect(result.quality.type, equals(RollEvent.botch));
      final botchDespiteSuccess = engine.roll(20, random: Deterministic([20, 1, 20]));
      expect(botchDespiteSuccess.quality.type, equals(RollEvent.botch));
    });
    test("detects EFW < 1 as fail", () {
      // Modifier of -4 must lead to auto-fail of the CH trial, w/o looking at dice.
      final result = engine.roll(-4, random: Deterministic([1, 1, 1]));
      expect(result.quality.type, equals(RollEvent.failure));
      final critical = engine.roll(-3, random: Deterministic([1, 1, 1]));
      expect(critical.quality.type, equals(RollEvent.critical));
    });
    test("computes QS correctly", () {
      var dd = durchschnittsdoedel();
      final streetsmarts = SkillRoll.from(dd, SkillWrapper(Skill.gassenwissen));
      // Dödel stats: KL 9 / IN 10 / CH 8 / Verwirrung 4 / Gassenwissen 6
      // roll 5, 6, 4 => QS = 2
      final qs2 = streetsmarts.roll(0, random: Deterministic([5, 6, 4]));
      expect(qs2.quality.type, equals(RollEvent.success));
      expect(qs2.quality.qs, equals(2));
      // roll 8, 6, 4 => QS = 1
      final qs1 = streetsmarts.roll(0, random: Deterministic([8, 6, 4]));
      expect(qs1.quality.type, equals(RollEvent.success));
      expect(qs1.quality.qs, equals(1));
      // roll 8, 6, 4 / modifier = -1 => FWeff = 0 => QS = 1
      final qs0 = streetsmarts.roll(-1, random: Deterministic([8, 6, 4]));
      expect(qs0.quality.type, equals(RollEvent.success));
      expect(qs0.quality.qs, equals(1));
    });
  });

  group('attributeRoll', () {
    late CharacterState emptyState;
    setUp(() {
      emptyState = CharacterState(0, 0, 0, 0, 0, 0, 0);
    });
    test("detects a 1 and a pass as critical, and success otherwise", () {
      final crit = attributeRoll(10, 0, emptyState, random: Deterministic([1, 5]));
      expect(crit.event, equals(RollEvent.critical));
      final success = attributeRoll(10, 0, emptyState, random: Deterministic([1, 11]));
      expect(success.event, equals(RollEvent.success));
    });
    test("detects a 20 and a fail as botch, regardless of remaining FW", () {
      final regularBotch = attributeRoll(10, 0, emptyState, random: Deterministic([20, 15]));
      expect(regularBotch.event, equals(RollEvent.botch));
      final exceptionalBotch = attributeRoll(10, 10, emptyState, random: Deterministic([20, 20]));
      expect(exceptionalBotch.event, equals(RollEvent.botch));
      final regularFail = attributeRoll(10, 0, emptyState, random: Deterministic([20, 5]));
      expect(regularFail.event, equals(RollEvent.failure));
    });
    test("detects EFW < 1 as fail", () {
      final result = attributeRoll(5, -5, emptyState, random: Deterministic([1, 1, 1]));
      expect(result.event, equals(RollEvent.failure));
      final critical = attributeRoll(5, -4, emptyState, random: Deterministic([1, 1, 1]));
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
