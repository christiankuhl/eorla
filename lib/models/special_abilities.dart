import 'generated/_special_abilities.dart';
export 'generated/_special_abilities.dart';
import '../widgets/widget_helpers.dart';

const specialCombatAbilities = {
  "SA_41": SpecialAbilityBase.belastungsgewoehnung,
  "SA_42": SpecialAbilityBase.beidhaendigerKampf,
  "SA_43": SpecialAbilityBase.berittenerKampf,
  "SA_44": SpecialAbilityBase.berittenerSchuetze,
  "SA_45": SpecialAbilityBase.einhaendigerKampf,
  "SA_46": SpecialAbilityBase.entwaffnen,
  "SA_47": SpecialAbilityBase.feindgespuer,
  "SA_48": SpecialAbilityBase.finte,
  "SA_49": SpecialAbilityBase.haltegriff,
  "SA_50": SpecialAbilityBase.hammerschlag,
  "SA_51": SpecialAbilityBase.kampfreflexe,
  "SA_52": SpecialAbilityBase.klingenfaenger,
  "SA_53": SpecialAbilityBase.kreuzblock,
  "SA_54": SpecialAbilityBase.lanzenangriff,
  "SA_55": SpecialAbilityBase.praeziserSchussWurf,
  "SA_56": SpecialAbilityBase.praeziserStich,
  "SA_57": SpecialAbilityBase.riposte,
  "SA_58": SpecialAbilityBase.rundumschlag,
  "SA_59": SpecialAbilityBase.schildspalter,
  "SA_60": SpecialAbilityBase.schnellladen,
  "SA_61": SpecialAbilityBase.schnellziehen,
  "SA_62": SpecialAbilityBase.sturmangriff,
  "SA_63": SpecialAbilityBase.todesstoss,
  "SA_64": SpecialAbilityBase.verbessertesAusweichen,
  "SA_65": SpecialAbilityBase.verteidigungshaltung,
  "SA_66": SpecialAbilityBase.vorstoss,
  "SA_67": SpecialAbilityBase.wuchtschlag,
  "SA_68": SpecialAbilityBase.wurf,
  "SA_69": SpecialAbilityBase.zuFallBringen,
  "SA_151": SpecialAbilityBase.armbrustUeberdrehen,
  "SA_152": SpecialAbilityBase.aufDistanzHalten,
  "SA_153": SpecialAbilityBase.ballistischerSchuss,
  "SA_154": SpecialAbilityBase.berittenerFlugkampf,
  "SA_155": SpecialAbilityBase.beschuetzer,
  "SA_156": SpecialAbilityBase.betaeubungsschlag,
  "SA_157": SpecialAbilityBase.blindkampf,
  "SA_158": SpecialAbilityBase.eisenhagel,
  "SA_159": SpecialAbilityBase.festnageln,
  "SA_160": SpecialAbilityBase.gezielterAngriff,
  "SA_161": SpecialAbilityBase.gezielterSchuss,
  "SA_162": SpecialAbilityBase.herunterstossen,
  "SA_163": SpecialAbilityBase.kampfImWasser,
  "SA_164": SpecialAbilityBase.kampfstilKombination,
  "SA_165": SpecialAbilityBase.klingensturm,
  "SA_166": SpecialAbilityBase.meisterDerImprovisiertenWaffen,
  "SA_167": SpecialAbilityBase.meisterlichesAusweichen,
  "SA_168": SpecialAbilityBase.meisterparade,
  "SA_169": SpecialAbilityBase.pikenwall,
  "SA_170": SpecialAbilityBase.scharfschuetze,
  "SA_171": SpecialAbilityBase.schwitzkasten,
  "SA_172": SpecialAbilityBase.unterlaufen,
  "SA_173": SpecialAbilityBase.verbessertesUnterlaufen,
  "SA_174": SpecialAbilityBase.verteilterEisenhagel,
  "SA_175": SpecialAbilityBase.zweihaendigerReiterkampf,
  "SA_418": SpecialAbilityBase.unterwasserkampf,
  "SA_860": SpecialAbilityBase.auflaufen,
  "SA_861": SpecialAbilityBase.spiessgespann,
  "SA_862": SpecialAbilityBase.formation,
  "SA_864": SpecialAbilityBase.ausfall,
  "SA_865": SpecialAbilityBase.beritteneLanzenformation,
  "SA_866": SpecialAbilityBase.blutgraetsche,
  "SA_867": SpecialAbilityBase.doppelangriff,
  "SA_868": SpecialAbilityBase.drachenkampfTaktik,
  "SA_869": SpecialAbilityBase.durchgezogenerTritt,
  "SA_870": SpecialAbilityBase.ellbogenangriff,
  "SA_871": SpecialAbilityBase.gefechtsformation,
  "SA_872": SpecialAbilityBase.gegenhalten,
  "SA_873": SpecialAbilityBase.geschossabwehr,
  "SA_874": SpecialAbilityBase.graetsche,
  "SA_875": SpecialAbilityBase.kernschuss,
  "SA_876": SpecialAbilityBase.khaFormation,
  "SA_877": SpecialAbilityBase.klingeDrehen,
  "SA_878": SpecialAbilityBase.klingentaenzer,
  "SA_879": SpecialAbilityBase.kraftvollerSpeerwurf,
  "SA_880": SpecialAbilityBase.lanzenfuehrung,
  "SA_881": SpecialAbilityBase.machtvolleMeisterparade,
  "SA_882": SpecialAbilityBase.meisterlicheGeschossabwehr,
  "SA_883": SpecialAbilityBase.meisterlicherKlingentaenzer,
  "SA_884": SpecialAbilityBase.plaenklerFormation,
  "SA_885": SpecialAbilityBase.querschuss,
  "SA_886": SpecialAbilityBase.reissangriff,
  "SA_887": SpecialAbilityBase.schildschlag,
  "SA_888": SpecialAbilityBase.turnierreiterei,
  "SA_889": SpecialAbilityBase.umrennen,
  "SA_890": SpecialAbilityBase.umwickeln,
  "SA_891": SpecialAbilityBase.ungeheuerTaktik,
  "SA_892": SpecialAbilityBase.weitwurf,
  "SA_893": SpecialAbilityBase.wirbelangriff,
};

