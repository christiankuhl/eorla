import '../models/attributes.dart';

class Weapon {
  final String id;
  final String name;
  final CombatTechnique ct;
  final int at;
  final int pa;
  final int damageDice;
  final int damageDiceSides;
  final int damageFlat;
  final int primaryThreshold;
  Weapon(
    this.id,
    this.name,
    this.ct,
    this.at,
    this.pa,
    this.damageDice,
    this.damageDiceSides,
    this.damageFlat,
    this.primaryThreshold,
  );

  factory Weapon.fromJson(Map<String, dynamic> value) {
    return Weapon(
      value["id"] ?? "unknown_weapon",
      value["name"] ?? "Unbenannte Waffe",
      combatTechniquesByID[value["combatTechnique"]] ??
          CombatTechnique.schwerter,
      value["at"] ?? 0,
      value["pa"] ?? 0,
      value["damageDiceNumber"] ?? 0,
      value["damageDiceSides"] ?? 6,
      value["damageFlat"] ?? 0,
      (value["primaryThreshold"] ?? {"threshold": 20})["threshold"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "name": name,
      "combatTechnique": ct.id,
      "at": at,
      "pa": pa,
      "damageDiceNumber": damageDice,
      "damageDiceSides": damageDiceSides,
      "damageFlat": damageFlat,
      "primaryThreshold": {"threshold": primaryThreshold},
    };
  }

  String tpText() {
    String result = "${damageDice}W$damageDiceSides";
    if (damageFlat > 0) {
      result += "+$damageFlat";
    }
    return result;
  }
}

const List<String> oneHandedCTs = ["CT_3", "CT_4", "CT_5", "CT_6", "CT_8", "CT_10", "CT_12", "CT_20"];

enum CombatTechnique {
  armbrueste("CT_1", "Armbrüste", "", CombatType.range, [
    Attribute.fingerfertigkeit,
  ], true),
  boegen("CT_2", "Bögen", "", CombatType.range, [
    Attribute.fingerfertigkeit,
  ], true),
  dolche(
    "CT_3",
    "Dolche",
    "Mit Dolchen können Kettenwaffen, Stangenwaffen, Zweihandhiebwaffen und Zweihandschwerter nicht pariert werden.",
    CombatType.melee,
    [Attribute.gewandtheit],
    false,
  ),
  fechtwaffen(
    "CT_4",
    "Fechtwaffen",
    "Mit Fechtwaffen können Kettenwaffen, Stangenwaffen, Zweihandhiebwaffen und Zweihandschwerter nicht pariert werden. Proben auf Verteidigung gegen Fechtwaffen-Attacken sind um 1 erschwert.",
    CombatType.melee,
    [Attribute.gewandtheit],
    false,
  ),
  hiebwaffen("CT_5", "Hiebwaffen", "", CombatType.melee, [
    Attribute.koerperkraft,
  ], false),
  kettenwaffen(
    "CT_6",
    "Kettenwaffen",
    "Da sie wegen der nur schwer kontrollierbaren Kugeln kaum abzuwehren sind, ist die Parade gegen Kettenwaffen um 2 erschwert. Schilde können darüber hinaus gegen Kettenwaffen nur ihren einfachen Bonus auf die Verteidigung nutzen. Angriffe mit Kettenwaffe gelten bereits ab einem Ergebnis von 19 als Patzer. Mit Kettenwaffen ist keine Parade möglich.",
    CombatType.melee,
    [Attribute.koerperkraft],
    true,
  ),
  lanzen("CT_7", "Lanzen", "", CombatType.melee, [
    Attribute.koerperkraft,
  ], false),
  peitschen(
    "CT_8",
    "Peitschen",
    "Da sie wegen der nur schwer kontrollierbaren Bewegungen kaum abzuwehren sind, ist  die Parade gegen Peitschen um 2 erschwert. Schilde  können darüber hinaus gegen Peitschen nur ihren  einfachen Bonus auf die Verteidigung nutzen. Angriffe mit Peitschen gelten bereits ab einem Ergebnis von 19 als Patzer. Mit Peitschen ist keine Parade möglich.",
    CombatType.melee,
    [Attribute.fingerfertigkeit],
    true,
  ),
  raufen(
    "CT_9",
    "Raufen",
    "Unbewaffnete erleiden bei einer erfolgreichen Parade mit Raufen gegen Bewaffnete trotzdem den vollen Schaden (und sollten stattdessen besser ausweichen). Wird eine Raufenattacke mit einer Waffe abgewehrt, erleidet der Angreifer den halben Waffenschaden der Waffe des Gegners. Mittels Raufen richtet ein Kämpfer grundsätzlich einen Schaden von 1W6 TP an, der aber wie üblich über die Leiteigenschaft modifiziert werden kann.",
    CombatType.melee,
    [Attribute.koerperkraft, Attribute.gewandtheit],
    false,
  ),
  schilde(
    "CT_10",
    "Schilde",
    "Der Attacke- und Paradewert von Schilden wird wie bei allen anderen Kampftechniken auch berechnet. Die Parade mit der Kampftechnik Schilde ist jedoch um den doppelten Parade-Bonus des jeweiligen Schildes modifiziert und erleidet keine Abzüge durch das Führen mit der falschen Hand. Fernkampfangriffe und Attacken großer Gegner können mit einem Schild geblockt werden. Ein zweiter Schild erhöht diesen Bonus nicht. Um Fernkampfangriffe abzuwehren muss aktiv mit dem Schild pariert werden, eine Parade mit der Hauptwaffe reicht nicht aus. Mit einem Schild kann man auch angreifen.",
    CombatType.melee,
    [Attribute.koerperkraft],
    false,
  ),
  schleudern("CT_11", "Schleudern", "", CombatType.range, [
    Attribute.fingerfertigkeit,
  ], true),
  schwerter("CT_12", "Schwerter", "", CombatType.melee, [
    Attribute.koerperkraft,
    Attribute.gewandtheit,
  ], false),
  stangenwaffen("CT_13", "Stangenwaffen", "", CombatType.melee, [
    Attribute.koerperkraft,
    Attribute.gewandtheit,
  ], false),
  wurfwaffen("CT_14", "Wurfwaffen", "", CombatType.range, [
    Attribute.fingerfertigkeit,
  ], true),
  zweihandhiebwaffen("CT_15", "Zweihandhiebwaffen", "", CombatType.melee, [
    Attribute.koerperkraft,
  ], false),
  zweihandschwerter("CT_16", "Zweihandschwerter", "", CombatType.melee, [
    Attribute.koerperkraft,
  ], false),
  feuerspeien("CT_17", "Feuerspeien", "", CombatType.range, [
    Attribute.fingerfertigkeit,
  ], true),
  blasrohre("CT_18", "Blasrohre", "", CombatType.range, [
    Attribute.fingerfertigkeit,
  ], true),
  diskusse("CT_19", "Diskusse", "", CombatType.range, [
    Attribute.fingerfertigkeit,
  ], true),
  faecher(
    "CT_20",
    "Fächer",
    "Fächer ein- oder ausklappen dauert jeweils 1 Aktion.\nMit dem ausgeklappten Fächer kann man versuchen, Geschosse (Bolzen, Pfeile, Kugeln, Wurfdolche - und Scheiben u. Ä., nicht aber Wurfspeere und -äxte) wie mit einem Schild zu parieren, allerdings erleidet man bei der Parade zusätzlich zu den üblichen Modifikatoren (siehe **Regelwerk** Seite **244**) noch eine Erschwernis von 1.\nMit einem offenen Fächer können nur Nahkampfangriffe der Kampftechniken Raufen, Dolche und Fechtwaffen pariert werden sowie Fernkampftechniken (siehe oben). Nur ein offener Fächer kann als kleiner Schild dienen.\nMit geschlossenem Fächer können Waffen aller Kampftechniken außer Kettenwaffen, Zweihandhiebwaffen, Zweihandschwerter und Fernkampftechniken pariert werden. Nur ein geschlossener Fächer kann als Parierwaffe dienen.",
    CombatType.melee,
    [Attribute.gewandtheit],
    false,
  ),
  spiesswaffen(
    "CT_21",
    "Spießwaffen",
    "Mit überlangen Spießen können keine normalen Paraden ausgeführt werden, außer eventuell Formationsparaden.",
    CombatType.melee,
    [Attribute.koerperkraft],
    false,
  );

