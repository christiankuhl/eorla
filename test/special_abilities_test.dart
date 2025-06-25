import 'package:flutter_test/flutter_test.dart';
import 'package:eorla/models/weapons.dart';
import 'package:eorla/models/special_abilities.dart';
import 'package:eorla/models/special_abilities_impl.dart';

void main() {
  group('ApplicableCombatTechniques', () {
    test('all() creates _All', () {
      final act = ApplicableCombatTechniques.all();
      expect(act, isA<ApplicableCombatTechniques>());
      expect(act.runtimeType.toString(), contains('_All'));
    });

    test('melee() creates _Melee', () {
      final act = ApplicableCombatTechniques.melee();
      expect(act, isA<ApplicableCombatTechniques>());
      expect(act.runtimeType.toString(), contains('_Melee'));
    });

    test('ranged() creates _Ranged', () {
      final act = ApplicableCombatTechniques.ranged();
      expect(act, isA<ApplicableCombatTechniques>());
      expect(act.runtimeType.toString(), contains('_Ranged'));
    });

    test('meleeWithParry() creates _MeleeWithParry', () {
      final act = ApplicableCombatTechniques.meleeWithParry();
      expect(act, isA<ApplicableCombatTechniques>());
      expect(act.runtimeType.toString(), contains('_MeleeWithParry'));
    });

    test('meleeOneHanded() creates _MeleeOneHanded', () {
      final act = ApplicableCombatTechniques.meleeOneHanded();
      expect(act, isA<ApplicableCombatTechniques>());
      expect(act.runtimeType.toString(), contains('_MeleeOneHanded'));
    });

    test('explicitById() creates _Explicit with ids', () {
      final ids = ['CT_1', 'CT_2'];
      final act = ApplicableCombatTechniques.explicitById(ids);
      expect(act, isA<ApplicableCombatTechniques>());
      expect(act.runtimeType.toString(), contains('_Explicit'));
      // ignore: invalid_use_of_protected_member
      expect((act as dynamic).ids, equals(ids));
    });

    test('explicitText() creates _ExplicitText with text', () {
      final text = 'Some text';
      final act = ApplicableCombatTechniques.explicitText(text);
      expect(act, isA<ApplicableCombatTechniques>());
      expect(act.runtimeType.toString(), contains('_ExplicitText'));
      // ignore: invalid_use_of_protected_member
      expect((act as dynamic).text, equals(text));
    });
  });

  group('Techniques test', () {
    // TODO: one handed weapons test after implementation
    test('Armbrüste', () {
      final ct = CombatTechnique.armbrueste;
      expect(ct.group == CombatType.melee, false); // Melee
      expect(false, false); // Melee One Handed
      expect(ct.group == CombatType.melee && !ct.hasNoParry, false);// Melee with Parry
      expect(ct.group == CombatType.range, true); // Ranged
    });
    test('Bögen', () {
      final ct = CombatTechnique.boegen;
      expect(ct.group == CombatType.melee, false); // Melee
      expect(false, false); // Melee One Handed
      expect(ct.group == CombatType.melee && !ct.hasNoParry, false);// Melee with Parry
      expect(ct.group == CombatType.range, true); // Ranged
    });
    test('Dolche', () {
      final ct = CombatTechnique.dolche;
      expect(ct.group == CombatType.melee, true); // Melee
      expect(true, true); // Melee One Handed
      expect(ct.group == CombatType.melee && !ct.hasNoParry, true);// Melee with Parry
      expect(ct.group == CombatType.range, false); // Ranged
    });
    test('Fechtwaffen', () {
      final ct = CombatTechnique.fechtwaffen;
      expect(ct.group == CombatType.melee, true); // Melee
      expect(true, true); // Melee One Handed
      expect(ct.group == CombatType.melee && !ct.hasNoParry, true); // Melee with Parry
      expect(ct.group == CombatType.range, false); // Ranged
    });

    test('Hiebwaffen', () {
      final ct = CombatTechnique.hiebwaffen;
      expect(ct.group == CombatType.melee, true); // Melee
      expect(true, true); // Melee One Handed
      expect(ct.group == CombatType.melee && !ct.hasNoParry, true); // Melee with Parry
      expect(ct.group == CombatType.range, false); // Ranged
    });

    test('Kettenwaffen', () {
      final ct = CombatTechnique.kettenwaffen;
      expect(ct.group == CombatType.melee, true); // Melee
      expect(true, true); // Melee One Handed
      expect(ct.group == CombatType.melee && !ct.hasNoParry, false); // Melee with Parry
      expect(ct.group == CombatType.range, false); // Ranged
    });

    test('Lanzen', () {
      final ct = CombatTechnique.lanzen;
      expect(ct.group == CombatType.melee, true); // Melee
      expect(false, false); // Melee One Handed
      expect(ct.group == CombatType.melee && !ct.hasNoParry, true); // Melee with Parry
      expect(ct.group == CombatType.range, false); // Ranged
    });

    test('Peitschen', () {
      final ct = CombatTechnique.peitschen;
      expect(ct.group == CombatType.melee, true); // Melee
      expect(true, true); // Melee One Handed
      expect(ct.group == CombatType.melee && !ct.hasNoParry, false); // Melee with Parry
      expect(ct.group == CombatType.range, false); // Ranged
    });

    test('Raufen', () {
      final ct = CombatTechnique.raufen;
      expect(ct.group == CombatType.melee, true); // Melee
      expect(true, true); // Melee One Handed
      expect(ct.group == CombatType.melee && !ct.hasNoParry, true); // Melee with Parry
      expect(ct.group == CombatType.range, false); // Ranged
    });

    test('Schilde', () {
      final ct = CombatTechnique.schilde;
      expect(ct.group == CombatType.melee, true); // Melee
      expect(true, true); // Melee One Handed
      expect(ct.group == CombatType.melee && !ct.hasNoParry, true); // Melee with Parry
      expect(ct.group == CombatType.range, false); // Ranged
    });

    test('Schleudern', () {
      final ct = CombatTechnique.schleudern;
      expect(ct.group == CombatType.range, true); // Ranged
      expect(false, false); // Melee One Handed
      expect(ct.group == CombatType.melee && !ct.hasNoParry, false); // Melee with Parry
      expect(ct.group == CombatType.melee, false); // Melee
    });

    test('Schwerter', () {
      final ct = CombatTechnique.schwerter;
      expect(ct.group == CombatType.melee, true); // Melee
      expect(true, true); // Melee One Handed
      expect(ct.group == CombatType.melee && !ct.hasNoParry, true); // Melee with Parry
      expect(ct.group == CombatType.range, false); // Ranged
    });

    test('Stangenwaffen', () {
      final ct = CombatTechnique.stangenwaffen;
      expect(ct.group == CombatType.melee, true); // Melee
      expect(false, false); // Melee One Handed
      expect(ct.group == CombatType.melee && !ct.hasNoParry, true); // Melee with Parry
      expect(ct.group == CombatType.range, false); // Ranged
    });

    test('Wurfwaffen', () {
      final ct = CombatTechnique.wurfwaffen;
      expect(ct.group == CombatType.range, true); // Ranged
      expect(false, false); // Melee One Handed
      expect(ct.group == CombatType.melee && !ct.hasNoParry, false); // Melee with Parry
      expect(ct.group == CombatType.melee, false); // Melee
    });

    test('Zweihandhiebwaffen', () {
      final ct = CombatTechnique.zweihandhiebwaffen;
      expect(ct.group == CombatType.melee, true); // Melee
      expect(false, false); // Melee One Handed
      expect(ct.group == CombatType.melee && !ct.hasNoParry, true); // Melee with Parry
      expect(ct.group == CombatType.range, false); // Ranged
    });

    test('Zweihandschwerter', () {
      final ct = CombatTechnique.zweihandschwerter;
      expect(ct.group == CombatType.melee, true); // Melee
      expect(false, false); // Melee One Handed
      expect(ct.group == CombatType.melee && !ct.hasNoParry, true); // Melee with Parry
      expect(ct.group == CombatType.range, false); // Ranged
    });

    test('Feuerspeien', () {
      final ct = CombatTechnique.feuerspeien;
      expect(ct.group == CombatType.range, true); // Ranged
      expect(false, false); // Melee One Handed
      expect(ct.group == CombatType.melee && !ct.hasNoParry, false); // Melee with Parry
      expect(ct.group == CombatType.melee, false); // Melee
    });

    test('Blasrohre', () {
      final ct = CombatTechnique.blasrohre;
      expect(ct.group == CombatType.range, true); // Ranged
      expect(false, false); // Melee One Handed
      expect(ct.group == CombatType.melee && !ct.hasNoParry, false); // Melee with Parry
      expect(ct.group == CombatType.melee, false); // Melee
    });

    test('Diskusse', () {
      final ct = CombatTechnique.diskusse;
      expect(ct.group == CombatType.range, true); // Ranged
      expect(false, false); // Melee One Handed
      expect(ct.group == CombatType.melee && !ct.hasNoParry, false); // Melee with Parry
      expect(ct.group == CombatType.melee, false); // Melee
    });

    test('Fächer', () {
      final ct = CombatTechnique.faecher;
      expect(ct.group == CombatType.melee, true); // Melee
      expect(true, true); // Melee One Handed
      expect(ct.group == CombatType.melee && !ct.hasNoParry, true); // Melee with Parry
      expect(ct.group == CombatType.range, false); // Ranged
    });

    test('Spiesswaffen', () {
      final ct = CombatTechnique.spiesswaffen;
      expect(ct.group == CombatType.melee, true); // Melee
      expect(false, false); // Melee One Handed
      expect(ct.group == CombatType.melee && !ct.hasNoParry, true); // Melee with Parry
      expect(ct.group == CombatType.range, false); // Ranged
    });
  });

  group('SpecialAbility', () {
    test('toString returns correct string with tier', () {
      final ability = SpecialAbility(SpecialAbilityBase.wuchtschlag, 2);
      expect(ability.toString(), contains('Wuchtschlag II'));
    });

    test('toString returns correct string without tier', () {
      final ability = SpecialAbility(SpecialAbilityBase.kampfreflexe, null);
      expect(ability.toString(), contains('Kampfreflexe'));
    });

    test('toJson returns correct map with tier', () {
      final ability = SpecialAbility(SpecialAbilityBase.wuchtschlag, 1);
      expect(ability.toJson(), {'tier': 1});
    });

    test('toJson returns empty map without tier', () {
      final ability = SpecialAbility(SpecialAbilityBase.kampfreflexe, null);
      expect(ability.toJson(), {});
    });
  });

  group('SpecialAbilityImpact', () {
    test('wuchtschlag impact returns correct atMod and tpMod', () {
      final ability = SpecialAbility(SpecialAbilityBase.wuchtschlag, 2);
      final impact = SpecialAbilityImpact.fromActive(ability, null, null, 0);
      expect(impact.atMod, equals(-4)); // -2 * tier
      expect(impact.tpMod, equals(4)); // 2 * tier
    });

    test('finte impact returns correct atMod', () {
      final ability = SpecialAbility(SpecialAbilityBase.finte, 3);
      final impact = SpecialAbilityImpact.fromActive(ability, null, null, 0);
      expect(impact.atMod, equals(-3));
    });

    test('riposte impact returns correct paMod', () {
      final ability = SpecialAbility(SpecialAbilityBase.riposte, null);
      final impact = SpecialAbilityImpact.fromActive(ability, null, null, 0);
      expect(impact.paMod, equals(-2));
    });

    test('none impact returns all mods zero except modifier', () {
      final impact = SpecialAbilityImpact.none(5);
      expect(impact.atMod, equals(0));
      expect(impact.paMod, equals(0));
      expect(impact.awMod, equals(0));
      expect(impact.tpMod, equals(0));
      expect(impact.modifier, equals(5));
    });
  });
}