class SpecialAbility {
  final SpecialAbilityBase value;
  final int? tier;

  SpecialAbility(this.value, this.tier);

  Map<String, dynamic> toJson() {
    if (tier != null) {
      return {"tier": tier};
    } else {
      return {};
    }
  }

  @override
  String toString() {
    if (tier != null) {
      return "${value.name} ${roman(tier!)}";
    } else {
      return value.name;
    }
  }
}

enum SpecialAbilityType { passive, baseManeuvre, specialManeuvre }

sealed class ApplicableCombatTechniques {
  const ApplicableCombatTechniques();

  const factory ApplicableCombatTechniques.all() = _All;
  const factory ApplicableCombatTechniques.melee() = _Melee;
  const factory ApplicableCombatTechniques.ranged() = _Ranged;
  const factory ApplicableCombatTechniques.meleeWithParry() = _MeleeWithParry;
  const factory ApplicableCombatTechniques.meleeOneHanded() = _MeleeOneHanded;
  const factory ApplicableCombatTechniques.explicitById(List<String> ids) =
      _Explicit;
  const factory ApplicableCombatTechniques.explicitText(String text) =
      _ExplicitText;
}

class _All extends ApplicableCombatTechniques {
  const _All();
}

class _Melee extends ApplicableCombatTechniques {
  const _Melee();
}

class _Ranged extends ApplicableCombatTechniques {
  const _Ranged();
}

class _MeleeWithParry extends ApplicableCombatTechniques {
  const _MeleeWithParry();
}

class _MeleeOneHanded extends ApplicableCombatTechniques {
  const _MeleeOneHanded();
}

class _Explicit extends ApplicableCombatTechniques {
  final List<String> ids;
  const _Explicit(this.ids);
}

class _ExplicitText extends ApplicableCombatTechniques {
  final String text;
  const _ExplicitText(this.text);
}