  final String id;
  final String name;
  final String special;
  final CombatType group;
  final List<Attribute> primary;
  final bool hasNoParry;
  const CombatTechnique(
    this.id,
    this.name,
    this.special,
    this.group,
    this.primary,
    this.hasNoParry,
  );
}

enum CombatType {
  melee("Nahkampf"),
  range("Fernkampf");

  final String name;
  const CombatType(this.name);
}

const Map<String, CombatTechnique> combatTechniquesByID = {
  "CT_1": CombatTechnique.armbrueste,
  "CT_2": CombatTechnique.boegen,
  "CT_3": CombatTechnique.dolche,
  "CT_4": CombatTechnique.fechtwaffen,
  "CT_5": CombatTechnique.hiebwaffen,
  "CT_6": CombatTechnique.kettenwaffen,
  "CT_7": CombatTechnique.lanzen,
  "CT_8": CombatTechnique.peitschen,
  "CT_9": CombatTechnique.raufen,
  "CT_10": CombatTechnique.schilde,
  "CT_11": CombatTechnique.schleudern,
  "CT_12": CombatTechnique.schwerter,
  "CT_13": CombatTechnique.stangenwaffen,
  "CT_14": CombatTechnique.wurfwaffen,
  "CT_15": CombatTechnique.zweihandhiebwaffen,
  "CT_16": CombatTechnique.zweihandschwerter,
  "CT_17": CombatTechnique.feuerspeien,
  "CT_18": CombatTechnique.blasrohre,
  "CT_19": CombatTechnique.diskusse,
  "CT_20": CombatTechnique.faecher,
  "CT_21": CombatTechnique.spiesswaffen,
};

enum CombatActionType { attack, dodge, parry }

final Map<CombatTechnique, Weapon> genericWeapons = {
  CombatTechnique.armbrueste: Weapon(
    /* Weapon ID          */ "ADHOC_Armbrust",
    /* Name               */ "Leichte Armbrust",
    /* Combat Technique   */ CombatTechnique.armbrueste,
    /* Attack Value (AT)  */ 0,
    /* Parry Value (PA)   */ 0,
    /* Damage Dice Number */ 1,
    /* Damage Dice Sides  */ 6,
    /* Damage Flat        */ 6,
    /* Primary Threshold  */ 20,
  ),
  CombatTechnique.boegen: Weapon(
    /* Weapon ID          */ "ADHOC_Kurzbogen",
    /* Name               */ "Kurzbogen",
    /* Combat Technique   */ CombatTechnique.boegen,
    /* Attack Value (AT)  */ 0,
    /* Parry Value (PA)   */ 0,
    /* Damage Dice Number */ 1,
    /* Damage Dice Sides  */ 6,
    /* Damage Flat        */ 4,
    /* Primary Threshold  */ 20,
  ),
  CombatTechnique.dolche: Weapon(
    /* Weapon ID          */ "ADHOC_Dolch",
    /* Name               */ "Dolch",
    /* Combat Technique   */ CombatTechnique.dolche,
    /* Attack Value (AT)  */ 0,
    /* Parry Value (PA)   */ 0,
    /* Damage Dice Number */ 1,
    /* Damage Dice Sides  */ 6,
    /* Damage Flat        */ 1,
    /* Primary Threshold  */ 14,
  ),
  CombatTechnique.fechtwaffen: Weapon(
    /* Weapon ID          */ "ADHOC_Degen",
    /* Name               */ "Degen",
    /* Combat Technique   */ CombatTechnique.fechtwaffen,
    /* Attack Value (AT)  */ 0,
    /* Parry Value (PA)   */ 1,
    /* Damage Dice Number */ 1,
    /* Damage Dice Sides  */ 6,
    /* Damage Flat        */ 3,
    /* Primary Threshold  */ 15,
  ),
  CombatTechnique.hiebwaffen: Weapon(
    /* Weapon ID          */ "ADHOC_Keule",
    /* Name               */ "Keule",
    /* Combat Technique   */ CombatTechnique.hiebwaffen,
    /* Attack Value (AT)  */ -1,
    /* Parry Value (PA)   */ -3,
    /* Damage Dice Number */ 1,
    /* Damage Dice Sides  */ 6,
    /* Damage Flat        */ 2,
    /* Primary Threshold  */ 14,
  ),
  CombatTechnique.kettenwaffen: Weapon(
    /* Weapon ID          */ "ADHOC_Morgenstern",
    /* Name               */ "Morgenstern",
    /* Combat Technique   */ CombatTechnique.kettenwaffen,
    /* Attack Value (AT)  */ 0,
    /* Parry Value (PA)   */ 0,
    /* Damage Dice Number */ 1,
    /* Damage Dice Sides  */ 6,
    /* Damage Flat        */ 5,
    /* Primary Threshold  */ 14,
  ),
  CombatTechnique.lanzen: Weapon(
    /* Weapon ID          */ "ADHOC_Turnierlanze",
    /* Name               */ "Turnierlanze",
    /* Combat Technique   */ CombatTechnique.lanzen,
    /* Attack Value (AT)  */ 0,
    /* Parry Value (PA)   */ 0,
    /* Damage Dice Number */ 1,
    /* Damage Dice Sides  */ 6,
    /* Damage Flat        */ 8,
    /* Primary Threshold  */ 20,
  ),
  CombatTechnique.peitschen: Weapon(
    /* Weapon ID          */ "ADHOC_Peitsche",
    /* Name               */ "Peitsche",
    /* Combat Technique   */ CombatTechnique.peitschen,
    /* Attack Value (AT)  */ 0,
    /* Parry Value (PA)   */ 0,
    /* Damage Dice Number */ 1,
    /* Damage Dice Sides  */ 6,
    /* Damage Flat        */ 0,
    /* Primary Threshold  */ 16,
  ),
  CombatTechnique.raufen: Weapon(
    /* Weapon ID          */ "ADHOC_Raufen",
    /* Name               */ "Raufen",
    /* Combat Technique   */ CombatTechnique.raufen,
    /* Attack Value (AT)  */ 0,
    /* Parry Value (PA)   */ 0,
    /* Damage Dice Number */ 1,
    /* Damage Dice Sides  */ 6,
    /* Damage Flat        */ 0,
    /* Primary Threshold  */ 20,
  ),
  CombatTechnique.schilde: Weapon(
    /* Weapon ID          */ "ADHOC_Holzschild",
    /* Name               */ "Holzschild",
    /* Combat Technique   */ CombatTechnique.schilde,
    /* Attack Value (AT)  */ -4,
    /* Parry Value (PA)   */ 1,
    /* Damage Dice Number */ 1,
    /* Damage Dice Sides  */ 6,
    /* Damage Flat        */ 0,
    /* Primary Threshold  */ 16,
  ),
  CombatTechnique.schleudern: Weapon(
    /* Weapon ID          */ "ADHOC_Schleuder",
    /* Name               */ "Schleuder",
    /* Combat Technique   */ CombatTechnique.schleudern,
    /* Attack Value (AT)  */ 0,
    /* Parry Value (PA)   */ 0,
    /* Damage Dice Number */ 1,
    /* Damage Dice Sides  */ 6,
    /* Damage Flat        */ 2,
    /* Primary Threshold  */ 20,
  ),
  CombatTechnique.schwerter: Weapon(
    /* Weapon ID          */ "ADHOC_Kurzschwert",
    /* Name               */ "Kurzschwert",
    /* Combat Technique   */ CombatTechnique.schwerter,
    /* Attack Value (AT)  */ 0,
    /* Parry Value (PA)   */ 0,
    /* Damage Dice Number */ 1,
    /* Damage Dice Sides  */ 6,
    /* Damage Flat        */ 2,
    /* Primary Threshold  */ 15,
  ),
  CombatTechnique.stangenwaffen: Weapon(
    /* Weapon ID          */ "ADHOC_Kampfstab",
    /* Name               */ "Kampfstab",
    /* Combat Technique   */ CombatTechnique.stangenwaffen,
    /* Attack Value (AT)  */ 0,
    /* Parry Value (PA)   */ 2,
    /* Damage Dice Number */ 1,
    /* Damage Dice Sides  */ 6,
    /* Damage Flat        */ 2,
    /* Primary Threshold  */ 15,
  ),
  CombatTechnique.wurfwaffen: Weapon(
    /* Weapon ID          */ "ADHOC_Wurfmesser",
    /* Name               */ "Wurfmesser",
    /* Combat Technique   */ CombatTechnique.wurfwaffen,
    /* Attack Value (AT)  */ 0,
    /* Parry Value (PA)   */ 0,
    /* Damage Dice Number */ 1,
    /* Damage Dice Sides  */ 6,
    /* Damage Flat        */ 1,
    /* Primary Threshold  */ 20,
  ),
  CombatTechnique.zweihandhiebwaffen: Weapon(
    /* Weapon ID          */ "ADHOC_Holzfälleraxt",
    /* Name               */ "Holzfälleraxt",
    /* Combat Technique   */ CombatTechnique.zweihandhiebwaffen,
    /* Attack Value (AT)  */ 0,
    /* Parry Value (PA)   */ -4,
    /* Damage Dice Number */ 2,
    /* Damage Dice Sides  */ 1,
    /* Damage Flat        */ 6,
    /* Primary Threshold  */ 13,
  ),
  CombatTechnique.zweihandschwerter: Weapon(
    /* Weapon ID          */ "ADHOC_Anderthalbhänder",
    /* Name               */ "Anderthalbhänder",
    /* Combat Technique   */ CombatTechnique.zweihandschwerter,
    /* Attack Value (AT)  */ 0,
    /* Parry Value (PA)   */ 0,
    /* Damage Dice Number */ 1,
    /* Damage Dice Sides  */ 6,
    /* Damage Flat        */ 6,
    /* Primary Threshold  */ 14,
  ),
  CombatTechnique.feuerspeien: Weapon(
    /* Weapon ID          */ "ADHOC_Feuerspeien",
    /* Name               */ "Feuerspeien",
    /* Combat Technique   */ CombatTechnique.feuerspeien,
    /* Attack Value (AT)  */ 0,
    /* Parry Value (PA)   */ 0,
    /* Damage Dice Number */ 1,
    /* Damage Dice Sides  */ 6,
    /* Damage Flat        */ 0,
    /* Primary Threshold  */ 20,
  ),
  CombatTechnique.blasrohre: Weapon(
    /* Weapon ID          */ "ADHOC_Blasrohr",
    /* Name               */ "Blasrohr",
    /* Combat Technique   */ CombatTechnique.blasrohre,
    /* Attack Value (AT)  */ 0,
    /* Parry Value (PA)   */ 0,
    /* Damage Dice Number */ 1,
    /* Damage Dice Sides  */ 2,
    /* Damage Flat        */ 0,
    /* Primary Threshold  */ 20,
  ),
  CombatTechnique.diskusse: Weapon(
    /* Weapon ID          */ "ADHOC_Diskus",
    /* Name               */ "Diskus",
    /* Combat Technique   */ CombatTechnique.diskusse,
    /* Attack Value (AT)  */ 0,
    /* Parry Value (PA)   */ 0,
    /* Damage Dice Number */ 1,
    /* Damage Dice Sides  */ 6,
    /* Damage Flat        */ 2,
    /* Primary Threshold  */ 20,
  ),
  CombatTechnique.faecher: Weapon(
    /* Weapon ID          */ "ADHOC_Kriegsfächer",
    /* Name               */ "Kriegsfächer",
    /* Combat Technique   */ CombatTechnique.faecher,
    /* Attack Value (AT)  */ -3,
    /* Parry Value (PA)   */ 0,
    /* Damage Dice Number */ 1,
    /* Damage Dice Sides  */ 6,
    /* Damage Flat        */ 2,
    /* Primary Threshold  */ 15,
  ),
  CombatTechnique.spiesswaffen: Weapon(
    /* Weapon ID          */ "ADHOC_Pike",
    /* Name               */ "Pike",
    /* Combat Technique   */ CombatTechnique.spiesswaffen,
    /* Attack Value (AT)  */ 0,
    /* Parry Value (PA)   */ 0,
    /* Damage Dice Number */ 1,
    /* Damage Dice Sides  */ 6,
    /* Damage Flat        */ 5,
    /* Primary Threshold  */ 15,
  ),
};
