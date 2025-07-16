import 'package:eorla/models/audit.dart';
import 'package:eorla/models/probabilities.dart';
import 'package:eorla/models/rules.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:eorla/models/weapons.dart';
import 'package:eorla/models/special_abilities.dart';
import 'package:eorla/models/special_abilities_impl.dart';

import 'rules_test.dart';

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

  group('Combat techniques assignment', () {
    test('Armbrüste', () {
      final ct = CombatTechnique.armbrueste;
      expect(ct.group == CombatType.melee, false); // Melee
      expect(oneHandedCTs.contains(ct.id), false); // Melee One Handed
      expect(
        ct.group == CombatType.melee && !ct.hasNoParry,
        false,
      ); // Melee with Parry
      expect(ct.group == CombatType.range, true); // Ranged
    });
    test('Bögen', () {
      final ct = CombatTechnique.boegen;
      expect(ct.group == CombatType.melee, false); // Melee
      expect(oneHandedCTs.contains(ct.id), false); // Melee One Handed
      expect(
        ct.group == CombatType.melee && !ct.hasNoParry,
        false,
      ); // Melee with Parry
      expect(ct.group == CombatType.range, true); // Ranged
    });
    test('Dolche', () {
      final ct = CombatTechnique.dolche;
      expect(ct.group == CombatType.melee, true); // Melee
      expect(oneHandedCTs.contains(ct.id), true); // Melee One Handed
      expect(
        ct.group == CombatType.melee && !ct.hasNoParry,
        true,
      ); // Melee with Parry
      expect(ct.group == CombatType.range, false); // Ranged
    });
    test('Fechtwaffen', () {
      final ct = CombatTechnique.fechtwaffen;
      expect(ct.group == CombatType.melee, true); // Melee
      expect(oneHandedCTs.contains(ct.id), true); // Melee One Handed
      expect(
        ct.group == CombatType.melee && !ct.hasNoParry,
        true,
      ); // Melee with Parry
      expect(ct.group == CombatType.range, false); // Ranged
    });

    test('Hiebwaffen', () {
      final ct = CombatTechnique.hiebwaffen;
      expect(ct.group == CombatType.melee, true); // Melee
      expect(oneHandedCTs.contains(ct.id), true); // Melee One Handed
      expect(
        ct.group == CombatType.melee && !ct.hasNoParry,
        true,
      ); // Melee with Parry
      expect(ct.group == CombatType.range, false); // Ranged
    });

    test('Kettenwaffen', () {
      final ct = CombatTechnique.kettenwaffen;
      expect(ct.group == CombatType.melee, true); // Melee
      expect(oneHandedCTs.contains(ct.id), true); // Melee One Handed
      expect(
        ct.group == CombatType.melee && !ct.hasNoParry,
        false,
      ); // Melee with Parry
      expect(ct.group == CombatType.range, false); // Ranged
    });

    test('Lanzen', () {
      final ct = CombatTechnique.lanzen;
      expect(ct.group == CombatType.melee, true); // Melee
      expect(oneHandedCTs.contains(ct.id), false); // Melee One Handed
      expect(
        ct.group == CombatType.melee && !ct.hasNoParry,
        true,
      ); // Melee with Parry
      expect(ct.group == CombatType.range, false); // Ranged
    });

    test('Peitschen', () {
      final ct = CombatTechnique.peitschen;
      expect(ct.group == CombatType.melee, true); // Melee
      expect(oneHandedCTs.contains(ct.id), true); // Melee One Handed
      expect(
        ct.group == CombatType.melee && !ct.hasNoParry,
        false,
      ); // Melee with Parry
      expect(ct.group == CombatType.range, false); // Ranged
    });

    test('Raufen', () {
      final ct = CombatTechnique.raufen;
      expect(ct.group == CombatType.melee, true); // Melee
      expect(oneHandedCTs.contains(ct.id), false); // Melee One Handed
      expect(
        ct.group == CombatType.melee && !ct.hasNoParry,
        true,
      ); // Melee with Parry
      expect(ct.group == CombatType.range, false); // Ranged
    });

    test('Schilde', () {
      final ct = CombatTechnique.schilde;
      expect(ct.group == CombatType.melee, true); // Melee
      expect(oneHandedCTs.contains(ct.id), true); // Melee One Handed
      expect(
        ct.group == CombatType.melee && !ct.hasNoParry,
        true,
      ); // Melee with Parry
      expect(ct.group == CombatType.range, false); // Ranged
    });

    test('Schleudern', () {
      final ct = CombatTechnique.schleudern;
      expect(ct.group == CombatType.range, true); // Ranged
      expect(oneHandedCTs.contains(ct.id), false); // Melee One Handed
      expect(
        ct.group == CombatType.melee && !ct.hasNoParry,
        false,
      ); // Melee with Parry
      expect(ct.group == CombatType.melee, false); // Melee
    });

    test('Schwerter', () {
      final ct = CombatTechnique.schwerter;
      expect(ct.group == CombatType.melee, true); // Melee
      expect(oneHandedCTs.contains(ct.id), true); // Melee One Handed
      expect(
        ct.group == CombatType.melee && !ct.hasNoParry,
        true,
      ); // Melee with Parry
      expect(ct.group == CombatType.range, false); // Ranged
    });

    test('Stangenwaffen', () {
      final ct = CombatTechnique.stangenwaffen;
      expect(ct.group == CombatType.melee, true); // Melee
      expect(oneHandedCTs.contains(ct.id), false); // Melee One Handed
      expect(
        ct.group == CombatType.melee && !ct.hasNoParry,
        true,
      ); // Melee with Parry
      expect(ct.group == CombatType.range, false); // Ranged
    });

    test('Wurfwaffen', () {
      final ct = CombatTechnique.wurfwaffen;
      expect(ct.group == CombatType.range, true); // Ranged
      expect(oneHandedCTs.contains(ct.id), false); // Melee One Handed
      expect(
        ct.group == CombatType.melee && !ct.hasNoParry,
        false,
      ); // Melee with Parry
      expect(ct.group == CombatType.melee, false); // Melee
    });

    test('Zweihandhiebwaffen', () {
      final ct = CombatTechnique.zweihandhiebwaffen;
      expect(ct.group == CombatType.melee, true); // Melee
      expect(oneHandedCTs.contains(ct.id), false); // Melee One Handed
      expect(
        ct.group == CombatType.melee && !ct.hasNoParry,
        true,
      ); // Melee with Parry
      expect(ct.group == CombatType.range, false); // Ranged
    });

    test('Zweihandschwerter', () {
      final ct = CombatTechnique.zweihandschwerter;
      expect(ct.group == CombatType.melee, true); // Melee
      expect(oneHandedCTs.contains(ct.id), false); // Melee One Handed
      expect(
        ct.group == CombatType.melee && !ct.hasNoParry,
        true,
      ); // Melee with Parry
      expect(ct.group == CombatType.range, false); // Ranged
    });

    test('Feuerspeien', () {
      final ct = CombatTechnique.feuerspeien;
      expect(ct.group == CombatType.range, true); // Ranged
      expect(oneHandedCTs.contains(ct.id), false); // Melee One Handed
      expect(
        ct.group == CombatType.melee && !ct.hasNoParry,
        false,
      ); // Melee with Parry
      expect(ct.group == CombatType.melee, false); // Melee
    });

    test('Blasrohre', () {
      final ct = CombatTechnique.blasrohre;
      expect(ct.group == CombatType.range, true); // Ranged
      expect(oneHandedCTs.contains(ct.id), false); // Melee One Handed
      expect(
        ct.group == CombatType.melee && !ct.hasNoParry,
        false,
      ); // Melee with Parry
      expect(ct.group == CombatType.melee, false); // Melee
    });

    test('Diskusse', () {
      final ct = CombatTechnique.diskusse;
      expect(ct.group == CombatType.range, true); // Ranged
      expect(oneHandedCTs.contains(ct.id), false); // Melee One Handed
      expect(
        ct.group == CombatType.melee && !ct.hasNoParry,
        false,
      ); // Melee with Parry
      expect(ct.group == CombatType.melee, false); // Melee
    });

    test('Fächer', () {
      final ct = CombatTechnique.faecher;
      expect(ct.group == CombatType.melee, true); // Melee
      expect(oneHandedCTs.contains(ct.id), true); // Melee One Handed
      expect(
        ct.group == CombatType.melee && !ct.hasNoParry,
        true,
      ); // Melee with Parry
      expect(ct.group == CombatType.range, false); // Ranged
    });

    test('Spiesswaffen', () {
      final ct = CombatTechnique.spiesswaffen;
      expect(ct.group == CombatType.melee, true); // Melee
      expect(oneHandedCTs.contains(ct.id), false); // Melee One Handed
      expect(
        ct.group == CombatType.melee && !ct.hasNoParry,
        true,
      ); // Melee with Parry
      expect(ct.group == CombatType.range, false); // Ranged
    });
  });

  group('SpecialAbilityImpact', () {
    group('Armbrust überdrehen', () {
      test('Combat Technique', () {
        final ability = SpecialAbility(
          SpecialAbilityBase.armbrustUeberdrehen,
          null,
        );

        expect(ability.value.type, SpecialAbilityType.passive);
        // check if ability.value.ct is instance of _Explicit
        expect(ability.value.ct, isA<ApplicableCombatTechniques>());
        expect(ability.value.ct.runtimeType.toString(), contains('_Explicit'));
        expect((ability.value.ct as dynamic).ids, isNotNull);
        expect((ability.value.ct as dynamic).ids, isA<List<String>>());
        expect(
          (ability.value.ct as dynamic).ids,
          (contains(CombatTechnique.armbrueste.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.boegen.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.dolche.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.fechtwaffen.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.hiebwaffen.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.kettenwaffen.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.lanzen.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.peitschen.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.raufen.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.schilde.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.schleudern.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.schwerter.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.stangenwaffen.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.wurfwaffen.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.zweihandhiebwaffen.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.zweihandschwerter.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.feuerspeien.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.blasrohre.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.diskusse.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.faecher.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.spiesswaffen.id)),
        );
      });
    });
    group('Auf Distanz halten', () {
      test('Combat Technique', () {
        final ability = SpecialAbility(
          SpecialAbilityBase.aufDistanzHalten,
          null,
        );

        expect(ability.value.type, SpecialAbilityType.passive);
        // check if ability.value.ct is instance of _Explicit
        expect(ability.value.ct, isA<ApplicableCombatTechniques>());
        expect(ability.value.ct.runtimeType.toString(), contains('_Melee'));
      });
    });
    group('Auflaufen', () {
      test('Combat Technique', () {
        final ability = SpecialAbility(SpecialAbilityBase.auflaufen, null);

        expect(ability.value.type, SpecialAbilityType.specialManeuvre);
        // check if ability.value.ct is instance of _Explicit
        expect(ability.value.ct, isA<ApplicableCombatTechniques>());
        expect(ability.value.ct.runtimeType.toString(), contains('_Explicit'));
        expect((ability.value.ct as dynamic).ids, isNotNull);
        expect((ability.value.ct as dynamic).ids, isA<List<String>>());
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.armbrueste.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.boegen.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.dolche.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.fechtwaffen.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.hiebwaffen.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.kettenwaffen.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          (contains(CombatTechnique.lanzen.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.peitschen.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.raufen.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.schilde.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.schleudern.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.schwerter.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.stangenwaffen.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.wurfwaffen.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.zweihandhiebwaffen.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.zweihandschwerter.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.feuerspeien.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.blasrohre.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.diskusse.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.faecher.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          (contains(CombatTechnique.spiesswaffen.id)),
        );
      });
    });
    test('Aufmerksamkeit', () {
      final ability = SpecialAbility(SpecialAbilityBase.aufmerksamkeit, null);

      expect(ability.value.type, SpecialAbilityType.passive); // passive
      // check if ability.value.ct is instance of _All
      expect(ability.value.ct, isA<ApplicableCombatTechniques>());
      expect(ability.value.ct.runtimeType.toString(), contains('_All'));
    });
    group('Ausfall', () {
      test('Combat Technique', () {
        final ability = SpecialAbility(SpecialAbilityBase.ausfall, null);

        expect(ability.value.type, SpecialAbilityType.specialManeuvre);
        // check if ability.value.ct is instance of _Explicit
        expect(ability.value.ct, isA<ApplicableCombatTechniques>());
        expect(ability.value.ct.runtimeType.toString(), contains('_Explicit'));
        expect((ability.value.ct as dynamic).ids, isNotNull);
        expect((ability.value.ct as dynamic).ids, isA<List<String>>());
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.armbrueste.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.boegen.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          (contains(CombatTechnique.dolche.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          (contains(CombatTechnique.fechtwaffen.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.hiebwaffen.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.kettenwaffen.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.lanzen.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.peitschen.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.raufen.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.schilde.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.schleudern.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.schwerter.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.stangenwaffen.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.wurfwaffen.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.zweihandhiebwaffen.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.zweihandschwerter.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.feuerspeien.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.blasrohre.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.diskusse.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          (contains(CombatTechnique.faecher.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.spiesswaffen.id)),
        );
      });
    });
    group('Ballistischer Schuss', () {
      test('Combat Technique', () {
        final ability = SpecialAbility(
          SpecialAbilityBase.ballistischerSchuss,
          null,
        );

        expect(ability.value.type, SpecialAbilityType.specialManeuvre);
        // check if ability.value.ct is instance of _Explicit
        expect(ability.value.ct, isA<ApplicableCombatTechniques>());
        expect(ability.value.ct.runtimeType.toString(), contains('_Explicit'));
        expect((ability.value.ct as dynamic).ids, isNotNull);
        expect((ability.value.ct as dynamic).ids, isA<List<String>>());
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.armbrueste.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          (contains(CombatTechnique.boegen.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.dolche.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.fechtwaffen.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.hiebwaffen.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.kettenwaffen.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.lanzen.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.peitschen.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.raufen.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.schilde.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.schleudern.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.schwerter.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.stangenwaffen.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.wurfwaffen.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.zweihandhiebwaffen.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.zweihandschwerter.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.feuerspeien.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.blasrohre.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.diskusse.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.faecher.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.spiesswaffen.id)),
        );
      });
    });
    group('Beidhändiger Kampf', () {
      test('Combat Technique', () {
        final ability = SpecialAbility(
          SpecialAbilityBase.beidhaendigerKampf,
          null,
        );

        expect(ability.value.type, SpecialAbilityType.passive); // passive
        // check if ability.value.ct is instance of _Explicit
        expect(ability.value.ct, isA<ApplicableCombatTechniques>());
        expect(ability.value.ct.runtimeType.toString(), contains('_Explicit'));
        expect((ability.value.ct as dynamic).ids, isNotNull);
        expect((ability.value.ct as dynamic).ids, isA<List<String>>());
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.armbrueste.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.boegen.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          contains(CombatTechnique.dolche.id),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          contains(CombatTechnique.fechtwaffen.id),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          contains(CombatTechnique.hiebwaffen.id),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.kettenwaffen.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.lanzen.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.peitschen.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          contains(CombatTechnique.raufen.id),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          contains(CombatTechnique.schilde.id),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.schleudern.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          contains(CombatTechnique.schwerter.id),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.stangenwaffen.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.wurfwaffen.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.zweihandhiebwaffen.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.zweihandschwerter.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.feuerspeien.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.blasrohre.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.diskusse.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.faecher.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.spiesswaffen.id)),
        );
      });
      test('Stufe I', () {
        final ability = SpecialAbility(
          SpecialAbilityBase.beidhaendigerKampf,
          1,
        );

        expect(ability.tier, 1); // tier should be 1
      });
      test('Stufe II', () {
        final ability = SpecialAbility(
          SpecialAbilityBase.beidhaendigerKampf,
          2,
        );

        expect(ability.tier, 2); // tier should be 2
      });
    });
    group('Belastungsgewöhung', () {
      test('Stufe I', () {
        final ability = SpecialAbility(
          SpecialAbilityBase.belastungsgewoehnung,
          1,
        );

        expect(ability.value.type, SpecialAbilityType.passive); // passive
        // check if ability.value.ct is instance of _All
        expect(ability.value.ct, isA<ApplicableCombatTechniques>());
        expect(ability.value.ct.runtimeType.toString(), contains('_All'));
        expect(ability.tier, 1); // tier should be 1
      });
      test('Stufe II', () {
        final ability = SpecialAbility(
          SpecialAbilityBase.belastungsgewoehnung,
          2,
        );

        expect(ability.value.type, SpecialAbilityType.passive); // passive
        // check if ability.value.ct is instance of _All
        expect(ability.value.ct, isA<ApplicableCombatTechniques>());
        expect(ability.value.ct.runtimeType.toString(), contains('_All'));
        expect(ability.tier, 2); // tier should be 2
      });
    });
    group('Berittene Lanzenformation', () {
      test('Combat Technique', () {
        final ability = SpecialAbility(
          SpecialAbilityBase.beritteneLanzenformation,
          null,
        );

        expect(ability.value.type, SpecialAbilityType.passive);
        // check if ability.value.ct is instance of _Explicit
        expect(ability.value.ct, isA<ApplicableCombatTechniques>());
        expect(ability.value.ct.runtimeType.toString(), contains('_Explicit'));
        expect((ability.value.ct as dynamic).ids, isNotNull);
        expect((ability.value.ct as dynamic).ids, isA<List<String>>());
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.armbrueste.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.boegen.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.dolche.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.fechtwaffen.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.hiebwaffen.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.kettenwaffen.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          (contains(CombatTechnique.lanzen.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.peitschen.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.raufen.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.schilde.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.schleudern.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.schwerter.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.stangenwaffen.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.wurfwaffen.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.zweihandhiebwaffen.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.zweihandschwerter.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.feuerspeien.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.blasrohre.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.diskusse.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.faecher.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.spiesswaffen.id)),
        );
      });
    });
    group('Berittener Flugkampf', () {
      test('Combat Technique', () {
        final ability = SpecialAbility(
          SpecialAbilityBase.berittenerFlugkampf,
          null,
        );

        expect(ability.value.type, SpecialAbilityType.passive);
        // check if ability.value.ct is instance of _Explicit
        expect(ability.value.ct, isA<ApplicableCombatTechniques>());
        expect(ability.value.ct.runtimeType.toString(), contains('_All'));
      });
    });
    group('Berittener Kampf', () {
      test('Combat Technique', () {
        final ability = SpecialAbility(
          SpecialAbilityBase.berittenerKampf,
          null,
        );

        expect(ability.value.type, SpecialAbilityType.passive);
        // check if ability.value.ct is instance of _Explicit
        expect(ability.value.ct, isA<ApplicableCombatTechniques>());
        expect(ability.value.ct.runtimeType.toString(), contains('_All'));
      });
    });
    group('Berittener Schütze', () {
      test('Combat Technique', () {
        final ability = SpecialAbility(
          SpecialAbilityBase.berittenerSchuetze,
          null,
        );

        expect(ability.value.type, SpecialAbilityType.passive); // passive
        // check if ability.value.ct is instance of _Explicit
        expect(ability.value.ct, isA<ApplicableCombatTechniques>());
        expect(ability.value.ct.runtimeType.toString(), contains('_Explicit'));
        expect((ability.value.ct as dynamic).ids, isNotNull);
        expect((ability.value.ct as dynamic).ids, isA<List<String>>());
        expect(
          (ability.value.ct as dynamic).ids,
          contains(CombatTechnique.armbrueste.id),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          contains(CombatTechnique.boegen.id),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.dolche.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.fechtwaffen.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.hiebwaffen.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.kettenwaffen.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.lanzen.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.peitschen.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.raufen.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.schilde.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          (contains(CombatTechnique.schleudern.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.schwerter.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.stangenwaffen.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          contains(CombatTechnique.wurfwaffen.id),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.zweihandhiebwaffen.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.zweihandschwerter.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.feuerspeien.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.blasrohre.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.diskusse.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.faecher.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.spiesswaffen.id)),
        );
      });
    });
    group('Beschützer', () {
      test('Combat Technique', () {
        final ability = SpecialAbility(SpecialAbilityBase.beschuetzer, null);

        expect(ability.value.type, SpecialAbilityType.passive);
        // check if ability.value.ct is instance of _Explicit
        expect(ability.value.ct, isA<ApplicableCombatTechniques>());
        expect(ability.value.ct.runtimeType.toString(), contains('_Explicit'));
        expect((ability.value.ct as dynamic).ids, isNotNull);
        expect((ability.value.ct as dynamic).ids, isA<List<String>>());
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.armbrueste.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.boegen.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          (contains(CombatTechnique.dolche.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          (contains(CombatTechnique.fechtwaffen.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          (contains(CombatTechnique.hiebwaffen.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.kettenwaffen.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.lanzen.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.peitschen.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.raufen.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          (contains(CombatTechnique.schilde.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.schleudern.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          (contains(CombatTechnique.schwerter.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          (contains(CombatTechnique.stangenwaffen.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.wurfwaffen.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.zweihandhiebwaffen.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.zweihandschwerter.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.feuerspeien.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.blasrohre.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.diskusse.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.faecher.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.spiesswaffen.id)),
        );
      });
    });
    group('Betäubungsschlag', () {
      test('Combat Technique', () {
        final ability = SpecialAbility(
          SpecialAbilityBase.betaeubungsschlag,
          null,
        );

        expect(ability.value.type, SpecialAbilityType.specialManeuvre);
        // check if ability.value.ct is instance of _Explicit
        expect(ability.value.ct, isA<ApplicableCombatTechniques>());
        expect(ability.value.ct.runtimeType.toString(), contains('_Explicit'));
        expect((ability.value.ct as dynamic).ids, isNotNull);
        expect((ability.value.ct as dynamic).ids, isA<List<String>>());
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.armbrueste.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.boegen.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.dolche.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.fechtwaffen.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          (contains(CombatTechnique.hiebwaffen.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.kettenwaffen.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.lanzen.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.peitschen.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.raufen.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.schilde.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.schleudern.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          (contains(CombatTechnique.schwerter.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          (contains(CombatTechnique.stangenwaffen.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.wurfwaffen.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.zweihandhiebwaffen.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.zweihandschwerter.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.feuerspeien.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.blasrohre.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.diskusse.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.faecher.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.spiesswaffen.id)),
        );
      });
    });
    group('Blindkampf', () {
      test('Combat Technique', () {
        final ability = SpecialAbility(SpecialAbilityBase.blindkampf, null);

        expect(ability.value.type, SpecialAbilityType.passive);
        // check if ability.value.ct is instance of _Explicit
        expect(ability.value.ct, isA<ApplicableCombatTechniques>());
        expect(ability.value.ct.runtimeType.toString(), contains('_Melee'));
      });
    });
    group('Blutgrätsche', () {
      test('Combat Technique', () {
        final ability = SpecialAbility(SpecialAbilityBase.blutgraetsche, null);

        expect(ability.value.type, SpecialAbilityType.specialManeuvre);
        // check if ability.value.ct is instance of _Explicit
        expect(ability.value.ct, isA<ApplicableCombatTechniques>());
        expect(ability.value.ct.runtimeType.toString(), contains('_Explicit'));
        expect((ability.value.ct as dynamic).ids, isNotNull);
        expect((ability.value.ct as dynamic).ids, isA<List<String>>());
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.armbrueste.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.boegen.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.dolche.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.fechtwaffen.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.hiebwaffen.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.kettenwaffen.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.lanzen.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.peitschen.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          (contains(CombatTechnique.raufen.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.schilde.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.schleudern.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.schwerter.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.stangenwaffen.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.wurfwaffen.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.zweihandhiebwaffen.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.zweihandschwerter.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.feuerspeien.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.blasrohre.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.diskusse.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.faecher.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.spiesswaffen.id)),
        );
      });
    });
    group('Doppelangriff', () {
      test('Combat Technique', () {
        final ability = SpecialAbility(SpecialAbilityBase.doppelangriff, null);

        expect(ability.value.type, SpecialAbilityType.specialManeuvre);
        // check if ability.value.ct is instance of _Explicit
        expect(ability.value.ct, isA<ApplicableCombatTechniques>());
        expect(ability.value.ct.runtimeType.toString(), contains('_Explicit'));
        expect((ability.value.ct as dynamic).ids, isNotNull);
        expect((ability.value.ct as dynamic).ids, isA<List<String>>());
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.armbrueste.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.boegen.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          (contains(CombatTechnique.dolche.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          (contains(CombatTechnique.fechtwaffen.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          (contains(CombatTechnique.hiebwaffen.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.kettenwaffen.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.lanzen.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.peitschen.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.raufen.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.schilde.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.schleudern.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          (contains(CombatTechnique.schwerter.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.stangenwaffen.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.wurfwaffen.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.zweihandhiebwaffen.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.zweihandschwerter.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.feuerspeien.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.blasrohre.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.diskusse.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          (contains(CombatTechnique.faecher.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.spiesswaffen.id)),
        );
      });
    });
    group('Drachenkampf-Taktik', () {
      test('Combat Technique', () {
        final ability = SpecialAbility(
          SpecialAbilityBase.drachenkampfTaktik,
          null,
        );

        expect(ability.value.type, SpecialAbilityType.passive);
        // check if ability.value.ct is instance of _Explicit
        expect(ability.value.ct, isA<ApplicableCombatTechniques>());
        expect(ability.value.ct.runtimeType.toString(), contains('_All'));
      });
    });
    group('Durchgezogener Tritt', () {
      test('Combat Technique', () {
        final ability = SpecialAbility(
          SpecialAbilityBase.durchgezogenerTritt,
          null,
        );

        expect(ability.value.type, SpecialAbilityType.specialManeuvre);
        // check if ability.value.ct is instance of _Explicit
        expect(ability.value.ct, isA<ApplicableCombatTechniques>());
        expect(ability.value.ct.runtimeType.toString(), contains('_Explicit'));
        expect((ability.value.ct as dynamic).ids, isNotNull);
        expect((ability.value.ct as dynamic).ids, isA<List<String>>());
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.armbrueste.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.boegen.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.dolche.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.fechtwaffen.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.hiebwaffen.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.kettenwaffen.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.lanzen.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.peitschen.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          (contains(CombatTechnique.raufen.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.schilde.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.schleudern.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.schwerter.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.stangenwaffen.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.wurfwaffen.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.zweihandhiebwaffen.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.zweihandschwerter.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.feuerspeien.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.blasrohre.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.diskusse.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.faecher.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.spiesswaffen.id)),
        );
      });
    });
    group('Einhändiger Kampf', () {
      test('Combat Technique', () {
        final ability = SpecialAbility(
          SpecialAbilityBase.einhaendigerKampf,
          null,
        );

        expect(ability.value.type, SpecialAbilityType.passive); // passive
        // check if ability.value.ct is instance of _Explicit
        expect(ability.value.ct, isA<ApplicableCombatTechniques>());
        expect(ability.value.ct.runtimeType.toString(), contains('_Explicit'));
        expect((ability.value.ct as dynamic).ids, isNotNull);
        expect((ability.value.ct as dynamic).ids, isA<List<String>>());
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.armbrueste.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.boegen.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.dolche.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          contains(CombatTechnique.fechtwaffen.id),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.hiebwaffen.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.kettenwaffen.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.lanzen.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.peitschen.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.raufen.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.schilde.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.schleudern.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          contains(CombatTechnique.schwerter.id),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.stangenwaffen.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.wurfwaffen.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.zweihandhiebwaffen.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.zweihandschwerter.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.feuerspeien.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.blasrohre.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.diskusse.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.faecher.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.spiesswaffen.id)),
        );
      });
    });
    group('Eisenhagel', () {
      test('Combat Technique', () {
        final ability = SpecialAbility(SpecialAbilityBase.eisenhagel, null);

        expect(ability.value.type, SpecialAbilityType.specialManeuvre);
        // check if ability.value.ct is instance of _Explicit
        expect(ability.value.ct, isA<ApplicableCombatTechniques>());
        expect(
          ability.value.ct.runtimeType.toString(),
          contains('_ExplicitText'),
        );
      });
    });
    group('Ellbogenangriff', () {
      test('Combat Technique', () {
        final ability = SpecialAbility(
          SpecialAbilityBase.ellbogenangriff,
          null,
        );

        expect(ability.value.type, SpecialAbilityType.specialManeuvre);
        // check if ability.value.ct is instance of _Explicit
        expect(ability.value.ct, isA<ApplicableCombatTechniques>());
        expect(ability.value.ct.runtimeType.toString(), contains('_Explicit'));
        expect((ability.value.ct as dynamic).ids, isNotNull);
        expect((ability.value.ct as dynamic).ids, isA<List<String>>());
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.armbrueste.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.boegen.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.dolche.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.fechtwaffen.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.hiebwaffen.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.kettenwaffen.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.lanzen.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.peitschen.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          (contains(CombatTechnique.raufen.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.schilde.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.schleudern.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.schwerter.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.stangenwaffen.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.wurfwaffen.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.zweihandhiebwaffen.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.zweihandschwerter.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.feuerspeien.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.blasrohre.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.diskusse.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.faecher.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.spiesswaffen.id)),
        );
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
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.armbrueste.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.boegen.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.dolche.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          contains(CombatTechnique.fechtwaffen.id),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          contains(CombatTechnique.hiebwaffen.id),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.kettenwaffen.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.lanzen.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          (contains(CombatTechnique.peitschen.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          contains(CombatTechnique.raufen.id),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.schilde.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.schleudern.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          contains(CombatTechnique.schwerter.id),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          contains(CombatTechnique.stangenwaffen.id),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.wurfwaffen.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          contains(CombatTechnique.zweihandhiebwaffen.id),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          contains(CombatTechnique.zweihandschwerter.id),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.feuerspeien.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.blasrohre.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.diskusse.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.faecher.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.spiesswaffen.id)),
        );
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
    group('Festnageln', () {
      test('Combat Technique', () {
        final ability = SpecialAbility(SpecialAbilityBase.festnageln, null);

        expect(ability.value.type, SpecialAbilityType.specialManeuvre);
        // check if ability.value.ct is instance of _Explicit
        expect(ability.value.ct, isA<ApplicableCombatTechniques>());
        expect(ability.value.ct.runtimeType.toString(), contains('_Explicit'));
        expect((ability.value.ct as dynamic).ids, isNotNull);
        expect((ability.value.ct as dynamic).ids, isA<List<String>>());
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.armbrueste.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.boegen.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.dolche.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.fechtwaffen.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.hiebwaffen.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.kettenwaffen.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.lanzen.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.peitschen.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.raufen.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.schilde.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.schleudern.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.schwerter.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          (contains(CombatTechnique.stangenwaffen.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.wurfwaffen.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.zweihandhiebwaffen.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.zweihandschwerter.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.feuerspeien.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.blasrohre.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.diskusse.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.faecher.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.spiesswaffen.id)),
        );
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
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.armbrueste.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.boegen.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          (contains(CombatTechnique.dolche.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          (contains(CombatTechnique.fechtwaffen.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          (contains(CombatTechnique.hiebwaffen.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.kettenwaffen.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.lanzen.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          (contains(CombatTechnique.peitschen.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          (contains(CombatTechnique.raufen.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.schilde.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.schleudern.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          (contains(CombatTechnique.schwerter.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          (contains(CombatTechnique.stangenwaffen.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.wurfwaffen.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          (contains(CombatTechnique.zweihandhiebwaffen.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          (contains(CombatTechnique.zweihandschwerter.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.feuerspeien.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.blasrohre.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.diskusse.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          (contains(CombatTechnique.faecher.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.spiesswaffen.id)),
        );
      });
    });
    group('Formation', () {
      test('Combat Technique', () {
        final ability = SpecialAbility(SpecialAbilityBase.formation, null);

        expect(ability.value.type, SpecialAbilityType.passive);
        // check if ability.value.ct is instance of _Explicit
        expect(ability.value.ct, isA<ApplicableCombatTechniques>());
        expect(ability.value.ct.runtimeType.toString(), contains('_All'));
      });
    });
    group('Gefechtsformation', () {
      test('Combat Technique', () {
        final ability = SpecialAbility(
          SpecialAbilityBase.gefechtsformation,
          null,
        );

        expect(ability.value.type, SpecialAbilityType.passive);
        // check if ability.value.ct is instance of _Explicit
        expect(ability.value.ct, isA<ApplicableCombatTechniques>());
        expect(ability.value.ct.runtimeType.toString(), contains('_All'));
      });
    });
    group('Gegenhalten', () {
      test('Combat Technique', () {
        final ability = SpecialAbility(SpecialAbilityBase.gegenhalten, null);

        expect(ability.value.type, SpecialAbilityType.specialManeuvre);
        // check if ability.value.ct is instance of _Explicit
        expect(ability.value.ct, isA<ApplicableCombatTechniques>());
        expect(
          ability.value.ct.runtimeType.toString(),
          contains('_MeleeWithParry'),
        );
      });
    });
    group('Geschossabwehr', () {
      test('Combat Technique', () {
        final ability = SpecialAbility(SpecialAbilityBase.geschossabwehr, null);

        expect(ability.value.type, SpecialAbilityType.passive);
        // check if ability.value.ct is instance of _Explicit
        expect(ability.value.ct, isA<ApplicableCombatTechniques>());
        expect(ability.value.ct.runtimeType.toString(), contains('_Explicit'));
        expect((ability.value.ct as dynamic).ids, isNotNull);
        expect((ability.value.ct as dynamic).ids, isA<List<String>>());
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.armbrueste.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.boegen.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.dolche.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.fechtwaffen.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.hiebwaffen.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.kettenwaffen.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.lanzen.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.peitschen.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          (contains(CombatTechnique.raufen.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.schilde.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.schleudern.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.schwerter.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.stangenwaffen.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.wurfwaffen.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.zweihandhiebwaffen.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.zweihandschwerter.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.feuerspeien.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.blasrohre.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.diskusse.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.faecher.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.spiesswaffen.id)),
        );
      });
    });
    group('Gezielter Angriff', () {
      test('Combat Technique', () {
        final ability = SpecialAbility(
          SpecialAbilityBase.gezielterAngriff,
          null,
        );

        expect(ability.value.type, SpecialAbilityType.specialManeuvre);
        // check if ability.value.ct is instance of _Explicit
        expect(ability.value.ct, isA<ApplicableCombatTechniques>());
        expect(ability.value.ct.runtimeType.toString(), contains('_Melee'));
      });
    });
    group('Gezielter Schuss', () {
      test('Combat Technique', () {
        final ability = SpecialAbility(
          SpecialAbilityBase.gezielterSchuss,
          null,
        );

        expect(ability.value.type, SpecialAbilityType.specialManeuvre);
        // check if ability.value.ct is instance of _Explicit
        expect(ability.value.ct, isA<ApplicableCombatTechniques>());
        expect(ability.value.ct.runtimeType.toString(), contains('_Ranged'));
      });
    });
    group('Grätsche', () {
      test('Combat Technique', () {
        final ability = SpecialAbility(SpecialAbilityBase.graetsche, null);

        expect(ability.value.type, SpecialAbilityType.specialManeuvre);
        // check if ability.value.ct is instance of _Explicit
        expect(ability.value.ct, isA<ApplicableCombatTechniques>());
        expect(ability.value.ct.runtimeType.toString(), contains('_Explicit'));
        expect((ability.value.ct as dynamic).ids, isNotNull);
        expect((ability.value.ct as dynamic).ids, isA<List<String>>());
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.armbrueste.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.boegen.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.dolche.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.fechtwaffen.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.hiebwaffen.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.kettenwaffen.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.lanzen.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.peitschen.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          (contains(CombatTechnique.raufen.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.schilde.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.schleudern.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.schwerter.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.stangenwaffen.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.wurfwaffen.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.zweihandhiebwaffen.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.zweihandschwerter.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.feuerspeien.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.blasrohre.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.diskusse.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.faecher.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.spiesswaffen.id)),
        );
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
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.armbrueste.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.boegen.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.dolche.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.fechtwaffen.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.hiebwaffen.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.kettenwaffen.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.lanzen.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.peitschen.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          (contains(CombatTechnique.raufen.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.schilde.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.schleudern.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.schwerter.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.stangenwaffen.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.wurfwaffen.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.zweihandhiebwaffen.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.zweihandschwerter.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.feuerspeien.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.blasrohre.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.diskusse.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.faecher.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.spiesswaffen.id)),
        );
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
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.armbrueste.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.boegen.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.dolche.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.fechtwaffen.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          (contains(CombatTechnique.hiebwaffen.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          (contains(CombatTechnique.kettenwaffen.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.lanzen.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.peitschen.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.raufen.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.schilde.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.schleudern.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          (contains(CombatTechnique.schwerter.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.stangenwaffen.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.wurfwaffen.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          (contains(CombatTechnique.zweihandhiebwaffen.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          (contains(CombatTechnique.zweihandschwerter.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.feuerspeien.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.blasrohre.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.diskusse.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.faecher.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.spiesswaffen.id)),
        );
      });
    });
    group('Herunterstoßen', () {
      test('Combat Technique', () {
        final ability = SpecialAbility(
          SpecialAbilityBase.herunterstossen,
          null,
        );

        expect(ability.value.type, SpecialAbilityType.specialManeuvre);
        // check if ability.value.ct is instance of _Explicit
        expect(ability.value.ct, isA<ApplicableCombatTechniques>());
        expect(ability.value.ct.runtimeType.toString(), contains('_Explicit'));
        expect((ability.value.ct as dynamic).ids, isNotNull);
        expect((ability.value.ct as dynamic).ids, isA<List<String>>());
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.armbrueste.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.boegen.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.dolche.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.fechtwaffen.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.hiebwaffen.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.kettenwaffen.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.lanzen.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.peitschen.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.raufen.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.schilde.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.schleudern.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.schwerter.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          (contains(CombatTechnique.stangenwaffen.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.wurfwaffen.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.zweihandhiebwaffen.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.zweihandschwerter.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.feuerspeien.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.blasrohre.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.diskusse.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.faecher.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.spiesswaffen.id)),
        );
      });
    });
    group('Kampf im Wasser', () {
      test('Combat Technique', () {
        final ability = SpecialAbility(SpecialAbilityBase.kampfImWasser, null);

        expect(ability.value.type, SpecialAbilityType.passive);
        // check if ability.value.ct is instance of _Explicit
        expect(ability.value.ct, isA<ApplicableCombatTechniques>());
        expect(ability.value.ct.runtimeType.toString(), contains('_Melee'));
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
    group('Kampfstil-Kombination', () {
      test('Combat Technique', () {
        final ability = SpecialAbility(
          SpecialAbilityBase.kampfstilKombination,
          null,
        );

        expect(ability.value.type, SpecialAbilityType.passive);
        // check if ability.value.ct is instance of _Explicit
        expect(ability.value.ct, isA<ApplicableCombatTechniques>());
        expect(
          ability.value.ct.runtimeType.toString(),
          contains('_ExplicitText'),
        );
      });
    });
    group('Kernschuss', () {
      test('Combat Technique', () {
        final ability = SpecialAbility(SpecialAbilityBase.kernschuss, null);

        expect(ability.value.type, SpecialAbilityType.passive);
        // check if ability.value.ct is instance of _Explicit
        expect(ability.value.ct, isA<ApplicableCombatTechniques>());
        expect(ability.value.ct.runtimeType.toString(), contains('_Ranged'));
      });
    });
    group('Kha-Formation', () {
      test('Combat Technique', () {
        final ability = SpecialAbility(SpecialAbilityBase.khaFormation, null);

        expect(ability.value.type, SpecialAbilityType.passive);
        // check if ability.value.ct is instance of _Explicit
        expect(ability.value.ct, isA<ApplicableCombatTechniques>());
        expect(ability.value.ct.runtimeType.toString(), contains('_All'));
      });
    });
    group('Klinge drehen', () {
      test('Combat Technique', () {
        final ability = SpecialAbility(SpecialAbilityBase.klingeDrehen, null);

        expect(ability.value.type, SpecialAbilityType.passive);
        // check if ability.value.ct is instance of _Explicit
        expect(ability.value.ct, isA<ApplicableCombatTechniques>());
        expect(
          ability.value.ct.runtimeType.toString(),
          contains('_ExplicitText'),
        );
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
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.armbrueste.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.boegen.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          (contains(CombatTechnique.dolche.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.fechtwaffen.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.hiebwaffen.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.kettenwaffen.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.lanzen.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.peitschen.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.raufen.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.schilde.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.schleudern.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.schwerter.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.stangenwaffen.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.wurfwaffen.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.zweihandhiebwaffen.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.zweihandschwerter.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.feuerspeien.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.blasrohre.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.diskusse.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.faecher.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.spiesswaffen.id)),
        );
      });
    });
    group('Klingensturm', () {
      test('Combat Technique', () {
        final ability = SpecialAbility(SpecialAbilityBase.klingensturm, null);

        expect(ability.value.type, SpecialAbilityType.specialManeuvre);
        // check if ability.value.ct is instance of _Explicit
        expect(ability.value.ct, isA<ApplicableCombatTechniques>());
        expect(ability.value.ct.runtimeType.toString(), contains('_Explicit'));
        expect((ability.value.ct as dynamic).ids, isNotNull);
        expect((ability.value.ct as dynamic).ids, isA<List<String>>());
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.armbrueste.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.boegen.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.dolche.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          (contains(CombatTechnique.fechtwaffen.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.hiebwaffen.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.kettenwaffen.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.lanzen.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.peitschen.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.raufen.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.schilde.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.schleudern.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          (contains(CombatTechnique.schwerter.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.stangenwaffen.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.wurfwaffen.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.zweihandhiebwaffen.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.zweihandschwerter.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.feuerspeien.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.blasrohre.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.diskusse.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.faecher.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.spiesswaffen.id)),
        );
      });
    });
    group('klingentänzer', () {
      test('Combat Technique', () {
        final ability = SpecialAbility(SpecialAbilityBase.klingentaenzer, null);

        expect(ability.value.type, SpecialAbilityType.passive);
        // check if ability.value.ct is instance of _Explicit
        expect(ability.value.ct, isA<ApplicableCombatTechniques>());
        expect(ability.value.ct.runtimeType.toString(), contains('_All'));
      });
    });
    group('Kraftvoller Speerwurf', () {
      test('Combat Technique', () {
        final ability = SpecialAbility(
          SpecialAbilityBase.kraftvollerSpeerwurf,
          null,
        );

        expect(ability.value.type, SpecialAbilityType.specialManeuvre);
        // check if ability.value.ct is instance of _Explicit
        expect(ability.value.ct, isA<ApplicableCombatTechniques>());
        expect(
          ability.value.ct.runtimeType.toString(),
          contains('_ExplicitText'),
        );
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
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.armbrueste.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.boegen.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          (contains(CombatTechnique.dolche.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          (contains(CombatTechnique.fechtwaffen.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.hiebwaffen.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.kettenwaffen.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.lanzen.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.peitschen.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.raufen.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.schilde.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.schleudern.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.schwerter.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.stangenwaffen.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.wurfwaffen.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.zweihandhiebwaffen.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.zweihandschwerter.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.feuerspeien.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.blasrohre.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.diskusse.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.faecher.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.spiesswaffen.id)),
        );
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
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.armbrueste.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.boegen.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.dolche.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.fechtwaffen.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.hiebwaffen.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.kettenwaffen.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          (contains(CombatTechnique.lanzen.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.peitschen.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.raufen.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.schilde.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.schleudern.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.schwerter.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.stangenwaffen.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.wurfwaffen.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.zweihandhiebwaffen.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.zweihandschwerter.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.feuerspeien.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.blasrohre.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.diskusse.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.faecher.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.spiesswaffen.id)),
        );
      });
    });
    group('Lanzenführung', () {
      test('Combat Technique', () {
        final ability = SpecialAbility(SpecialAbilityBase.lanzenfuehrung, null);

        expect(ability.value.type, SpecialAbilityType.passive);
        // check if ability.value.ct is instance of _Explicit
        expect(ability.value.ct, isA<ApplicableCombatTechniques>());
        expect(ability.value.ct.runtimeType.toString(), contains('_Explicit'));
        expect((ability.value.ct as dynamic).ids, isNotNull);
        expect((ability.value.ct as dynamic).ids, isA<List<String>>());
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.armbrueste.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.boegen.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.dolche.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.fechtwaffen.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.hiebwaffen.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.kettenwaffen.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          (contains(CombatTechnique.lanzen.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.peitschen.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.raufen.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.schilde.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.schleudern.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.schwerter.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.stangenwaffen.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.wurfwaffen.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.zweihandhiebwaffen.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.zweihandschwerter.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.feuerspeien.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.blasrohre.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.diskusse.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.faecher.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.spiesswaffen.id)),
        );
      });
    });
    group('Machtvolle Meisterparade', () {
      test('Combat Technique', () {
        final ability = SpecialAbility(
          SpecialAbilityBase.machtvolleMeisterparade,
          null,
        );

        expect(ability.value.type, SpecialAbilityType.passive);
        // check if ability.value.ct is instance of _Explicit
        expect(ability.value.ct, isA<ApplicableCombatTechniques>());
        expect(
          ability.value.ct.runtimeType.toString(),
          contains('_MeleeWithParry'),
        );
      });
    });
    group('Meister der improvisierten Waffen', () {
      test('Combat Technique', () {
        final ability = SpecialAbility(
          SpecialAbilityBase.meisterDerImprovisiertenWaffen,
          null,
        );

        expect(ability.value.type, SpecialAbilityType.passive);
        // check if ability.value.ct is instance of _Explicit
        expect(ability.value.ct, isA<ApplicableCombatTechniques>());
        expect(ability.value.ct.runtimeType.toString(), contains('_All'));
      });
    });
    group('Meisterliche Geschossabwehr', () {
      test('Combat Technique', () {
        final ability = SpecialAbility(
          SpecialAbilityBase.meisterlicheGeschossabwehr,
          null,
        );

        expect(ability.value.type, SpecialAbilityType.passive);
        // check if ability.value.ct is instance of _Explicit
        expect(ability.value.ct, isA<ApplicableCombatTechniques>());
        expect(ability.value.ct.runtimeType.toString(), contains('_Explicit'));
        expect((ability.value.ct as dynamic).ids, isNotNull);
        expect((ability.value.ct as dynamic).ids, isA<List<String>>());
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.armbrueste.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.boegen.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.dolche.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.fechtwaffen.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.hiebwaffen.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.kettenwaffen.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.lanzen.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.peitschen.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          (contains(CombatTechnique.raufen.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.schilde.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.schleudern.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.schwerter.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.stangenwaffen.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.wurfwaffen.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.zweihandhiebwaffen.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.zweihandschwerter.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.feuerspeien.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.blasrohre.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.diskusse.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.faecher.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.spiesswaffen.id)),
        );
      });
    });
    group('Meisterlicher Klingentänzer', () {
      test('Combat Technique', () {
        final ability = SpecialAbility(
          SpecialAbilityBase.meisterlicherKlingentaenzer,
          null,
        );

        expect(ability.value.type, SpecialAbilityType.passive);
        // check if ability.value.ct is instance of _All
        expect(ability.value.ct, isA<ApplicableCombatTechniques>());
        expect(ability.value.ct.runtimeType.toString(), contains('_All'));
      });
    });
    group('Meisterliches Ausweichen', () {
      test('Combat Technique', () {
        final ability = SpecialAbility(
          SpecialAbilityBase.meisterlichesAusweichen,
          null,
        );

        expect(ability.value.type, SpecialAbilityType.passive);
        // check if ability.value.ct is instance of _Explicit
        expect(ability.value.ct, isA<ApplicableCombatTechniques>());
        expect(ability.value.ct.runtimeType.toString(), contains('_All'));
      });
    });
    group('Meisterparade', () {
      test('Combat Technique', () {
        final ability = SpecialAbility(SpecialAbilityBase.meisterparade, null);

        expect(ability.value.type, SpecialAbilityType.passive);
        // check if ability.value.ct is instance of _MeleeWithParry
        expect(ability.value.ct, isA<ApplicableCombatTechniques>());
        expect(
          ability.value.ct.runtimeType.toString(),
          contains('_MeleeWithParry'),
        );
      });
    });
    group('Pikenwall', () {
      test('Combat Technique', () {
        final ability = SpecialAbility(SpecialAbilityBase.pikenwall, null);

        expect(ability.value.type, SpecialAbilityType.passive);
        // check if ability.value.ct is instance of _Explicit
        expect(ability.value.ct, isA<ApplicableCombatTechniques>());
        expect(ability.value.ct.runtimeType.toString(), contains('_Explicit'));
        expect((ability.value.ct as dynamic).ids, isNotNull);
        expect((ability.value.ct as dynamic).ids, isA<List<String>>());
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.armbrueste.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.boegen.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.dolche.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.fechtwaffen.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.hiebwaffen.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.kettenwaffen.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.lanzen.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.peitschen.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.raufen.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.schilde.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.schleudern.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.schwerter.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          (contains(CombatTechnique.stangenwaffen.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.wurfwaffen.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.zweihandhiebwaffen.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.zweihandschwerter.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.feuerspeien.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.blasrohre.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.diskusse.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.faecher.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.spiesswaffen.id)),
        );
      });
    });
    group('Plänkler-Formation', () {
      test('Combat Technique', () {
        final ability = SpecialAbility(
          SpecialAbilityBase.plaenklerFormation,
          null,
        );

        expect(ability.value.type, SpecialAbilityType.passive);
        // check if ability.value.ct is instance of _All
        expect(ability.value.ct, isA<ApplicableCombatTechniques>());
        expect(ability.value.ct.runtimeType.toString(), contains('_All'));
      });
    });
    group('Präziser Schuss/Wurf', () {
      test('Combat Technique', () {
        final ability = SpecialAbility(
          SpecialAbilityBase.praeziserSchussWurf,
          null,
        );

        expect(ability.value.type, SpecialAbilityType.baseManeuvre);
        // check if ability.value.ct is instance of _Explicit
        expect(ability.value.ct, isA<ApplicableCombatTechniques>());
        expect(ability.value.ct.runtimeType.toString(), contains('_Explicit'));
        expect((ability.value.ct as dynamic).ids, isNotNull);
        expect((ability.value.ct as dynamic).ids, isA<List<String>>());
        expect(
          (ability.value.ct as dynamic).ids,
          (contains(CombatTechnique.armbrueste.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          (contains(CombatTechnique.boegen.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.dolche.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.fechtwaffen.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.hiebwaffen.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.kettenwaffen.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.lanzen.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.peitschen.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.raufen.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.schilde.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          (contains(CombatTechnique.schleudern.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.schwerter.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.stangenwaffen.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          (contains(CombatTechnique.wurfwaffen.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.zweihandhiebwaffen.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.zweihandschwerter.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.feuerspeien.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          (contains(CombatTechnique.blasrohre.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          (contains(CombatTechnique.diskusse.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.faecher.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.spiesswaffen.id)),
        );
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
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.armbrueste.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.boegen.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          (contains(CombatTechnique.dolche.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          (contains(CombatTechnique.fechtwaffen.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.hiebwaffen.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.kettenwaffen.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.lanzen.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.peitschen.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.raufen.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.schilde.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.schleudern.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.schwerter.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.stangenwaffen.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.wurfwaffen.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.zweihandhiebwaffen.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.zweihandschwerter.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.feuerspeien.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.blasrohre.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.diskusse.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.faecher.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.spiesswaffen.id)),
        );
      });
    });
    group('Querschuss', () {
      test('Combat Technique', () {
        final ability = SpecialAbility(SpecialAbilityBase.querschuss, null);

        expect(ability.value.type, SpecialAbilityType.passive);
        // check if ability.value.ct is instance of _Explicit
        expect(ability.value.ct, isA<ApplicableCombatTechniques>());
        expect(ability.value.ct.runtimeType.toString(), contains('_Explicit'));
        expect((ability.value.ct as dynamic).ids, isNotNull);
        expect((ability.value.ct as dynamic).ids, isA<List<String>>());
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.armbrueste.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          (contains(CombatTechnique.boegen.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.dolche.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.fechtwaffen.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.hiebwaffen.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.kettenwaffen.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.lanzen.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.peitschen.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.raufen.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.schilde.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.schleudern.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.schwerter.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.stangenwaffen.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.wurfwaffen.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.zweihandhiebwaffen.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.zweihandschwerter.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.feuerspeien.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.blasrohre.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.diskusse.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.faecher.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.spiesswaffen.id)),
        );
      });
    });
    group('Reissangriff', () {
      test('Combat Technique', () {
        final ability = SpecialAbility(SpecialAbilityBase.reissangriff, null);

        expect(ability.value.type, SpecialAbilityType.passive);
        // check if ability.value.ct is instance of _Explicit
        expect(ability.value.ct, isA<ApplicableCombatTechniques>());
        expect(ability.value.ct.runtimeType.toString(), contains('_Explicit'));
        expect((ability.value.ct as dynamic).ids, isNotNull);
        expect((ability.value.ct as dynamic).ids, isA<List<String>>());
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.armbrueste.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.boegen.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.dolche.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.fechtwaffen.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.hiebwaffen.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          (contains(CombatTechnique.kettenwaffen.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.lanzen.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.peitschen.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.raufen.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.schilde.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.schleudern.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.schwerter.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.stangenwaffen.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.wurfwaffen.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.zweihandhiebwaffen.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.zweihandschwerter.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.feuerspeien.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.blasrohre.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.diskusse.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.faecher.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.spiesswaffen.id)),
        );
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
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.armbrueste.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.boegen.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          (contains(CombatTechnique.dolche.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          (contains(CombatTechnique.fechtwaffen.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.hiebwaffen.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.kettenwaffen.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.lanzen.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.peitschen.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.raufen.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.schilde.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.schleudern.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.schwerter.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.stangenwaffen.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.wurfwaffen.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.zweihandhiebwaffen.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.zweihandschwerter.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.feuerspeien.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.blasrohre.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.diskusse.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.faecher.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.spiesswaffen.id)),
        );
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
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.armbrueste.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.boegen.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.dolche.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.fechtwaffen.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          (contains(CombatTechnique.hiebwaffen.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          (contains(CombatTechnique.kettenwaffen.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.lanzen.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.peitschen.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.raufen.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          (contains(CombatTechnique.schilde.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.schleudern.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          (contains(CombatTechnique.schwerter.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          (contains(CombatTechnique.stangenwaffen.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.wurfwaffen.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          (contains(CombatTechnique.zweihandhiebwaffen.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          (contains(CombatTechnique.zweihandschwerter.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.feuerspeien.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.blasrohre.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.diskusse.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.faecher.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.spiesswaffen.id)),
        );
      });
    });
    group('Scharfschütze', () {
      test('Combat Technique', () {
        final ability = SpecialAbility(SpecialAbilityBase.scharfschuetze, null);

        expect(ability.value.type, SpecialAbilityType.passive);
        // check if ability.value.ct is instance of _Explicit
        expect(ability.value.ct, isA<ApplicableCombatTechniques>());
        expect(ability.value.ct.runtimeType.toString(), contains('_Explicit'));
        expect((ability.value.ct as dynamic).ids, isNotNull);
        expect((ability.value.ct as dynamic).ids, isA<List<String>>());
        expect(
          (ability.value.ct as dynamic).ids,
          (contains(CombatTechnique.armbrueste.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          (contains(CombatTechnique.boegen.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.dolche.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.fechtwaffen.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.hiebwaffen.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.kettenwaffen.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.lanzen.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.peitschen.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.raufen.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.schilde.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          (contains(CombatTechnique.schleudern.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.schwerter.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.stangenwaffen.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          (contains(CombatTechnique.wurfwaffen.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.zweihandhiebwaffen.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.zweihandschwerter.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.feuerspeien.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          (contains(CombatTechnique.blasrohre.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          (contains(CombatTechnique.diskusse.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.faecher.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.spiesswaffen.id)),
        );
      });
    });
    group('Schildschlag', () {
      test('Combat Technique', () {
        final ability = SpecialAbility(SpecialAbilityBase.schildschlag, null);

        expect(ability.value.type, SpecialAbilityType.specialManeuvre);
        // check if ability.value.ct is instance of _Explicit
        expect(ability.value.ct, isA<ApplicableCombatTechniques>());
        expect(ability.value.ct.runtimeType.toString(), contains('_Explicit'));
        expect((ability.value.ct as dynamic).ids, isNotNull);
        expect((ability.value.ct as dynamic).ids, isA<List<String>>());
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.armbrueste.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.boegen.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.dolche.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.fechtwaffen.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.hiebwaffen.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.kettenwaffen.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.lanzen.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.peitschen.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.raufen.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          (contains(CombatTechnique.schilde.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.schleudern.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.schwerter.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.stangenwaffen.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.wurfwaffen.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.zweihandhiebwaffen.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.zweihandschwerter.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.feuerspeien.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.blasrohre.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.diskusse.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.faecher.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.spiesswaffen.id)),
        );
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
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.armbrueste.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.boegen.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.dolche.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.fechtwaffen.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          (contains(CombatTechnique.hiebwaffen.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          (contains(CombatTechnique.kettenwaffen.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.lanzen.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.peitschen.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.raufen.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.schilde.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.schleudern.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.schwerter.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.stangenwaffen.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.wurfwaffen.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          (contains(CombatTechnique.zweihandhiebwaffen.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          (contains(CombatTechnique.zweihandschwerter.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.feuerspeien.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.blasrohre.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.diskusse.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.faecher.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.spiesswaffen.id)),
        );
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
        expect(
          (ability.value.ct as dynamic).ids,
          (contains(CombatTechnique.armbrueste.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          (contains(CombatTechnique.boegen.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.dolche.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.fechtwaffen.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.hiebwaffen.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.kettenwaffen.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.lanzen.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.peitschen.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.raufen.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.schilde.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          (contains(CombatTechnique.schleudern.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.schwerter.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.stangenwaffen.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          (contains(CombatTechnique.wurfwaffen.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.zweihandhiebwaffen.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.zweihandschwerter.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.feuerspeien.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          (contains(CombatTechnique.blasrohre.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          (contains(CombatTechnique.diskusse.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.faecher.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.spiesswaffen.id)),
        );
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
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.armbrueste.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.boegen.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          (contains(CombatTechnique.dolche.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          (contains(CombatTechnique.fechtwaffen.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          (contains(CombatTechnique.hiebwaffen.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          (contains(CombatTechnique.kettenwaffen.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.lanzen.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          (contains(CombatTechnique.peitschen.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.raufen.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.schilde.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.schleudern.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          (contains(CombatTechnique.schwerter.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          (contains(CombatTechnique.stangenwaffen.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.wurfwaffen.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          (contains(CombatTechnique.zweihandhiebwaffen.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          (contains(CombatTechnique.zweihandschwerter.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.feuerspeien.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.blasrohre.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.diskusse.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          (contains(CombatTechnique.faecher.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.spiesswaffen.id)),
        );
      });
    });
    group('Schwitzkasten', () {
      test('Combat Technique', () {
        final ability = SpecialAbility(SpecialAbilityBase.schwitzkasten, null);

        expect(ability.value.type, SpecialAbilityType.specialManeuvre);
        // check if ability.value.ct is instance of _Explicit
        expect(ability.value.ct, isA<ApplicableCombatTechniques>());
        expect(ability.value.ct.runtimeType.toString(), contains('_Explicit'));
        expect((ability.value.ct as dynamic).ids, isNotNull);
        expect((ability.value.ct as dynamic).ids, isA<List<String>>());
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.armbrueste.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.boegen.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.dolche.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.fechtwaffen.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.hiebwaffen.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.kettenwaffen.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.lanzen.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.peitschen.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          (contains(CombatTechnique.raufen.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.schilde.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.schleudern.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.schwerter.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.stangenwaffen.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.wurfwaffen.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.zweihandhiebwaffen.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.zweihandschwerter.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.feuerspeien.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.blasrohre.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.diskusse.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.faecher.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.spiesswaffen.id)),
        );
      });
    });
    group('Spießgespann', () {
      test('Combat Technique', () {
        final ability = SpecialAbility(SpecialAbilityBase.spiessgespann, null);

        expect(ability.value.type, SpecialAbilityType.passive);
        // check if ability.value.ct is instance of _Explicit
        expect(ability.value.ct, isA<ApplicableCombatTechniques>());
        expect(ability.value.ct.runtimeType.toString(), contains('_Explicit'));
        expect((ability.value.ct as dynamic).ids, isNotNull);
        expect((ability.value.ct as dynamic).ids, isA<List<String>>());
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.armbrueste.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.boegen.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.dolche.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.fechtwaffen.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.hiebwaffen.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.kettenwaffen.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.lanzen.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.peitschen.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.raufen.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.schilde.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.schleudern.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.schwerter.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.stangenwaffen.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.wurfwaffen.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.zweihandhiebwaffen.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.zweihandschwerter.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.feuerspeien.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.blasrohre.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.diskusse.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.faecher.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          (contains(CombatTechnique.spiesswaffen.id)),
        );
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
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.armbrueste.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.boegen.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.dolche.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.fechtwaffen.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          (contains(CombatTechnique.hiebwaffen.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.kettenwaffen.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.lanzen.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.peitschen.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.raufen.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.schilde.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.schleudern.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          (contains(CombatTechnique.schwerter.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          (contains(CombatTechnique.stangenwaffen.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.wurfwaffen.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          (contains(CombatTechnique.zweihandhiebwaffen.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          (contains(CombatTechnique.zweihandschwerter.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.feuerspeien.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.blasrohre.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.diskusse.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.faecher.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.spiesswaffen.id)),
        );
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
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.armbrueste.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.boegen.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          (contains(CombatTechnique.dolche.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          (contains(CombatTechnique.fechtwaffen.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.hiebwaffen.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.kettenwaffen.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.lanzen.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.peitschen.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.raufen.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.schilde.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.schleudern.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.schwerter.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.stangenwaffen.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.wurfwaffen.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.zweihandhiebwaffen.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.zweihandschwerter.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.feuerspeien.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.blasrohre.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.diskusse.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.faecher.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.spiesswaffen.id)),
        );
      });
    });
    group('Turnierreiterei', () {
      test('Combat Technique', () {
        final ability = SpecialAbility(
          SpecialAbilityBase.turnierreiterei,
          null,
        );

        expect(ability.value.type, SpecialAbilityType.passive);
        // check if ability.value.ct is instance of _Explicit
        expect(ability.value.ct, isA<ApplicableCombatTechniques>());
        expect(ability.value.ct.runtimeType.toString(), contains('_Explicit'));
        expect((ability.value.ct as dynamic).ids, isNotNull);
        expect((ability.value.ct as dynamic).ids, isA<List<String>>());
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.armbrueste.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.boegen.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.dolche.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.fechtwaffen.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.hiebwaffen.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.kettenwaffen.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          (contains(CombatTechnique.lanzen.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.peitschen.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.raufen.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.schilde.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.schleudern.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.schwerter.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.stangenwaffen.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.wurfwaffen.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.zweihandhiebwaffen.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.zweihandschwerter.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.feuerspeien.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.blasrohre.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.diskusse.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.faecher.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.spiesswaffen.id)),
        );
      });
    });
    group('Umrennen', () {
      test('Combat Technique', () {
        final ability = SpecialAbility(SpecialAbilityBase.umrennen, null);

        expect(ability.value.type, SpecialAbilityType.specialManeuvre);
        // check if ability.value.ct is instance of _Explicit
        expect(ability.value.ct, isA<ApplicableCombatTechniques>());
        expect(ability.value.ct.runtimeType.toString(), contains('_Explicit'));
        expect((ability.value.ct as dynamic).ids, isNotNull);
        expect((ability.value.ct as dynamic).ids, isA<List<String>>());
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.armbrueste.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.boegen.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.dolche.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.fechtwaffen.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.hiebwaffen.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.kettenwaffen.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.lanzen.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.peitschen.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          (contains(CombatTechnique.raufen.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.schilde.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.schleudern.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.schwerter.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.stangenwaffen.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.wurfwaffen.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.zweihandhiebwaffen.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.zweihandschwerter.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.feuerspeien.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.blasrohre.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.diskusse.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.faecher.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.spiesswaffen.id)),
        );
      });
    });
    group('Umwickeln', () {
      test('Combat Technique', () {
        final ability = SpecialAbility(SpecialAbilityBase.umwickeln, null);

        expect(ability.value.type, SpecialAbilityType.specialManeuvre);
        // check if ability.value.ct is instance of _Explicit
        expect(ability.value.ct, isA<ApplicableCombatTechniques>());
        expect(ability.value.ct.runtimeType.toString(), contains('_Explicit'));
        expect((ability.value.ct as dynamic).ids, isNotNull);
        expect((ability.value.ct as dynamic).ids, isA<List<String>>());
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.armbrueste.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.boegen.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.dolche.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.fechtwaffen.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.hiebwaffen.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          (contains(CombatTechnique.kettenwaffen.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.lanzen.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          (contains(CombatTechnique.peitschen.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.raufen.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.schilde.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.schleudern.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.schwerter.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.stangenwaffen.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.wurfwaffen.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.zweihandhiebwaffen.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.zweihandschwerter.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.feuerspeien.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.blasrohre.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.diskusse.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.faecher.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.spiesswaffen.id)),
        );
      });
    });
    group('Ungeheuer-Taktik', () {
      test('Combat Technique', () {
        final ability = SpecialAbility(
          SpecialAbilityBase.ungeheuerTaktik,
          null,
        );

        expect(ability.value.type, SpecialAbilityType.passive);
        // check if ability.value.ct is instance of _All
        expect(ability.value.ct, isA<ApplicableCombatTechniques>());
        expect(ability.value.ct.runtimeType.toString(), contains('_All'));
      });
    });
    group('Unterlaufen', () {
      test('Combat Technique', () {
        final ability = SpecialAbility(SpecialAbilityBase.unterlaufen, null);

        expect(ability.value.type, SpecialAbilityType.baseManeuvre);
        // check if ability.value.ct is instance of _Explicit
        expect(ability.value.ct, isA<ApplicableCombatTechniques>());
        expect(ability.value.ct.runtimeType.toString(), contains('_Explicit'));
        expect((ability.value.ct as dynamic).ids, isNotNull);
        expect((ability.value.ct as dynamic).ids, isA<List<String>>());
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.armbrueste.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.boegen.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          (contains(CombatTechnique.dolche.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          (contains(CombatTechnique.fechtwaffen.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          (contains(CombatTechnique.hiebwaffen.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          (contains(CombatTechnique.kettenwaffen.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.lanzen.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.peitschen.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          (contains(CombatTechnique.raufen.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          (contains(CombatTechnique.schilde.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.schleudern.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          (contains(CombatTechnique.schwerter.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.stangenwaffen.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.wurfwaffen.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          (contains(CombatTechnique.zweihandhiebwaffen.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          (contains(CombatTechnique.zweihandschwerter.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.feuerspeien.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.blasrohre.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.diskusse.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.faecher.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.spiesswaffen.id)),
        );
      });
    });
    group('Unterwasserkampf', () {
      test('Combat Technique', () {
        final ability = SpecialAbility(
          SpecialAbilityBase.unterwasserkampf,
          null,
        );

        expect(ability.value.type, SpecialAbilityType.passive);
        // check if ability.value.ct is instance of _All
        expect(ability.value.ct, isA<ApplicableCombatTechniques>());
        expect(ability.value.ct.runtimeType.toString(), contains('_All'));
      });
    });
    group('Verbessertes Ausweichen', () {
      test('Combat Technique', () {
        final ability = SpecialAbility(
          SpecialAbilityBase.verbessertesAusweichen,
          null,
        );

        expect(ability.value.type, SpecialAbilityType.passive);
        // check if ability.value.ct is instance of _Explicit
        expect(ability.value.ct, isA<ApplicableCombatTechniques>());
        expect(ability.value.ct.runtimeType.toString(), contains('_All'));
      });
    });
    group('Verbessertes Unterlaufen', () {
      test('Combat Technique', () {
        final ability = SpecialAbility(
          SpecialAbilityBase.verbessertesUnterlaufen,
          null,
        );

        expect(ability.value.type, SpecialAbilityType.passive);
        // check if ability.value.ct is instance of _Explicit
        expect(ability.value.ct, isA<ApplicableCombatTechniques>());
        expect(ability.value.ct.runtimeType.toString(), contains('_Explicit'));
        expect((ability.value.ct as dynamic).ids, isNotNull);
        expect((ability.value.ct as dynamic).ids, isA<List<String>>());
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.armbrueste.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.boegen.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          (contains(CombatTechnique.dolche.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          (contains(CombatTechnique.fechtwaffen.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          (contains(CombatTechnique.hiebwaffen.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          (contains(CombatTechnique.kettenwaffen.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.lanzen.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.peitschen.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          (contains(CombatTechnique.raufen.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          (contains(CombatTechnique.schilde.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.schleudern.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          (contains(CombatTechnique.schwerter.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.stangenwaffen.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.wurfwaffen.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          (contains(CombatTechnique.zweihandhiebwaffen.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          (contains(CombatTechnique.zweihandschwerter.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.feuerspeien.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.blasrohre.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.diskusse.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.faecher.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.spiesswaffen.id)),
        );
      });
    });
    group('Verteidigungshaltung', () {
      test('Combat Technique', () {
        final ability = SpecialAbility(
          SpecialAbilityBase.verteidigungshaltung,
          null,
        );

        expect(ability.value.type, SpecialAbilityType.passive);
        // check if ability.value.ct is instance of _Explicit
        expect(ability.value.ct, isA<ApplicableCombatTechniques>());
        expect(ability.value.ct.runtimeType.toString(), contains('_Explicit'));
        expect((ability.value.ct as dynamic).ids, isNotNull);
        expect((ability.value.ct as dynamic).ids, isA<List<String>>());
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.armbrueste.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.boegen.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          (contains(CombatTechnique.dolche.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          (contains(CombatTechnique.fechtwaffen.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          (contains(CombatTechnique.hiebwaffen.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.kettenwaffen.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.lanzen.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.peitschen.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          (contains(CombatTechnique.raufen.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          (contains(CombatTechnique.schilde.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.schleudern.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          (contains(CombatTechnique.schwerter.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          (contains(CombatTechnique.stangenwaffen.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.wurfwaffen.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          (contains(CombatTechnique.zweihandhiebwaffen.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          (contains(CombatTechnique.zweihandschwerter.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.feuerspeien.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.blasrohre.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.diskusse.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.faecher.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.spiesswaffen.id)),
        );
      });
    });
    group('Verteilter Eisenhagel', () {
      test('Combat Technique', () {
        final ability = SpecialAbility(
          SpecialAbilityBase.verteilterEisenhagel,
          null,
        );

        expect(ability.value.type, SpecialAbilityType.passive);
        // check if ability.value.ct is instance of _Explicit
        expect(ability.value.ct, isA<ApplicableCombatTechniques>());
        expect(ability.value.ct.runtimeType.toString(), contains('_Explicit'));
        expect((ability.value.ct as dynamic).ids, isNotNull);
        expect((ability.value.ct as dynamic).ids, isA<List<String>>());
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.armbrueste.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.boegen.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.dolche.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.fechtwaffen.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.hiebwaffen.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.kettenwaffen.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.lanzen.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.peitschen.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.raufen.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.schilde.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.schleudern.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.schwerter.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.stangenwaffen.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          (contains(CombatTechnique.wurfwaffen.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.zweihandhiebwaffen.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.zweihandschwerter.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.feuerspeien.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.blasrohre.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          (contains(CombatTechnique.diskusse.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.faecher.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.spiesswaffen.id)),
        );
      });
    });
    group('Vorstoß', () {
      test('Combat Technique', () {
        final ability = SpecialAbility(SpecialAbilityBase.vorstoss, null);

        expect(ability.value.type, SpecialAbilityType.specialManeuvre);
        // check if ability.value.ct is instance of _Explicit
        expect(ability.value.ct, isA<ApplicableCombatTechniques>());
        expect(ability.value.ct.runtimeType.toString(), contains('_Explicit'));
        expect((ability.value.ct as dynamic).ids, isNotNull);
        expect((ability.value.ct as dynamic).ids, isA<List<String>>());
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.armbrueste.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.boegen.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          (contains(CombatTechnique.dolche.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          (contains(CombatTechnique.fechtwaffen.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          (contains(CombatTechnique.hiebwaffen.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          (contains(CombatTechnique.kettenwaffen.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.lanzen.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.peitschen.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          (contains(CombatTechnique.raufen.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.schilde.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.schleudern.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          (contains(CombatTechnique.schwerter.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          (contains(CombatTechnique.stangenwaffen.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.wurfwaffen.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          (contains(CombatTechnique.zweihandhiebwaffen.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          (contains(CombatTechnique.zweihandschwerter.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.feuerspeien.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.blasrohre.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.diskusse.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          (contains(CombatTechnique.faecher.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.spiesswaffen.id)),
        );
      });
    });
    group('Weitwurf', () {
      test('Combat Technique', () {
        final ability = SpecialAbility(SpecialAbilityBase.weitwurf, null);

        expect(ability.value.type, SpecialAbilityType.specialManeuvre);
        // check if ability.value.ct is instance of _Explicit
        expect(ability.value.ct, isA<ApplicableCombatTechniques>());
        expect(ability.value.ct.runtimeType.toString(), contains('_Explicit'));
        expect((ability.value.ct as dynamic).ids, isNotNull);
        expect((ability.value.ct as dynamic).ids, isA<List<String>>());
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.armbrueste.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.boegen.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.dolche.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.fechtwaffen.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.hiebwaffen.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.kettenwaffen.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.lanzen.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.peitschen.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.raufen.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.schilde.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.schleudern.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.schwerter.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.stangenwaffen.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          (contains(CombatTechnique.wurfwaffen.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.zweihandhiebwaffen.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.zweihandschwerter.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.feuerspeien.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.blasrohre.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.diskusse.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.faecher.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.spiesswaffen.id)),
        );
      });
    });
    group('Wirbelangriff', () {
      test('Combat Technique', () {
        final ability = SpecialAbility(SpecialAbilityBase.wirbelangriff, null);

        expect(ability.value.type, SpecialAbilityType.specialManeuvre);
        // check if ability.value.ct is instance of _Explicit
        expect(ability.value.ct, isA<ApplicableCombatTechniques>());
        expect(ability.value.ct.runtimeType.toString(), contains('_Explicit'));
        expect((ability.value.ct as dynamic).ids, isNotNull);
        expect((ability.value.ct as dynamic).ids, isA<List<String>>());
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.armbrueste.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.boegen.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          (contains(CombatTechnique.dolche.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          (contains(CombatTechnique.fechtwaffen.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.hiebwaffen.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.kettenwaffen.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.lanzen.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.peitschen.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          (contains(CombatTechnique.raufen.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.schilde.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.schleudern.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.schwerter.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.stangenwaffen.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.wurfwaffen.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.zweihandhiebwaffen.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.zweihandschwerter.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.feuerspeien.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.blasrohre.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.diskusse.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          (contains(CombatTechnique.faecher.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.spiesswaffen.id)),
        );
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
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.armbrueste.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.boegen.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.dolche.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.fechtwaffen.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          (contains(CombatTechnique.hiebwaffen.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          (contains(CombatTechnique.kettenwaffen.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.lanzen.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.peitschen.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          (contains(CombatTechnique.raufen.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.schilde.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.schleudern.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          (contains(CombatTechnique.schwerter.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          (contains(CombatTechnique.stangenwaffen.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.wurfwaffen.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          (contains(CombatTechnique.zweihandhiebwaffen.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          (contains(CombatTechnique.zweihandschwerter.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.feuerspeien.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.blasrohre.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.diskusse.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.faecher.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.spiesswaffen.id)),
        );
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
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.armbrueste.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.boegen.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.dolche.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.fechtwaffen.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.hiebwaffen.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.kettenwaffen.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.lanzen.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.peitschen.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          (contains(CombatTechnique.raufen.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.schilde.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.schleudern.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.schwerter.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.stangenwaffen.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.wurfwaffen.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.zweihandhiebwaffen.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.zweihandschwerter.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.feuerspeien.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.blasrohre.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.diskusse.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.faecher.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.spiesswaffen.id)),
        );
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
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.armbrueste.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.boegen.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.dolche.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.fechtwaffen.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.hiebwaffen.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.kettenwaffen.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.lanzen.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          (contains(CombatTechnique.peitschen.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.raufen.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.schilde.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.schleudern.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.schwerter.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          (contains(CombatTechnique.stangenwaffen.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.wurfwaffen.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.zweihandhiebwaffen.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.zweihandschwerter.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.feuerspeien.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.blasrohre.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.diskusse.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.faecher.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.spiesswaffen.id)),
        );
      });
    });
    group('Zweihändiger Reiterkampf', () {
      test('Combat Technique', () {
        final ability = SpecialAbility(
          SpecialAbilityBase.zweihaendigerReiterkampf,
          null,
        );

        expect(ability.value.type, SpecialAbilityType.passive);
        // check if ability.value.ct is instance of _Explicit
        expect(ability.value.ct, isA<ApplicableCombatTechniques>());
        expect(ability.value.ct.runtimeType.toString(), contains('_Explicit'));
        expect((ability.value.ct as dynamic).ids, isNotNull);
        expect((ability.value.ct as dynamic).ids, isA<List<String>>());
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.armbrueste.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.boegen.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.dolche.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.fechtwaffen.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.hiebwaffen.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.kettenwaffen.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.lanzen.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.peitschen.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.raufen.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.schilde.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.schleudern.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.schwerter.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.stangenwaffen.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.wurfwaffen.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          (contains(CombatTechnique.zweihandhiebwaffen.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          (contains(CombatTechnique.zweihandschwerter.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.feuerspeien.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.blasrohre.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.diskusse.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.faecher.id)),
        );
        expect(
          (ability.value.ct as dynamic).ids,
          isNot(contains(CombatTechnique.spiesswaffen.id)),
        );
      });
    });

    test('Wuchtschlag impact returns correct atMod and tpMod', () {
      final ability = SpecialAbility(SpecialAbilityBase.wuchtschlag, 2);
      final impact = SpecialAbilityImpact.derive(ability, null, null, 0);
      expect(impact.atMod, equals(-4)); // -2 * tier
      expect(impact.tpMod, equals(4)); // 2 * tier
    });

    test('Finte impact returns correct atMod', () {
      final ability = SpecialAbility(SpecialAbilityBase.finte, 3);
      final impact = SpecialAbilityImpact.derive(ability, null, null, 0);
      expect(impact.atMod, equals(-3));
    });

    test('Riposte impact returns correct paMod', () {
      final ability = SpecialAbility(SpecialAbilityBase.riposte, null);
      final impact = SpecialAbilityImpact.derive(ability, null, null, 0);
      expect(impact.paMod, equals(-2));
    });

    test(
      'SpecialAbilityImpact.none impact returns all mods zero except modifier',
      () {
        final impact = SpecialAbilityImpact.none(5);
        expect(impact.atMod, equals(0));
        expect(impact.paMod, equals(0));
        expect(impact.awMod, equals(0));
        expect(impact.tpMod, equals(0));
        expect(impact.modifier, equals(5));
      },
    );

    test(
      "BaseManeuvre and SpecialManeuvre don't clobber each others' values",
      () {
        final dd = durchschnittsdoedel();
        final wuchtschlag = SpecialAbility(SpecialAbilityBase.wuchtschlag, 1);
        final vorstoss = SpecialAbility(SpecialAbilityBase.vorstoss, null);
        final engine = CombatRoll.fromTechnique(
          dd,
          CombatTechnique.schwerter,
          wuchtschlag,
          vorstoss,
          3,
        );
        final result = engine.roll(
          CombatActionType.attack,
          random: Deterministic([5]),
        );
        expect(result[0].event, equals(RollEvent.success));
        expect(result[0].targetValue.value, equals(6));
        final auditTrail = ExplainedValue.base(7, "AT Schwerter")
            .add(-2, "Wuchtschlag I")
            .add(2, "Vorstoß")
            .add(-4, "Verwirrung Stufe IV")
            .add(3, "Modifikator");
        expect(
          result[0].targetValue.explanation,
          equals(auditTrail.explanation),
        );
        final tp = damageRoll(
          genericWeapons[CombatTechnique.schwerter]!,
          dd,
          wuchtschlag,
          vorstoss,
          random: Deterministic([5]),
        );
        expect(tp.combinedResult.value, equals(9));
        final damageTrail = ExplainedValue.base(
          5,
          "Kurzschwert Würfel",
        ).add(2, "Kurzschwert Basis").add(2, "Wuchtschlag I");
        expect(tp.combinedResult.explanation, equals(damageTrail.explanation));
        final hammerschlag = SpecialAbility(
          SpecialAbilityBase.hammerschlag,
          null,
        );
        final tp2 = damageRoll(
          genericWeapons[CombatTechnique.schwerter]!,
          dd,
          null,
          hammerschlag,
          random: Deterministic([5, 6]),
        );
        expect(tp2.combinedResult.value, equals(13));
        final damageTrail2 = ExplainedValue.base(5, "Kurzschwert Würfel")
            .add(2, "Kurzschwert Basis")
            .add(6, "Hammerschlag Würfel");
        expect(
          tp2.combinedResult.explanation,
          equals(damageTrail2.explanation),
        );
      },
    );
  });
}
