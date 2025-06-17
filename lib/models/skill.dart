import 'attributes.dart';
import 'rules.dart';
import 'generated/_skill.dart';
export 'generated/_skill.dart';

const Map<String, Skill> skillKeys = {
  "TAL_1": Skill.fliegen,
  "TAL_2": Skill.gaukeleien,
  "TAL_3": Skill.klettern,
  "TAL_4": Skill.koerperbeherrschung,
  "TAL_5": Skill.kraftakt,
  "TAL_6": Skill.reiten,
  "TAL_7": Skill.schwimmen,
  "TAL_8": Skill.selbstbeherrschung,
  "TAL_9": Skill.singen,
  "TAL_10": Skill.sinnesschaerfe,
  "TAL_11": Skill.tanzen,
  "TAL_12": Skill.taschendiebstahl,
  "TAL_13": Skill.verbergen,
  "TAL_14": Skill.zechen,
  "TAL_15": Skill.bekehrenUndUeberzeugen,
  "TAL_16": Skill.betoeren,
  "TAL_17": Skill.einschuechtern,
  "TAL_18": Skill.etikette,
  "TAL_19": Skill.gassenwissen,
  "TAL_20": Skill.menschenkenntnis,
  "TAL_21": Skill.ueberreden,
  "TAL_22": Skill.verkleiden,
  "TAL_23": Skill.willenskraft,
  "TAL_24": Skill.faehrtensuchen,
  "TAL_25": Skill.fesseln,
  "TAL_26": Skill.fischenUndAngeln,
  "TAL_27": Skill.orientierung,
  "TAL_28": Skill.pflanzenkunde,
  "TAL_29": Skill.tierkunde,
  "TAL_30": Skill.wildnisleben,
  "TAL_31": Skill.brettUndGluecksspiel,
  "TAL_32": Skill.geographie,
  "TAL_33": Skill.geschichtswissen,
  "TAL_34": Skill.goetterUndKulte,
  "TAL_35": Skill.kriegskunst,
  "TAL_36": Skill.magiekunde,
  "TAL_37": Skill.mechanik,
  "TAL_38": Skill.rechnen,
  "TAL_39": Skill.rechtskunde,
  "TAL_40": Skill.sagenUndLegenden,
  "TAL_41": Skill.sphaerenkunde,
  "TAL_42": Skill.sternkunde,
  "TAL_43": Skill.alchimie,
  "TAL_44": Skill.booteUndSchiffe,
  "TAL_45": Skill.fahrzeuge,
  "TAL_46": Skill.handel,
  "TAL_47": Skill.heilkundeGift,
  "TAL_48": Skill.heilkundeKrankheiten,
  "TAL_49": Skill.heilkundeSeele,
  "TAL_50": Skill.heilkundeWunden,
  "TAL_51": Skill.holzbearbeitung,
  "TAL_52": Skill.lebensmittelbearbeitung,
  "TAL_53": Skill.lederbearbeitung,
  "TAL_54": Skill.malenUndZeichnen,
  "TAL_55": Skill.metallbearbeitung,
  "TAL_56": Skill.musizieren,
  "TAL_57": Skill.schloesserknacken,
  "TAL_58": Skill.steinbearbeitung,
  "TAL_59": Skill.stoffbearbeitung,
};

class SkillWrapper implements Trial {
  final Skill skill;

  SkillWrapper(this.skill);

  @override
  Attribute get attr1 => skill.attr1;
  @override
  Attribute get attr2 => skill.attr2;
  @override
  Attribute get attr3 => skill.attr3;
  @override
  String get name => skill.name;
}
