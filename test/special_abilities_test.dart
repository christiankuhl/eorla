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

  group('Combat techneques assignment', () {
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
    test('Aufmerksamkeit', () {
      final ability = SpecialAbility(SpecialAbilityBase.aufmerksamkeit, null);

      expect(ability.value.type, SpecialAbilityType.passive); // passive
      // check if ability.value.ct is instance of _All
      expect(ability.value.ct, isA<ApplicableCombatTechniques>());
      expect(ability.value.ct.runtimeType.toString(), contains('_All'));
    });
    group('Belastungsgewöhung', () {
      test('Stufe I', () {
        final ability = SpecialAbility(SpecialAbilityBase.belastungsgewoehnung, 1);

        expect(ability.value.type, SpecialAbilityType.passive); // passive
        // check if ability.value.ct is instance of _All
        expect(ability.value.ct, isA<ApplicableCombatTechniques>());
        expect(ability.value.ct.runtimeType.toString(), contains('_All'));
        expect(ability.tier, 1); // tier should be 1
      });
      test('Stufe II', () {
        final ability = SpecialAbility(SpecialAbilityBase.belastungsgewoehnung, 2);

        expect(ability.value.type, SpecialAbilityType.passive); // passive
        // check if ability.value.ct is instance of _All
        expect(ability.value.ct, isA<ApplicableCombatTechniques>());
        expect(ability.value.ct.runtimeType.toString(), contains('_All'));
        expect(ability.tier, 2); // tier should be 2
      });
    });
    group('Beidhändiger Kampf', () {
      test('Combat Technique', () {
        final ability = SpecialAbility(SpecialAbilityBase.beidhaendigerKampf, null);

        expect(ability.value.type, SpecialAbilityType.passive); // passive
        // check if ability.value.ct is instance of _Explicit
        expect(ability.value.ct, isA<ApplicableCombatTechniques>());
        expect(ability.value.ct.runtimeType.toString(), contains('_Explicit'));
        expect((ability.value.ct as dynamic).ids, isNotNull);
        expect((ability.value.ct as dynamic).ids, isA<List<String>>());
        expect((ability.value.ct as dynamic).ids, isNot(contains(CombatTechnique.armbrueste.id)));
        expect((ability.value.ct as dynamic).ids, isNot(contains(CombatTechnique.boegen.id)));
        expect((ability.value.ct as dynamic).ids, contains(CombatTechnique.dolche.id));
        expect((ability.value.ct as dynamic).ids, contains(CombatTechnique.fechtwaffen.id));
        expect((ability.value.ct as dynamic).ids, contains(CombatTechnique.hiebwaffen.id));
        expect((ability.value.ct as dynamic).ids, isNot(contains(CombatTechnique.kettenwaffen.id)));
        expect((ability.value.ct as dynamic).ids, isNot(contains(CombatTechnique.lanzen.id)));
        expect((ability.value.ct as dynamic).ids, isNot(contains(CombatTechnique.peitschen.id)));
        expect((ability.value.ct as dynamic).ids, contains(CombatTechnique.raufen.id));
        expect((ability.value.ct as dynamic).ids, contains(CombatTechnique.schilde.id));
        expect((ability.value.ct as dynamic).ids, isNot(contains(CombatTechnique.schleudern.id)));
        expect((ability.value.ct as dynamic).ids, contains(CombatTechnique.schwerter.id));
        expect((ability.value.ct as dynamic).ids, isNot(contains(CombatTechnique.stangenwaffen.id)));
        expect((ability.value.ct as dynamic).ids, isNot(contains(CombatTechnique.wurfwaffen.id)));
        expect((ability.value.ct as dynamic).ids, isNot(contains(CombatTechnique.zweihandhiebwaffen.id)));
        expect((ability.value.ct as dynamic).ids, isNot(contains(CombatTechnique.zweihandschwerter.id)));
        expect((ability.value.ct as dynamic).ids, isNot(contains(CombatTechnique.feuerspeien.id)));
        expect((ability.value.ct as dynamic).ids, isNot(contains(CombatTechnique.blasrohre.id)));
        expect((ability.value.ct as dynamic).ids, isNot(contains(CombatTechnique.diskusse.id)));
        expect((ability.value.ct as dynamic).ids, isNot(contains(CombatTechnique.faecher.id)));
        expect((ability.value.ct as dynamic).ids, isNot(contains(CombatTechnique.spiesswaffen.id)));
      });
      test('Stufe I', () {
        final ability = SpecialAbility(SpecialAbilityBase.beidhaendigerKampf, 1);

        expect(ability.tier, 1); // tier should be 1
      });
      test('Stufe II', () {
        final ability = SpecialAbility(SpecialAbilityBase.beidhaendigerKampf, 2);

        expect(ability.tier, 2); // tier should be 2
      });
    });
    group('Berittener Schütze', () {
      test('Combat Technique', () {
        final ability = SpecialAbility(SpecialAbilityBase.berittenerSchuetze, null);

        expect(ability.value.type, SpecialAbilityType.passive); // passive
        // check if ability.value.ct is instance of _Explicit
        expect(ability.value.ct, isA<ApplicableCombatTechniques>());
        expect(ability.value.ct.runtimeType.toString(), contains('_Explicit'));
        expect((ability.value.ct as dynamic).ids, isNotNull);
        expect((ability.value.ct as dynamic).ids, isA<List<String>>());
        expect((ability.value.ct as dynamic).ids, contains(CombatTechnique.armbrueste.id));
        expect((ability.value.ct as dynamic).ids, contains(CombatTechnique.boegen.id));
        expect((ability.value.ct as dynamic).ids, isNot(contains(CombatTechnique.dolche.id)));
        expect((ability.value.ct as dynamic).ids, isNot(contains(CombatTechnique.fechtwaffen.id)));
        expect((ability.value.ct as dynamic).ids, isNot(contains(CombatTechnique.hiebwaffen.id)));
        expect((ability.value.ct as dynamic).ids, isNot(contains(CombatTechnique.kettenwaffen.id)));
        expect((ability.value.ct as dynamic).ids, isNot(contains(CombatTechnique.lanzen.id)));
        expect((ability.value.ct as dynamic).ids, isNot(contains(CombatTechnique.peitschen.id)));
        expect((ability.value.ct as dynamic).ids, isNot(contains(CombatTechnique.raufen.id)));
        expect((ability.value.ct as dynamic).ids, isNot(contains(CombatTechnique.schilde.id)));
        expect((ability.value.ct as dynamic).ids, isNot(contains(CombatTechnique.schleudern.id)));
        expect((ability.value.ct as dynamic).ids, isNot(contains(CombatTechnique.schwerter.id)));
        expect((ability.value.ct as dynamic).ids, isNot(contains(CombatTechnique.stangenwaffen.id)));
        expect((ability.value.ct as dynamic).ids, contains(CombatTechnique.wurfwaffen.id));
        expect((ability.value.ct as dynamic).ids, isNot(contains(CombatTechnique.zweihandhiebwaffen.id)));
        expect((ability.value.ct as dynamic).ids, isNot(contains(CombatTechnique.zweihandschwerter.id)));
        expect((ability.value.ct as dynamic).ids, isNot(contains(CombatTechnique.feuerspeien.id)));
        expect((ability.value.ct as dynamic).ids, isNot(contains(CombatTechnique.blasrohre.id)));
        expect((ability.value.ct as dynamic).ids, isNot(contains(CombatTechnique.diskusse.id)));
        expect((ability.value.ct as dynamic).ids, isNot(contains(CombatTechnique.faecher.id)));
        expect((ability.value.ct as dynamic).ids, isNot(contains(CombatTechnique.spiesswaffen.id)));
      });
    });
    group('Einhändiger Kampf', () {
      test('Combat Technique', () {
        final ability = SpecialAbility(SpecialAbilityBase.einhaendigerKampf, null);

        expect(ability.value.type, SpecialAbilityType.passive); // passive
        // check if ability.value.ct is instance of _Explicit
        expect(ability.value.ct, isA<ApplicableCombatTechniques>());
        expect(ability.value.ct.runtimeType.toString(), contains('_Explicit'));
        expect((ability.value.ct as dynamic).ids, isNotNull);
        expect((ability.value.ct as dynamic).ids, isA<List<String>>());
        expect((ability.value.ct as dynamic).ids, isNot(contains(CombatTechnique.armbrueste.id)));
        expect((ability.value.ct as dynamic).ids, isNot(contains(CombatTechnique.boegen.id)));
        expect((ability.value.ct as dynamic).ids, isNot(contains(CombatTechnique.dolche.id)));
        expect((ability.value.ct as dynamic).ids, contains(CombatTechnique.fechtwaffen.id));
        expect((ability.value.ct as dynamic).ids, isNot(contains(CombatTechnique.hiebwaffen.id)));
        expect((ability.value.ct as dynamic).ids, isNot(contains(CombatTechnique.kettenwaffen.id)));
        expect((ability.value.ct as dynamic).ids, isNot(contains(CombatTechnique.lanzen.id)));
        expect((ability.value.ct as dynamic).ids, isNot(contains(CombatTechnique.peitschen.id)));
        expect((ability.value.ct as dynamic).ids, isNot(contains(CombatTechnique.raufen.id)));
        expect((ability.value.ct as dynamic).ids, isNot(contains(CombatTechnique.schilde.id)));
        expect((ability.value.ct as dynamic).ids, isNot(contains(CombatTechnique.schleudern.id)));
        expect((ability.value.ct as dynamic).ids, contains(CombatTechnique.schwerter.id));
        expect((ability.value.ct as dynamic).ids, isNot(contains(CombatTechnique.stangenwaffen.id)));
        expect((ability.value.ct as dynamic).ids, isNot(contains(CombatTechnique.wurfwaffen.id)));
        expect((ability.value.ct as dynamic).ids, isNot(contains(CombatTechnique.zweihandhiebwaffen.id)));
        expect((ability.value.ct as dynamic).ids, isNot(contains(CombatTechnique.zweihandschwerter.id)));
        expect((ability.value.ct as dynamic).ids, isNot(contains(CombatTechnique.feuerspeien.id)));
        expect((ability.value.ct as dynamic).ids, isNot(contains(CombatTechnique.blasrohre.id)));
        expect((ability.value.ct as dynamic).ids, isNot(contains(CombatTechnique.diskusse.id)));
        expect((ability.value.ct as dynamic).ids, isNot(contains(CombatTechnique.faecher.id)));
        expect((ability.value.ct as dynamic).ids, isNot(contains(CombatTechnique.spiesswaffen.id)));
      });
    });
    group('Entwaffnen', () {
      test('Combat Technique', () {
        final ability = SpecialAbility(SpecialAbilityBase.entwaffnen, null);

        expect(ability.value.type, SpecialAbilityType.specialManeuvre);
        // check if ability.value.ct is instance of _Explicit
        expect(ability.value.ct, isA<ApplicableCombatTechniques>());
        expect(ability.value.ct.runtimeType.toString(), contains('_Explicit'));
        expect((ability.value.ct as dynamic).ids, isNotNull);
        expect((ability.value.ct as dynamic).ids, isA<List<String>>());
        expect((ability.value.ct as dynamic).ids, isNot(contains(CombatTechnique.armbrueste.id)));
        expect((ability.value.ct as dynamic).ids, isNot(contains(CombatTechnique.boegen.id)));
        expect((ability.value.ct as dynamic).ids, isNot(contains(CombatTechnique.dolche.id)));
        expect((ability.value.ct as dynamic).ids, contains(CombatTechnique.fechtwaffen.id));
        expect((ability.value.ct as dynamic).ids, contains(CombatTechnique.hiebwaffen.id));
        expect((ability.value.ct as dynamic).ids, isNot(contains(CombatTechnique.kettenwaffen.id)));
        expect((ability.value.ct as dynamic).ids, isNot(contains(CombatTechnique.lanzen.id)));
        expect((ability.value.ct as dynamic).ids, isNot(contains(CombatTechnique.peitschen.id)));
        expect((ability.value.ct as dynamic).ids, contains(CombatTechnique.raufen.id));
        expect((ability.value.ct as dynamic).ids, isNot(contains(CombatTechnique.schilde.id)));
        expect((ability.value.ct as dynamic).ids, isNot(contains(CombatTechnique.schleudern.id)));
        expect((ability.value.ct as dynamic).ids, contains(CombatTechnique.schwerter.id));
        expect((ability.value.ct as dynamic).ids, contains(CombatTechnique.stangenwaffen.id));
        expect((ability.value.ct as dynamic).ids, isNot(contains(CombatTechnique.wurfwaffen.id)));
        expect((ability.value.ct as dynamic).ids, contains(CombatTechnique.zweihandhiebwaffen.id));
        expect((ability.value.ct as dynamic).ids, contains(CombatTechnique.zweihandschwerter.id));
        expect((ability.value.ct as dynamic).ids, isNot(contains(CombatTechnique.feuerspeien.id)));
        expect((ability.value.ct as dynamic).ids, isNot(contains(CombatTechnique.blasrohre.id)));
        expect((ability.value.ct as dynamic).ids, isNot(contains(CombatTechnique.diskusse.id)));
        expect((ability.value.ct as dynamic).ids, isNot(contains(CombatTechnique.faecher.id)));
        expect((ability.value.ct as dynamic).ids, isNot(contains(CombatTechnique.spiesswaffen.id)));
      });
    });
    group('Feindgespür', () {
      test('Combat Technique', () {
        final ability = SpecialAbility(SpecialAbilityBase.feindgespuer, null);

        expect(ability.value.type, SpecialAbilityType.passive); // passive
        // check if ability.value.ct is instance of _Explicit
        expect(ability.value.ct, isA<ApplicableCombatTechniques>());
        expect(ability.value.ct.runtimeType.toString(), contains('_All'));
      });
    });
    group('Finte', () {
      test('Combat Technique', () {
        final ability = SpecialAbility(SpecialAbilityBase.finte, null);

        expect(ability.value.type, SpecialAbilityType.baseManeuvre);
        // check if ability.value.ct is instance of _Explicit
        expect(ability.value.ct, isA<ApplicableCombatTechniques>());
        expect(ability.value.ct.runtimeType.toString(), contains('_Explicit'));
        expect((ability.value.ct as dynamic).ids, isNotNull);
        expect((ability.value.ct as dynamic).ids, isA<List<String>>());
        expect((ability.value.ct as dynamic).ids, isNot(contains(CombatTechnique.armbrueste.id)));
        expect((ability.value.ct as dynamic).ids, isNot(contains(CombatTechnique.boegen.id)));
        expect((ability.value.ct as dynamic).ids, (contains(CombatTechnique.dolche.id)));
        expect((ability.value.ct as dynamic).ids, (contains(CombatTechnique.fechtwaffen.id)));
        expect((ability.value.ct as dynamic).ids, (contains(CombatTechnique.hiebwaffen.id)));
        expect((ability.value.ct as dynamic).ids, isNot(contains(CombatTechnique.kettenwaffen.id)));
        expect((ability.value.ct as dynamic).ids, isNot(contains(CombatTechnique.lanzen.id)));
        expect((ability.value.ct as dynamic).ids, isNot(contains(CombatTechnique.peitschen.id)));
        expect((ability.value.ct as dynamic).ids, (contains(CombatTechnique.raufen.id)));
        expect((ability.value.ct as dynamic).ids, isNot(contains(CombatTechnique.schilde.id)));
        expect((ability.value.ct as dynamic).ids, isNot(contains(CombatTechnique.schleudern.id)));
        expect((ability.value.ct as dynamic).ids, (contains(CombatTechnique.schwerter.id)));
        expect((ability.value.ct as dynamic).ids, (contains(CombatTechnique.stangenwaffen.id)));
        expect((ability.value.ct as dynamic).ids, isNot(contains(CombatTechnique.wurfwaffen.id)));
        expect((ability.value.ct as dynamic).ids, (contains(CombatTechnique.zweihandhiebwaffen.id)));
        expect((ability.value.ct as dynamic).ids, (contains(CombatTechnique.zweihandschwerter.id)));
        expect((ability.value.ct as dynamic).ids, isNot(contains(CombatTechnique.feuerspeien.id)));
        expect((ability.value.ct as dynamic).ids, isNot(contains(CombatTechnique.blasrohre.id)));
        expect((ability.value.ct as dynamic).ids, isNot(contains(CombatTechnique.diskusse.id)));
        expect((ability.value.ct as dynamic).ids, isNot(contains(CombatTechnique.faecher.id)));
        expect((ability.value.ct as dynamic).ids, isNot(contains(CombatTechnique.spiesswaffen.id)));
      });
    });
    group('Haltegriff', () {
      test('Combat Technique', () {
        final ability = SpecialAbility(SpecialAbilityBase.haltegriff, null);

        expect(ability.value.type, SpecialAbilityType.specialManeuvre);
        // check if ability.value.ct is instance of _Explicit
        expect(ability.value.ct, isA<ApplicableCombatTechniques>());
        expect(ability.value.ct.runtimeType.toString(), contains('_Explicit'));
        expect((ability.value.ct as dynamic).ids, isNotNull);
        expect((ability.value.ct as dynamic).ids, isA<List<String>>());
        expect((ability.value.ct as dynamic).ids, isNot(contains(CombatTechnique.armbrueste.id)));
        expect((ability.value.ct as dynamic).ids, isNot(contains(CombatTechnique.boegen.id)));
        expect((ability.value.ct as dynamic).ids, isNot(contains(CombatTechnique.dolche.id)));
        expect((ability.value.ct as dynamic).ids, isNot(contains(CombatTechnique.fechtwaffen.id)));
        expect((ability.value.ct as dynamic).ids, isNot(contains(CombatTechnique.hiebwaffen.id)));
        expect((ability.value.ct as dynamic).ids, isNot(contains(CombatTechnique.kettenwaffen.id)));
        expect((ability.value.ct as dynamic).ids, isNot(contains(CombatTechnique.lanzen.id)));
        expect((ability.value.ct as dynamic).ids, isNot(contains(CombatTechnique.peitschen.id)));
        expect((ability.value.ct as dynamic).ids, (contains(CombatTechnique.raufen.id)));
        expect((ability.value.ct as dynamic).ids, isNot(contains(CombatTechnique.schilde.id)));
        expect((ability.value.ct as dynamic).ids, isNot(contains(CombatTechnique.schleudern.id)));
        expect((ability.value.ct as dynamic).ids, isNot(contains(CombatTechnique.schwerter.id)));
        expect((ability.value.ct as dynamic).ids, isNot(contains(CombatTechnique.stangenwaffen.id)));
        expect((ability.value.ct as dynamic).ids, isNot(contains(CombatTechnique.wurfwaffen.id)));
        expect((ability.value.ct as dynamic).ids, isNot(contains(CombatTechnique.zweihandhiebwaffen.id)));
        expect((ability.value.ct as dynamic).ids, isNot(contains(CombatTechnique.zweihandschwerter.id)));
        expect((ability.value.ct as dynamic).ids, isNot(contains(CombatTechnique.feuerspeien.id)));
        expect((ability.value.ct as dynamic).ids, isNot(contains(CombatTechnique.blasrohre.id)));
        expect((ability.value.ct as dynamic).ids, isNot(contains(CombatTechnique.diskusse.id)));
        expect((ability.value.ct as dynamic).ids, isNot(contains(CombatTechnique.faecher.id)));
        expect((ability.value.ct as dynamic).ids, isNot(contains(CombatTechnique.spiesswaffen.id)));
      });
    });
    group('Hammerschlag', () {
      test('Combat Technique', () {
        final ability = SpecialAbility(SpecialAbilityBase.hammerschlag, null);

        expect(ability.value.type, SpecialAbilityType.specialManeuvre);
        // check if ability.value.ct is instance of _Explicit
        expect(ability.value.ct, isA<ApplicableCombatTechniques>());
        expect(ability.value.ct.runtimeType.toString(), contains('_Explicit'));
        expect((ability.value.ct as dynamic).ids, isNotNull);
        expect((ability.value.ct as dynamic).ids, isA<List<String>>());
        expect((ability.value.ct as dynamic).ids, isNot(contains(CombatTechnique.armbrueste.id)));
        expect((ability.value.ct as dynamic).ids, isNot(contains(CombatTechnique.boegen.id)));
        expect((ability.value.ct as dynamic).ids, isNot(contains(CombatTechnique.dolche.id)));
        expect((ability.value.ct as dynamic).ids, isNot(contains(CombatTechnique.fechtwaffen.id)));
        expect((ability.value.ct as dynamic).ids, (contains(CombatTechnique.hiebwaffen.id)));
        expect((ability.value.ct as dynamic).ids, (contains(CombatTechnique.kettenwaffen.id)));
        expect((ability.value.ct as dynamic).ids, isNot(contains(CombatTechnique.lanzen.id)));
        expect((ability.value.ct as dynamic).ids, isNot(contains(CombatTechnique.peitschen.id)));
        expect((ability.value.ct as dynamic).ids, isNot(contains(CombatTechnique.raufen.id)));
        expect((ability.value.ct as dynamic).ids, isNot(contains(CombatTechnique.schilde.id)));
        expect((ability.value.ct as dynamic).ids, isNot(contains(CombatTechnique.schleudern.id)));
        expect((ability.value.ct as dynamic).ids, (contains(CombatTechnique.schwerter.id)));
        expect((ability.value.ct as dynamic).ids, isNot(contains(CombatTechnique.stangenwaffen.id)));
        expect((ability.value.ct as dynamic).ids, isNot(contains(CombatTechnique.wurfwaffen.id)));
        expect((ability.value.ct as dynamic).ids, (contains(CombatTechnique.zweihandhiebwaffen.id)));
        expect((ability.value.ct as dynamic).ids, (contains(CombatTechnique.zweihandschwerter.id)));
        expect((ability.value.ct as dynamic).ids, isNot(contains(CombatTechnique.feuerspeien.id)));
        expect((ability.value.ct as dynamic).ids, isNot(contains(CombatTechnique.blasrohre.id)));
        expect((ability.value.ct as dynamic).ids, isNot(contains(CombatTechnique.diskusse.id)));
        expect((ability.value.ct as dynamic).ids, isNot(contains(CombatTechnique.faecher.id)));
        expect((ability.value.ct as dynamic).ids, isNot(contains(CombatTechnique.spiesswaffen.id)));
      });
    });
    group('Kampfreflexe', () {
      test('Combat Technique', () {
        final ability = SpecialAbility(SpecialAbilityBase.kampfreflexe, null);

        expect(ability.value.type, SpecialAbilityType.passive); // passive
        // check if ability.value.ct is instance of _Explicit
        expect(ability.value.ct, isA<ApplicableCombatTechniques>());
        expect(ability.value.ct.runtimeType.toString(), contains('_All'));
      });
    });
    group('Klingenfänger', () {
      test('Combat Technique', () {
        final ability = SpecialAbility(SpecialAbilityBase.klingenfaenger, null);

        expect(ability.value.type, SpecialAbilityType.passive); // passive
        // check if ability.value.ct is instance of _Explicit
        expect(ability.value.ct, isA<ApplicableCombatTechniques>());
        expect(ability.value.ct.runtimeType.toString(), contains('_Explicit'));
        expect((ability.value.ct as dynamic).ids, isNotNull);
        expect((ability.value.ct as dynamic).ids, isA<List<String>>());
        expect((ability.value.ct as dynamic).ids, isNot(contains(CombatTechnique.armbrueste.id)));
        expect((ability.value.ct as dynamic).ids, isNot(contains(CombatTechnique.boegen.id)));
        expect((ability.value.ct as dynamic).ids, (contains(CombatTechnique.dolche.id)));
        expect((ability.value.ct as dynamic).ids, isNot(contains(CombatTechnique.fechtwaffen.id)));
        expect((ability.value.ct as dynamic).ids, isNot(contains(CombatTechnique.hiebwaffen.id)));
        expect((ability.value.ct as dynamic).ids, isNot(contains(CombatTechnique.kettenwaffen.id)));
        expect((ability.value.ct as dynamic).ids, isNot(contains(CombatTechnique.lanzen.id)));
        expect((ability.value.ct as dynamic).ids, isNot(contains(CombatTechnique.peitschen.id)));
        expect((ability.value.ct as dynamic).ids, isNot(contains(CombatTechnique.raufen.id)));
        expect((ability.value.ct as dynamic).ids, isNot(contains(CombatTechnique.schilde.id)));
        expect((ability.value.ct as dynamic).ids, isNot(contains(CombatTechnique.schleudern.id)));
        expect((ability.value.ct as dynamic).ids, isNot(contains(CombatTechnique.schwerter.id)));
        expect((ability.value.ct as dynamic).ids, isNot(contains(CombatTechnique.stangenwaffen.id)));
        expect((ability.value.ct as dynamic).ids, isNot(contains(CombatTechnique.wurfwaffen.id)));
        expect((ability.value.ct as dynamic).ids, isNot(contains(CombatTechnique.zweihandhiebwaffen.id)));
        expect((ability.value.ct as dynamic).ids, isNot(contains(CombatTechnique.zweihandschwerter.id)));
        expect((ability.value.ct as dynamic).ids, isNot(contains(CombatTechnique.feuerspeien.id)));
        expect((ability.value.ct as dynamic).ids, isNot(contains(CombatTechnique.blasrohre.id)));
        expect((ability.value.ct as dynamic).ids, isNot(contains(CombatTechnique.diskusse.id)));
        expect((ability.value.ct as dynamic).ids, isNot(contains(CombatTechnique.faecher.id)));
        expect((ability.value.ct as dynamic).ids, isNot(contains(CombatTechnique.spiesswaffen.id)));
      });
    });
    group('Kreuzblock', () {
      test('Combat Technique', () {
        final ability = SpecialAbility(SpecialAbilityBase.kreuzblock, null);

        expect(ability.value.type, SpecialAbilityType.passive); // passive
        // check if ability.value.ct is instance of _Explicit
        expect(ability.value.ct, isA<ApplicableCombatTechniques>());
        expect(ability.value.ct.runtimeType.toString(), contains('_Explicit'));
        expect((ability.value.ct as dynamic).ids, isNotNull);
        expect((ability.value.ct as dynamic).ids, isA<List<String>>());
        expect((ability.value.ct as dynamic).ids, isNot(contains(CombatTechnique.armbrueste.id)));
        expect((ability.value.ct as dynamic).ids, isNot(contains(CombatTechnique.boegen.id)));
        expect((ability.value.ct as dynamic).ids, (contains(CombatTechnique.dolche.id)));
        expect((ability.value.ct as dynamic).ids, (contains(CombatTechnique.fechtwaffen.id)));
        expect((ability.value.ct as dynamic).ids, isNot(contains(CombatTechnique.hiebwaffen.id)));
        expect((ability.value.ct as dynamic).ids, isNot(contains(CombatTechnique.kettenwaffen.id)));
        expect((ability.value.ct as dynamic).ids, isNot(contains(CombatTechnique.lanzen.id)));
        expect((ability.value.ct as dynamic).ids, isNot(contains(CombatTechnique.peitschen.id)));
        expect((ability.value.ct as dynamic).ids, isNot(contains(CombatTechnique.raufen.id)));
        expect((ability.value.ct as dynamic).ids, isNot(contains(CombatTechnique.schilde.id)));
        expect((ability.value.ct as dynamic).ids, isNot(contains(CombatTechnique.schleudern.id)));
        expect((ability.value.ct as dynamic).ids, isNot(contains(CombatTechnique.schwerter.id)));
        expect((ability.value.ct as dynamic).ids, isNot(contains(CombatTechnique.stangenwaffen.id)));
        expect((ability.value.ct as dynamic).ids, isNot(contains(CombatTechnique.wurfwaffen.id)));
        expect((ability.value.ct as dynamic).ids, isNot(contains(CombatTechnique.zweihandhiebwaffen.id)));
        expect((ability.value.ct as dynamic).ids, isNot(contains(CombatTechnique.zweihandschwerter.id)));
        expect((ability.value.ct as dynamic).ids, isNot(contains(CombatTechnique.feuerspeien.id)));
        expect((ability.value.ct as dynamic).ids, isNot(contains(CombatTechnique.blasrohre.id)));
        expect((ability.value.ct as dynamic).ids, isNot(contains(CombatTechnique.diskusse.id)));
        expect((ability.value.ct as dynamic).ids, isNot(contains(CombatTechnique.faecher.id)));
        expect((ability.value.ct as dynamic).ids, isNot(contains(CombatTechnique.spiesswaffen.id)));
      });
    });
    group('Lanzenangriff', () {
      test('Combat Technique', () {
        final ability = SpecialAbility(SpecialAbilityBase.lanzenangriff, null);

        expect(ability.value.type, SpecialAbilityType.specialManeuvre);
        // check if ability.value.ct is instance of _Explicit
        expect(ability.value.ct, isA<ApplicableCombatTechniques>());
        expect(ability.value.ct.runtimeType.toString(), contains('_Explicit'));
        expect((ability.value.ct as dynamic).ids, isNotNull);
        expect((ability.value.ct as dynamic).ids, isA<List<String>>());
        expect((ability.value.ct as dynamic).ids, isNot(contains(CombatTechnique.armbrueste.id)));
        expect((ability.value.ct as dynamic).ids, isNot(contains(CombatTechnique.boegen.id)));
        expect((ability.value.ct as dynamic).ids, isNot(contains(CombatTechnique.dolche.id)));
        expect((ability.value.ct as dynamic).ids, isNot(contains(CombatTechnique.fechtwaffen.id)));
        expect((ability.value.ct as dynamic).ids, isNot(contains(CombatTechnique.hiebwaffen.id)));
        expect((ability.value.ct as dynamic).ids, isNot(contains(CombatTechnique.kettenwaffen.id)));
        expect((ability.value.ct as dynamic).ids, (contains(CombatTechnique.lanzen.id)));
        expect((ability.value.ct as dynamic).ids, isNot(contains(CombatTechnique.peitschen.id)));
        expect((ability.value.ct as dynamic).ids, isNot(contains(CombatTechnique.raufen.id)));
        expect((ability.value.ct as dynamic).ids, isNot(contains(CombatTechnique.schilde.id)));
        expect((ability.value.ct as dynamic).ids, isNot(contains(CombatTechnique.schleudern.id)));
        expect((ability.value.ct as dynamic).ids, isNot(contains(CombatTechnique.schwerter.id)));
        expect((ability.value.ct as dynamic).ids, isNot(contains(CombatTechnique.stangenwaffen.id)));
        expect((ability.value.ct as dynamic).ids, isNot(contains(CombatTechnique.wurfwaffen.id)));
        expect((ability.value.ct as dynamic).ids, isNot(contains(CombatTechnique.zweihandhiebwaffen.id)));
        expect((ability.value.ct as dynamic).ids, isNot(contains(CombatTechnique.zweihandschwerter.id)));
        expect((ability.value.ct as dynamic).ids, isNot(contains(CombatTechnique.feuerspeien.id)));
        expect((ability.value.ct as dynamic).ids, isNot(contains(CombatTechnique.blasrohre.id)));
        expect((ability.value.ct as dynamic).ids, isNot(contains(CombatTechnique.diskusse.id)));
        expect((ability.value.ct as dynamic).ids, isNot(contains(CombatTechnique.faecher.id)));
        expect((ability.value.ct as dynamic).ids, isNot(contains(CombatTechnique.spiesswaffen.id)));
      });
    });
    group('Präziser Schuss/Wurf', () {
      test('Combat Technique', () {
        final ability = SpecialAbility(SpecialAbilityBase.praeziserSchussWurf, null);

        expect(ability.value.type, SpecialAbilityType.baseManeuvre);
        // check if ability.value.ct is instance of _Explicit
        expect(ability.value.ct, isA<ApplicableCombatTechniques>());
        expect(ability.value.ct.runtimeType.toString(), contains('_Explicit'));
        expect((ability.value.ct as dynamic).ids, isNotNull);
        expect((ability.value.ct as dynamic).ids, isA<List<String>>());
        expect((ability.value.ct as dynamic).ids, (contains(CombatTechnique.armbrueste.id)));
        expect((ability.value.ct as dynamic).ids, (contains(CombatTechnique.boegen.id)));
        expect((ability.value.ct as dynamic).ids, isNot(contains(CombatTechnique.dolche.id)));
        expect((ability.value.ct as dynamic).ids, isNot(contains(CombatTechnique.fechtwaffen.id)));
        expect((ability.value.ct as dynamic).ids, isNot(contains(CombatTechnique.hiebwaffen.id)));
        expect((ability.value.ct as dynamic).ids, isNot(contains(CombatTechnique.kettenwaffen.id)));
        expect((ability.value.ct as dynamic).ids, isNot(contains(CombatTechnique.lanzen.id)));
        expect((ability.value.ct as dynamic).ids, isNot(contains(CombatTechnique.peitschen.id)));
        expect((ability.value.ct as dynamic).ids, isNot(contains(CombatTechnique.raufen.id)));
        expect((ability.value.ct as dynamic).ids, isNot(contains(CombatTechnique.schilde.id)));
        expect((ability.value.ct as dynamic).ids, isNot(contains(CombatTechnique.schleudern.id)));
        expect((ability.value.ct as dynamic).ids, isNot(contains(CombatTechnique.schwerter.id)));
        expect((ability.value.ct as dynamic).ids, isNot(contains(CombatTechnique.stangenwaffen.id)));
        expect((ability.value.ct as dynamic).ids, (contains(CombatTechnique.wurfwaffen.id)));
        expect((ability.value.ct as dynamic).ids, isNot(contains(CombatTechnique.zweihandhiebwaffen.id)));
        expect((ability.value.ct as dynamic).ids, isNot(contains(CombatTechnique.zweihandschwerter.id)));
        expect((ability.value.ct as dynamic).ids, isNot(contains(CombatTechnique.feuerspeien.id)));
        expect((ability.value.ct as dynamic).ids, isNot(contains(CombatTechnique.blasrohre.id)));
        expect((ability.value.ct as dynamic).ids, isNot(contains(CombatTechnique.diskusse.id)));
        expect((ability.value.ct as dynamic).ids, isNot(contains(CombatTechnique.faecher.id)));
        expect((ability.value.ct as dynamic).ids, isNot(contains(CombatTechnique.spiesswaffen.id)));
      });
    });
    group('Präziser Stich', () {
      test('Combat Technique', () {
        final ability = SpecialAbility(SpecialAbilityBase.praeziserStich, null);

        expect(ability.value.type, SpecialAbilityType.baseManeuvre);
        // check if ability.value.ct is instance of _Explicit
        expect(ability.value.ct, isA<ApplicableCombatTechniques>());
        expect(ability.value.ct.runtimeType.toString(), contains('_Explicit'));
        expect((ability.value.ct as dynamic).ids, isNotNull);
        expect((ability.value.ct as dynamic).ids, isA<List<String>>());
        expect((ability.value.ct as dynamic).ids, isNot(contains(CombatTechnique.armbrueste.id)));
        expect((ability.value.ct as dynamic).ids, isNot(contains(CombatTechnique.boegen.id)));
        expect((ability.value.ct as dynamic).ids, (contains(CombatTechnique.dolche.id)));
        expect((ability.value.ct as dynamic).ids, (contains(CombatTechnique.fechtwaffen.id)));
        expect((ability.value.ct as dynamic).ids, isNot(contains(CombatTechnique.hiebwaffen.id)));
        expect((ability.value.ct as dynamic).ids, isNot(contains(CombatTechnique.kettenwaffen.id)));
        expect((ability.value.ct as dynamic).ids, isNot(contains(CombatTechnique.lanzen.id)));
        expect((ability.value.ct as dynamic).ids, isNot(contains(CombatTechnique.peitschen.id)));
        expect((ability.value.ct as dynamic).ids, isNot(contains(CombatTechnique.raufen.id)));
        expect((ability.value.ct as dynamic).ids, isNot(contains(CombatTechnique.schilde.id)));
        expect((ability.value.ct as dynamic).ids, isNot(contains(CombatTechnique.schleudern.id)));
        expect((ability.value.ct as dynamic).ids, isNot(contains(CombatTechnique.schwerter.id)));
        expect((ability.value.ct as dynamic).ids, isNot(contains(CombatTechnique.stangenwaffen.id)));
        expect((ability.value.ct as dynamic).ids, isNot(contains(CombatTechnique.wurfwaffen.id)));
        expect((ability.value.ct as dynamic).ids, isNot(contains(CombatTechnique.zweihandhiebwaffen.id)));
        expect((ability.value.ct as dynamic).ids, isNot(contains(CombatTechnique.zweihandschwerter.id)));
        expect((ability.value.ct as dynamic).ids, isNot(contains(CombatTechnique.feuerspeien.id)));
        expect((ability.value.ct as dynamic).ids, isNot(contains(CombatTechnique.blasrohre.id)));
        expect((ability.value.ct as dynamic).ids, isNot(contains(CombatTechnique.diskusse.id)));
        expect((ability.value.ct as dynamic).ids, isNot(contains(CombatTechnique.faecher.id)));
        expect((ability.value.ct as dynamic).ids, isNot(contains(CombatTechnique.spiesswaffen.id)));
      });
    });
    group('Riposte', () {
      test('Combat Technique', () {
        final ability = SpecialAbility(SpecialAbilityBase.riposte, null);

        expect(ability.value.type, SpecialAbilityType.specialManeuvre);
        // check if ability.value.ct is instance of _Explicit
        expect(ability.value.ct, isA<ApplicableCombatTechniques>());
        expect(ability.value.ct.runtimeType.toString(), contains('_Explicit'));
        expect((ability.value.ct as dynamic).ids, isNotNull);
        expect((ability.value.ct as dynamic).ids, isA<List<String>>());
        expect((ability.value.ct as dynamic).ids, isNot(contains(CombatTechnique.armbrueste.id)));
        expect((ability.value.ct as dynamic).ids, isNot(contains(CombatTechnique.boegen.id)));
        expect((ability.value.ct as dynamic).ids, (contains(CombatTechnique.dolche.id)));
        expect((ability.value.ct as dynamic).ids, (contains(CombatTechnique.fechtwaffen.id)));
        expect((ability.value.ct as dynamic).ids, isNot(contains(CombatTechnique.hiebwaffen.id)));
        expect((ability.value.ct as dynamic).ids, isNot(contains(CombatTechnique.kettenwaffen.id)));
        expect((ability.value.ct as dynamic).ids, isNot(contains(CombatTechnique.lanzen.id)));
        expect((ability.value.ct as dynamic).ids, isNot(contains(CombatTechnique.peitschen.id)));
        expect((ability.value.ct as dynamic).ids, isNot(contains(CombatTechnique.raufen.id)));
        expect((ability.value.ct as dynamic).ids, isNot(contains(CombatTechnique.schilde.id)));
        expect((ability.value.ct as dynamic).ids, isNot(contains(CombatTechnique.schleudern.id)));
        expect((ability.value.ct as dynamic).ids, isNot(contains(CombatTechnique.schwerter.id)));
        expect((ability.value.ct as dynamic).ids, isNot(contains(CombatTechnique.stangenwaffen.id)));
        expect((ability.value.ct as dynamic).ids, isNot(contains(CombatTechnique.wurfwaffen.id)));
        expect((ability.value.ct as dynamic).ids, isNot(contains(CombatTechnique.zweihandhiebwaffen.id)));
        expect((ability.value.ct as dynamic).ids, isNot(contains(CombatTechnique.zweihandschwerter.id)));
        expect((ability.value.ct as dynamic).ids, isNot(contains(CombatTechnique.feuerspeien.id)));
        expect((ability.value.ct as dynamic).ids, isNot(contains(CombatTechnique.blasrohre.id)));
        expect((ability.value.ct as dynamic).ids, isNot(contains(CombatTechnique.diskusse.id)));
        expect((ability.value.ct as dynamic).ids, isNot(contains(CombatTechnique.faecher.id)));
        expect((ability.value.ct as dynamic).ids, isNot(contains(CombatTechnique.spiesswaffen.id)));
      });
    });
    group('Rundumschlag', () {
      test('Combat Technique', () {
        final ability = SpecialAbility(SpecialAbilityBase.rundumschlag, null);

        expect(ability.value.type, SpecialAbilityType.specialManeuvre);
        // check if ability.value.ct is instance of _Explicit
        expect(ability.value.ct, isA<ApplicableCombatTechniques>());
        expect(ability.value.ct.runtimeType.toString(), contains('_Explicit'));
        expect((ability.value.ct as dynamic).ids, isNotNull);
        expect((ability.value.ct as dynamic).ids, isA<List<String>>());
        expect((ability.value.ct as dynamic).ids, isNot(contains(CombatTechnique.armbrueste.id)));
        expect((ability.value.ct as dynamic).ids, isNot(contains(CombatTechnique.boegen.id)));
        expect((ability.value.ct as dynamic).ids, isNot(contains(CombatTechnique.dolche.id)));
        expect((ability.value.ct as dynamic).ids, isNot(contains(CombatTechnique.fechtwaffen.id)));
        expect((ability.value.ct as dynamic).ids, (contains(CombatTechnique.hiebwaffen.id)));
        expect((ability.value.ct as dynamic).ids, (contains(CombatTechnique.kettenwaffen.id)));
        expect((ability.value.ct as dynamic).ids, isNot(contains(CombatTechnique.lanzen.id)));
        expect((ability.value.ct as dynamic).ids, isNot(contains(CombatTechnique.peitschen.id)));
        expect((ability.value.ct as dynamic).ids, isNot(contains(CombatTechnique.raufen.id)));
        expect((ability.value.ct as dynamic).ids, (contains(CombatTechnique.schilde.id)));
        expect((ability.value.ct as dynamic).ids, isNot(contains(CombatTechnique.schleudern.id)));
        expect((ability.value.ct as dynamic).ids, (contains(CombatTechnique.schwerter.id)));
        expect((ability.value.ct as dynamic).ids, (contains(CombatTechnique.stangenwaffen.id)));
        expect((ability.value.ct as dynamic).ids, isNot(contains(CombatTechnique.wurfwaffen.id)));
        expect((ability.value.ct as dynamic).ids, (contains(CombatTechnique.zweihandhiebwaffen.id)));
        expect((ability.value.ct as dynamic).ids, (contains(CombatTechnique.zweihandschwerter.id)));
        expect((ability.value.ct as dynamic).ids, isNot(contains(CombatTechnique.feuerspeien.id)));
        expect((ability.value.ct as dynamic).ids, isNot(contains(CombatTechnique.blasrohre.id)));
        expect((ability.value.ct as dynamic).ids, isNot(contains(CombatTechnique.diskusse.id)));
        expect((ability.value.ct as dynamic).ids, isNot(contains(CombatTechnique.faecher.id)));
        expect((ability.value.ct as dynamic).ids, isNot(contains(CombatTechnique.spiesswaffen.id)));
      });
    });
    group('Schildspalter', () {
      test('Combat Technique', () {
        final ability = SpecialAbility(SpecialAbilityBase.schildspalter, null);

        expect(ability.value.type, SpecialAbilityType.specialManeuvre);
        // check if ability.value.ct is instance of _Explicit
        expect(ability.value.ct, isA<ApplicableCombatTechniques>());
        expect(ability.value.ct.runtimeType.toString(), contains('_Explicit'));
        expect((ability.value.ct as dynamic).ids, isNotNull);
        expect((ability.value.ct as dynamic).ids, isA<List<String>>());
        expect((ability.value.ct as dynamic).ids, isNot(contains(CombatTechnique.armbrueste.id)));
        expect((ability.value.ct as dynamic).ids, isNot(contains(CombatTechnique.boegen.id)));
        expect((ability.value.ct as dynamic).ids, isNot(contains(CombatTechnique.dolche.id)));
        expect((ability.value.ct as dynamic).ids, isNot(contains(CombatTechnique.fechtwaffen.id)));
        expect((ability.value.ct as dynamic).ids, (contains(CombatTechnique.hiebwaffen.id)));
        expect((ability.value.ct as dynamic).ids, (contains(CombatTechnique.kettenwaffen.id)));
        expect((ability.value.ct as dynamic).ids, isNot(contains(CombatTechnique.lanzen.id)));
        expect((ability.value.ct as dynamic).ids, isNot(contains(CombatTechnique.peitschen.id)));
        expect((ability.value.ct as dynamic).ids, isNot(contains(CombatTechnique.raufen.id)));
        expect((ability.value.ct as dynamic).ids, isNot(contains(CombatTechnique.schilde.id)));
        expect((ability.value.ct as dynamic).ids, isNot(contains(CombatTechnique.schleudern.id)));
        expect((ability.value.ct as dynamic).ids, isNot(contains(CombatTechnique.schwerter.id)));
        expect((ability.value.ct as dynamic).ids, isNot(contains(CombatTechnique.stangenwaffen.id)));
        expect((ability.value.ct as dynamic).ids, isNot(contains(CombatTechnique.wurfwaffen.id)));
        expect((ability.value.ct as dynamic).ids, (contains(CombatTechnique.zweihandhiebwaffen.id)));
        expect((ability.value.ct as dynamic).ids, (contains(CombatTechnique.zweihandschwerter.id)));
        expect((ability.value.ct as dynamic).ids, isNot(contains(CombatTechnique.feuerspeien.id)));
        expect((ability.value.ct as dynamic).ids, isNot(contains(CombatTechnique.blasrohre.id)));
        expect((ability.value.ct as dynamic).ids, isNot(contains(CombatTechnique.diskusse.id)));
        expect((ability.value.ct as dynamic).ids, isNot(contains(CombatTechnique.faecher.id)));
        expect((ability.value.ct as dynamic).ids, isNot(contains(CombatTechnique.spiesswaffen.id)));
      });
    });
    group('Schnellladen', () {
      test('Combat Technique', () {
        final ability = SpecialAbility(SpecialAbilityBase.schnellladen, null);

        expect(ability.value.type, SpecialAbilityType.passive);
        // check if ability.value.ct is instance of _Explicit
        expect(ability.value.ct, isA<ApplicableCombatTechniques>());
        expect(ability.value.ct.runtimeType.toString(), contains('_Explicit'));
        expect((ability.value.ct as dynamic).ids, isNotNull);
        expect((ability.value.ct as dynamic).ids, isA<List<String>>());
        expect((ability.value.ct as dynamic).ids, (contains(CombatTechnique.armbrueste.id)));
        expect((ability.value.ct as dynamic).ids, (contains(CombatTechnique.boegen.id)));
        expect((ability.value.ct as dynamic).ids, isNot(contains(CombatTechnique.dolche.id)));
        expect((ability.value.ct as dynamic).ids, isNot(contains(CombatTechnique.fechtwaffen.id)));
        expect((ability.value.ct as dynamic).ids, isNot(contains(CombatTechnique.hiebwaffen.id)));
        expect((ability.value.ct as dynamic).ids, isNot(contains(CombatTechnique.kettenwaffen.id)));
        expect((ability.value.ct as dynamic).ids, isNot(contains(CombatTechnique.lanzen.id)));
        expect((ability.value.ct as dynamic).ids, isNot(contains(CombatTechnique.peitschen.id)));
        expect((ability.value.ct as dynamic).ids, isNot(contains(CombatTechnique.raufen.id)));
        expect((ability.value.ct as dynamic).ids, isNot(contains(CombatTechnique.schilde.id)));
        expect((ability.value.ct as dynamic).ids, isNot(contains(CombatTechnique.schleudern.id)));
        expect((ability.value.ct as dynamic).ids, isNot(contains(CombatTechnique.schwerter.id)));
        expect((ability.value.ct as dynamic).ids, isNot(contains(CombatTechnique.stangenwaffen.id)));
        expect((ability.value.ct as dynamic).ids, (contains(CombatTechnique.wurfwaffen.id)));
        expect((ability.value.ct as dynamic).ids, isNot(contains(CombatTechnique.zweihandhiebwaffen.id)));
        expect((ability.value.ct as dynamic).ids, isNot(contains(CombatTechnique.zweihandschwerter.id)));
        expect((ability.value.ct as dynamic).ids, isNot(contains(CombatTechnique.feuerspeien.id)));
        expect((ability.value.ct as dynamic).ids, isNot(contains(CombatTechnique.blasrohre.id)));
        expect((ability.value.ct as dynamic).ids, isNot(contains(CombatTechnique.diskusse.id)));
        expect((ability.value.ct as dynamic).ids, isNot(contains(CombatTechnique.faecher.id)));
        expect((ability.value.ct as dynamic).ids, isNot(contains(CombatTechnique.spiesswaffen.id)));
      });
    });
    group('Schnellziehen', () {
      test('Combat Technique', () {
        final ability = SpecialAbility(SpecialAbilityBase.schnellziehen, null);

        expect(ability.value.type, SpecialAbilityType.passive);
        // check if ability.value.ct is instance of _Explicit
        expect(ability.value.ct, isA<ApplicableCombatTechniques>());
        expect(ability.value.ct.runtimeType.toString(), contains('_Explicit'));
        expect((ability.value.ct as dynamic).ids, isNotNull);
        expect((ability.value.ct as dynamic).ids, isA<List<String>>());
        expect((ability.value.ct as dynamic).ids, isNot(contains(CombatTechnique.armbrueste.id)));
        expect((ability.value.ct as dynamic).ids, isNot(contains(CombatTechnique.boegen.id)));
        expect((ability.value.ct as dynamic).ids, (contains(CombatTechnique.dolche.id)));
        expect((ability.value.ct as dynamic).ids, (contains(CombatTechnique.fechtwaffen.id)));
        expect((ability.value.ct as dynamic).ids, (contains(CombatTechnique.hiebwaffen.id)));
        expect((ability.value.ct as dynamic).ids, (contains(CombatTechnique.kettenwaffen.id)));
        expect((ability.value.ct as dynamic).ids, isNot(contains(CombatTechnique.lanzen.id)));
        expect((ability.value.ct as dynamic).ids, isNot(contains(CombatTechnique.peitschen.id)));
        expect((ability.value.ct as dynamic).ids, isNot(contains(CombatTechnique.raufen.id)));
        expect((ability.value.ct as dynamic).ids, isNot(contains(CombatTechnique.schilde.id)));
        expect((ability.value.ct as dynamic).ids, isNot(contains(CombatTechnique.schleudern.id)));
        expect((ability.value.ct as dynamic).ids, (contains(CombatTechnique.schwerter.id)));
        expect((ability.value.ct as dynamic).ids, (contains(CombatTechnique.stangenwaffen.id)));
        expect((ability.value.ct as dynamic).ids, isNot(contains(CombatTechnique.wurfwaffen.id)));
        expect((ability.value.ct as dynamic).ids, (contains(CombatTechnique.zweihandhiebwaffen.id)));
        expect((ability.value.ct as dynamic).ids, (contains(CombatTechnique.zweihandschwerter.id)));
        expect((ability.value.ct as dynamic).ids, isNot(contains(CombatTechnique.feuerspeien.id)));
        expect((ability.value.ct as dynamic).ids, isNot(contains(CombatTechnique.blasrohre.id)));
        expect((ability.value.ct as dynamic).ids, isNot(contains(CombatTechnique.diskusse.id)));
        expect((ability.value.ct as dynamic).ids, isNot(contains(CombatTechnique.faecher.id)));
        expect((ability.value.ct as dynamic).ids, isNot(contains(CombatTechnique.spiesswaffen.id)));
      });
    });
    group('Sturmangriff', () {
      test('Combat Technique', () {
        final ability = SpecialAbility(SpecialAbilityBase.sturmangriff, null);

        expect(ability.value.type, SpecialAbilityType.specialManeuvre);
        // check if ability.value.ct is instance of _Explicit
        expect(ability.value.ct, isA<ApplicableCombatTechniques>());
        expect(ability.value.ct.runtimeType.toString(), contains('_Explicit'));
        expect((ability.value.ct as dynamic).ids, isNotNull);
        expect((ability.value.ct as dynamic).ids, isA<List<String>>());
        expect((ability.value.ct as dynamic).ids, isNot(contains(CombatTechnique.armbrueste.id)));
        expect((ability.value.ct as dynamic).ids, isNot(contains(CombatTechnique.boegen.id)));
        expect((ability.value.ct as dynamic).ids, isNot(contains(CombatTechnique.dolche.id)));
        expect((ability.value.ct as dynamic).ids, isNot(contains(CombatTechnique.fechtwaffen.id)));
        expect((ability.value.ct as dynamic).ids, (contains(CombatTechnique.hiebwaffen.id)));
        expect((ability.value.ct as dynamic).ids, isNot(contains(CombatTechnique.kettenwaffen.id)));
        expect((ability.value.ct as dynamic).ids, isNot(contains(CombatTechnique.lanzen.id)));
        expect((ability.value.ct as dynamic).ids, isNot(contains(CombatTechnique.peitschen.id)));
        expect((ability.value.ct as dynamic).ids, isNot(contains(CombatTechnique.raufen.id)));
        expect((ability.value.ct as dynamic).ids, isNot(contains(CombatTechnique.schilde.id)));
        expect((ability.value.ct as dynamic).ids, isNot(contains(CombatTechnique.schleudern.id)));
        expect((ability.value.ct as dynamic).ids, (contains(CombatTechnique.schwerter.id)));
        expect((ability.value.ct as dynamic).ids, (contains(CombatTechnique.stangenwaffen.id)));
        expect((ability.value.ct as dynamic).ids, isNot(contains(CombatTechnique.wurfwaffen.id)));
        expect((ability.value.ct as dynamic).ids, (contains(CombatTechnique.zweihandhiebwaffen.id)));
        expect((ability.value.ct as dynamic).ids, (contains(CombatTechnique.zweihandschwerter.id)));
        expect((ability.value.ct as dynamic).ids, isNot(contains(CombatTechnique.feuerspeien.id)));
        expect((ability.value.ct as dynamic).ids, isNot(contains(CombatTechnique.blasrohre.id)));
        expect((ability.value.ct as dynamic).ids, isNot(contains(CombatTechnique.diskusse.id)));
        expect((ability.value.ct as dynamic).ids, isNot(contains(CombatTechnique.faecher.id)));
        expect((ability.value.ct as dynamic).ids, isNot(contains(CombatTechnique.spiesswaffen.id)));
      });
    });
    group('Todesstoß', () {
      test('Combat Technique', () {
        final ability = SpecialAbility(SpecialAbilityBase.todesstoss, null);

        expect(ability.value.type, SpecialAbilityType.specialManeuvre);
        // check if ability.value.ct is instance of _Explicit
        expect(ability.value.ct, isA<ApplicableCombatTechniques>());
        expect(ability.value.ct.runtimeType.toString(), contains('_Explicit'));
        expect((ability.value.ct as dynamic).ids, isNotNull);
        expect((ability.value.ct as dynamic).ids, isA<List<String>>());
        expect((ability.value.ct as dynamic).ids, isNot(contains(CombatTechnique.armbrueste.id)));
        expect((ability.value.ct as dynamic).ids, isNot(contains(CombatTechnique.boegen.id)));
        expect((ability.value.ct as dynamic).ids, (contains(CombatTechnique.dolche.id)));
        expect((ability.value.ct as dynamic).ids, (contains(CombatTechnique.fechtwaffen.id)));
        expect((ability.value.ct as dynamic).ids, isNot(contains(CombatTechnique.hiebwaffen.id)));
        expect((ability.value.ct as dynamic).ids, isNot(contains(CombatTechnique.kettenwaffen.id)));
        expect((ability.value.ct as dynamic).ids, isNot(contains(CombatTechnique.lanzen.id)));
        expect((ability.value.ct as dynamic).ids, isNot(contains(CombatTechnique.peitschen.id)));
        expect((ability.value.ct as dynamic).ids, isNot(contains(CombatTechnique.raufen.id)));
        expect((ability.value.ct as dynamic).ids, isNot(contains(CombatTechnique.schilde.id)));
        expect((ability.value.ct as dynamic).ids, isNot(contains(CombatTechnique.schleudern.id)));
        expect((ability.value.ct as dynamic).ids, isNot(contains(CombatTechnique.schwerter.id)));
        expect((ability.value.ct as dynamic).ids, isNot(contains(CombatTechnique.stangenwaffen.id)));
        expect((ability.value.ct as dynamic).ids, isNot(contains(CombatTechnique.wurfwaffen.id)));
        expect((ability.value.ct as dynamic).ids, isNot(contains(CombatTechnique.zweihandhiebwaffen.id)));
        expect((ability.value.ct as dynamic).ids, isNot(contains(CombatTechnique.zweihandschwerter.id)));
        expect((ability.value.ct as dynamic).ids, isNot(contains(CombatTechnique.feuerspeien.id)));
        expect((ability.value.ct as dynamic).ids, isNot(contains(CombatTechnique.blasrohre.id)));
        expect((ability.value.ct as dynamic).ids, isNot(contains(CombatTechnique.diskusse.id)));
        expect((ability.value.ct as dynamic).ids, isNot(contains(CombatTechnique.faecher.id)));
        expect((ability.value.ct as dynamic).ids, isNot(contains(CombatTechnique.spiesswaffen.id)));
      });
    });
    group('Verbessertes Ausweichen', () {
      test('Combat Technique', () {
        final ability = SpecialAbility(SpecialAbilityBase.verbessertesAusweichen, null);

        expect(ability.value.type, SpecialAbilityType.passive);
        // check if ability.value.ct is instance of _Explicit
        expect(ability.value.ct, isA<ApplicableCombatTechniques>());
        expect(ability.value.ct.runtimeType.toString(), contains('_All'));
      });
    });
    group('Verteidigungshaltung', () {
      test('Combat Technique', () {
        final ability = SpecialAbility(SpecialAbilityBase.verteidigungshaltung, null);

        expect(ability.value.type, SpecialAbilityType.passive);
        // check if ability.value.ct is instance of _Explicit
        expect(ability.value.ct, isA<ApplicableCombatTechniques>());
        expect(ability.value.ct.runtimeType.toString(), contains('_Explicit'));
        expect((ability.value.ct as dynamic).ids, isNotNull);
        expect((ability.value.ct as dynamic).ids, isA<List<String>>());
        expect((ability.value.ct as dynamic).ids, isNot(contains(CombatTechnique.armbrueste.id)));
        expect((ability.value.ct as dynamic).ids, isNot(contains(CombatTechnique.boegen.id)));
        expect((ability.value.ct as dynamic).ids, (contains(CombatTechnique.dolche.id)));
        expect((ability.value.ct as dynamic).ids, (contains(CombatTechnique.fechtwaffen.id)));
        expect((ability.value.ct as dynamic).ids, (contains(CombatTechnique.hiebwaffen.id)));
        expect((ability.value.ct as dynamic).ids, isNot(contains(CombatTechnique.kettenwaffen.id)));
        expect((ability.value.ct as dynamic).ids, isNot(contains(CombatTechnique.lanzen.id)));
        expect((ability.value.ct as dynamic).ids, isNot(contains(CombatTechnique.peitschen.id)));
        expect((ability.value.ct as dynamic).ids, (contains(CombatTechnique.raufen.id)));
        expect((ability.value.ct as dynamic).ids, (contains(CombatTechnique.schilde.id)));
        expect((ability.value.ct as dynamic).ids, isNot(contains(CombatTechnique.schleudern.id)));
        expect((ability.value.ct as dynamic).ids, (contains(CombatTechnique.schwerter.id)));
        expect((ability.value.ct as dynamic).ids, (contains(CombatTechnique.stangenwaffen.id)));
        expect((ability.value.ct as dynamic).ids, isNot(contains(CombatTechnique.wurfwaffen.id)));
        expect((ability.value.ct as dynamic).ids, (contains(CombatTechnique.zweihandhiebwaffen.id)));
        expect((ability.value.ct as dynamic).ids, (contains(CombatTechnique.zweihandschwerter.id)));
        expect((ability.value.ct as dynamic).ids, isNot(contains(CombatTechnique.feuerspeien.id)));
        expect((ability.value.ct as dynamic).ids, isNot(contains(CombatTechnique.blasrohre.id)));
        expect((ability.value.ct as dynamic).ids, isNot(contains(CombatTechnique.diskusse.id)));
        expect((ability.value.ct as dynamic).ids, isNot(contains(CombatTechnique.faecher.id)));
        expect((ability.value.ct as dynamic).ids, isNot(contains(CombatTechnique.spiesswaffen.id)));
      });
    });
    group('Wuchtschlag', () {
      test('Combat Technique', () {
        final ability = SpecialAbility(SpecialAbilityBase.wuchtschlag, null);

        expect(ability.value.type, SpecialAbilityType.baseManeuvre);
        // check if ability.value.ct is instance of _Explicit
        expect(ability.value.ct, isA<ApplicableCombatTechniques>());
        expect(ability.value.ct.runtimeType.toString(), contains('_Explicit'));
        expect((ability.value.ct as dynamic).ids, isNotNull);
        expect((ability.value.ct as dynamic).ids, isA<List<String>>());
        expect((ability.value.ct as dynamic).ids, isNot(contains(CombatTechnique.armbrueste.id)));
        expect((ability.value.ct as dynamic).ids, isNot(contains(CombatTechnique.boegen.id)));
        expect((ability.value.ct as dynamic).ids, isNot(contains(CombatTechnique.dolche.id)));
        expect((ability.value.ct as dynamic).ids, isNot(contains(CombatTechnique.fechtwaffen.id)));
        expect((ability.value.ct as dynamic).ids, (contains(CombatTechnique.hiebwaffen.id)));
        expect((ability.value.ct as dynamic).ids, (contains(CombatTechnique.kettenwaffen.id)));
        expect((ability.value.ct as dynamic).ids, isNot(contains(CombatTechnique.lanzen.id)));
        expect((ability.value.ct as dynamic).ids, isNot(contains(CombatTechnique.peitschen.id)));
        expect((ability.value.ct as dynamic).ids, (contains(CombatTechnique.raufen.id)));
        expect((ability.value.ct as dynamic).ids, isNot(contains(CombatTechnique.schilde.id)));
        expect((ability.value.ct as dynamic).ids, isNot(contains(CombatTechnique.schleudern.id)));
        expect((ability.value.ct as dynamic).ids, (contains(CombatTechnique.schwerter.id)));
        expect((ability.value.ct as dynamic).ids, (contains(CombatTechnique.stangenwaffen.id)));
        expect((ability.value.ct as dynamic).ids, isNot(contains(CombatTechnique.wurfwaffen.id)));
        expect((ability.value.ct as dynamic).ids, (contains(CombatTechnique.zweihandhiebwaffen.id)));
        expect((ability.value.ct as dynamic).ids, (contains(CombatTechnique.zweihandschwerter.id)));
        expect((ability.value.ct as dynamic).ids, isNot(contains(CombatTechnique.feuerspeien.id)));
        expect((ability.value.ct as dynamic).ids, isNot(contains(CombatTechnique.blasrohre.id)));
        expect((ability.value.ct as dynamic).ids, isNot(contains(CombatTechnique.diskusse.id)));
        expect((ability.value.ct as dynamic).ids, isNot(contains(CombatTechnique.faecher.id)));
        expect((ability.value.ct as dynamic).ids, isNot(contains(CombatTechnique.spiesswaffen.id)));
      });
    });
    group('Wurf', () {
      test('Combat Technique', () {
        final ability = SpecialAbility(SpecialAbilityBase.wurf, null);

        expect(ability.value.type, SpecialAbilityType.specialManeuvre);
        // check if ability.value.ct is instance of _Explicit
        expect(ability.value.ct, isA<ApplicableCombatTechniques>());
        expect(ability.value.ct.runtimeType.toString(), contains('_Explicit'));
        expect((ability.value.ct as dynamic).ids, isNotNull);
        expect((ability.value.ct as dynamic).ids, isA<List<String>>());
        expect((ability.value.ct as dynamic).ids, isNot(contains(CombatTechnique.armbrueste.id)));
        expect((ability.value.ct as dynamic).ids, isNot(contains(CombatTechnique.boegen.id)));
        expect((ability.value.ct as dynamic).ids, isNot(contains(CombatTechnique.dolche.id)));
        expect((ability.value.ct as dynamic).ids, isNot(contains(CombatTechnique.fechtwaffen.id)));
        expect((ability.value.ct as dynamic).ids, isNot(contains(CombatTechnique.hiebwaffen.id)));
        expect((ability.value.ct as dynamic).ids, isNot(contains(CombatTechnique.kettenwaffen.id)));
        expect((ability.value.ct as dynamic).ids, isNot(contains(CombatTechnique.lanzen.id)));
        expect((ability.value.ct as dynamic).ids, isNot(contains(CombatTechnique.peitschen.id)));
        expect((ability.value.ct as dynamic).ids, (contains(CombatTechnique.raufen.id)));
        expect((ability.value.ct as dynamic).ids, isNot(contains(CombatTechnique.schilde.id)));
        expect((ability.value.ct as dynamic).ids, isNot(contains(CombatTechnique.schleudern.id)));
        expect((ability.value.ct as dynamic).ids, isNot(contains(CombatTechnique.schwerter.id)));
        expect((ability.value.ct as dynamic).ids, isNot(contains(CombatTechnique.stangenwaffen.id)));
        expect((ability.value.ct as dynamic).ids, isNot(contains(CombatTechnique.wurfwaffen.id)));
        expect((ability.value.ct as dynamic).ids, isNot(contains(CombatTechnique.zweihandhiebwaffen.id)));
        expect((ability.value.ct as dynamic).ids, isNot(contains(CombatTechnique.zweihandschwerter.id)));
        expect((ability.value.ct as dynamic).ids, isNot(contains(CombatTechnique.feuerspeien.id)));
        expect((ability.value.ct as dynamic).ids, isNot(contains(CombatTechnique.blasrohre.id)));
        expect((ability.value.ct as dynamic).ids, isNot(contains(CombatTechnique.diskusse.id)));
        expect((ability.value.ct as dynamic).ids, isNot(contains(CombatTechnique.faecher.id)));
        expect((ability.value.ct as dynamic).ids, isNot(contains(CombatTechnique.spiesswaffen.id)));
      });
    });
    group('Zu Fall Bringen', () {
      test('Combat Technique', () {
        final ability = SpecialAbility(SpecialAbilityBase.zuFallBringen, null);

        expect(ability.value.type, SpecialAbilityType.specialManeuvre);
        // check if ability.value.ct is instance of _Explicit
        expect(ability.value.ct, isA<ApplicableCombatTechniques>());
        expect(ability.value.ct.runtimeType.toString(), contains('_Explicit'));
        expect((ability.value.ct as dynamic).ids, isNotNull);
        expect((ability.value.ct as dynamic).ids, isA<List<String>>());
        expect((ability.value.ct as dynamic).ids, isNot(contains(CombatTechnique.armbrueste.id)));
        expect((ability.value.ct as dynamic).ids, isNot(contains(CombatTechnique.boegen.id)));
        expect((ability.value.ct as dynamic).ids, isNot(contains(CombatTechnique.dolche.id)));
        expect((ability.value.ct as dynamic).ids, isNot(contains(CombatTechnique.fechtwaffen.id)));
        expect((ability.value.ct as dynamic).ids, isNot(contains(CombatTechnique.hiebwaffen.id)));
        expect((ability.value.ct as dynamic).ids, isNot(contains(CombatTechnique.kettenwaffen.id)));
        expect((ability.value.ct as dynamic).ids, isNot(contains(CombatTechnique.lanzen.id)));
        expect((ability.value.ct as dynamic).ids, isNot(contains(CombatTechnique.peitschen.id)));
        expect((ability.value.ct as dynamic).ids, isNot(contains(CombatTechnique.raufen.id)));
        expect((ability.value.ct as dynamic).ids, isNot(contains(CombatTechnique.schilde.id)));
        expect((ability.value.ct as dynamic).ids, isNot(contains(CombatTechnique.schleudern.id)));
        expect((ability.value.ct as dynamic).ids, isNot(contains(CombatTechnique.schwerter.id)));
        expect((ability.value.ct as dynamic).ids, (contains(CombatTechnique.stangenwaffen.id)));
        expect((ability.value.ct as dynamic).ids, isNot(contains(CombatTechnique.wurfwaffen.id)));
        expect((ability.value.ct as dynamic).ids, isNot(contains(CombatTechnique.zweihandhiebwaffen.id)));
        expect((ability.value.ct as dynamic).ids, isNot(contains(CombatTechnique.zweihandschwerter.id)));
        expect((ability.value.ct as dynamic).ids, isNot(contains(CombatTechnique.feuerspeien.id)));
        expect((ability.value.ct as dynamic).ids, isNot(contains(CombatTechnique.blasrohre.id)));
        expect((ability.value.ct as dynamic).ids, isNot(contains(CombatTechnique.diskusse.id)));
        expect((ability.value.ct as dynamic).ids, isNot(contains(CombatTechnique.faecher.id)));
        expect((ability.value.ct as dynamic).ids, isNot(contains(CombatTechnique.spiesswaffen.id)));
      });
    });



    // test('wuchtschlag impact returns correct atMod and tpMod', () {
    //   final ability = SpecialAbility(SpecialAbilityBase.wuchtschlag, 2);
    //   final impact = SpecialAbilityImpact.fromActive(ability, null, null, 0);
    //   expect(impact.atMod, equals(-4)); // -2 * tier
    //   expect(impact.tpMod, equals(4)); // 2 * tier
    // });

    // test('finte impact returns correct atMod', () {
    //   final ability = SpecialAbility(SpecialAbilityBase.finte, 3);
    //   final impact = SpecialAbilityImpact.fromActive(ability, null, null, 0);
    //   expect(impact.atMod, equals(-3));
    // });

    // test('riposte impact returns correct paMod', () {
    //   final ability = SpecialAbility(SpecialAbilityBase.riposte, null);
    //   final impact = SpecialAbilityImpact.fromActive(ability, null, null, 0);
    //   expect(impact.paMod, equals(-2));
    // });

    // test('none impact returns all mods zero except modifier', () {
    //   final impact = SpecialAbilityImpact.none(5);
    //   expect(impact.atMod, equals(0));
    //   expect(impact.paMod, equals(0));
    //   expect(impact.awMod, equals(0));
    //   expect(impact.tpMod, equals(0));
    //   expect(impact.modifier, equals(5));
    // });
  });
}


    // group('...', () {
    //   test('Combat Technique', () {
    //     final ability = SpecialAbility(SpecialAbilityBase., null);

    //     expect(ability.value.type, SpecialAbilityType.passive);
    //     // check if ability.value.ct is instance of _Explicit
    //     expect(ability.value.ct, isA<ApplicableCombatTechniques>());
    //     expect(ability.value.ct.runtimeType.toString(), contains('_Explicit'));
    //     expect((ability.value.ct as dynamic).ids, isNotNull);
    //     expect((ability.value.ct as dynamic).ids, isA<List<String>>());
    //     expect((ability.value.ct as dynamic).ids, isNot(contains(CombatTechnique.armbrueste.id)));
    //     expect((ability.value.ct as dynamic).ids, isNot(contains(CombatTechnique.boegen.id)));
    //     expect((ability.value.ct as dynamic).ids, isNot(contains(CombatTechnique.dolche.id)));
    //     expect((ability.value.ct as dynamic).ids, isNot(contains(CombatTechnique.fechtwaffen.id)));
    //     expect((ability.value.ct as dynamic).ids, isNot(contains(CombatTechnique.hiebwaffen.id)));
    //     expect((ability.value.ct as dynamic).ids, isNot(contains(CombatTechnique.kettenwaffen.id)));
    //     expect((ability.value.ct as dynamic).ids, isNot(contains(CombatTechnique.lanzen.id)));
    //     expect((ability.value.ct as dynamic).ids, isNot(contains(CombatTechnique.peitschen.id)));
    //     expect((ability.value.ct as dynamic).ids, isNot(contains(CombatTechnique.raufen.id)));
    //     expect((ability.value.ct as dynamic).ids, isNot(contains(CombatTechnique.schilde.id)));
    //     expect((ability.value.ct as dynamic).ids, isNot(contains(CombatTechnique.schleudern.id)));
    //     expect((ability.value.ct as dynamic).ids, isNot(contains(CombatTechnique.schwerter.id)));
    //     expect((ability.value.ct as dynamic).ids, isNot(contains(CombatTechnique.stangenwaffen.id)));
    //     expect((ability.value.ct as dynamic).ids, isNot(contains(CombatTechnique.wurfwaffen.id)));
    //     expect((ability.value.ct as dynamic).ids, isNot(contains(CombatTechnique.zweihandhiebwaffen.id)));
    //     expect((ability.value.ct as dynamic).ids, isNot(contains(CombatTechnique.zweihandschwerter.id)));
    //     expect((ability.value.ct as dynamic).ids, isNot(contains(CombatTechnique.feuerspeien.id)));
    //     expect((ability.value.ct as dynamic).ids, isNot(contains(CombatTechnique.blasrohre.id)));
    //     expect((ability.value.ct as dynamic).ids, isNot(contains(CombatTechnique.diskusse.id)));
    //     expect((ability.value.ct as dynamic).ids, isNot(contains(CombatTechnique.faecher.id)));
    //     expect((ability.value.ct as dynamic).ids, isNot(contains(CombatTechnique.spiesswaffen.id)));
    //   });
    // });