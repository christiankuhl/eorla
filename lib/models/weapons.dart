class Weapon {
  final String id;
  final String name;
  final CombatTechnique ct;
  final int at;
  final int pa;
  final int damageDice;
  final int damageDiceSides;
  final int damageFlat;
  Weapon(this.id, this.name, this.ct, this.at, this.pa, this.damageDice, this.damageDiceSides, this.damageFlat);

  factory Weapon.fromJson(Map<String, dynamic> value) {
    return Weapon(value["id"], value["name"], combatTechniques[value["combatTechnique"]]!, value["at"], value["pa"], value["damageDiceNumber"], value["damageDiceSides"], value["damageFlat"]);
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id, "name": name, "combatTechnique": ct.id, "at": at, "pa": pa, "damageDiceNumber": damageDice, "damageDiceSides": damageDiceSides, "damageFlat": damageFlat
    };
  }
}

enum CombatTechnique {
  armbrueste("CT_1", "Armbrüste", ""),
  boegen("CT_2", "Bögen", ""),
  dolche(
    "CT_3",
    "Dolche",
    "Mit Dolchen können Kettenwaffen, Stangenwaffen, Zweihandhiebwaffen und Zweihandschwerter nicht pariert werden.",
  ),
  fechtwaffen(
    "CT_4",
    "Fechtwaffen",
    "Mit Fechtwaffen können Kettenwaffen, Stangenwaffen, Zweihandhiebwaffen und Zweihandschwerter nicht pariert werden. Proben auf Verteidigung gegen Fechtwaffen-Attacken sind um 1 erschwert.",
  ),
  hiebwaffen("CT_5", "Hiebwaffen", ""),
  kettenwaffen(
    "CT_6",
    "Kettenwaffen",
    "Da sie wegen der nur schwer kontrollierbaren Kugeln kaum abzuwehren sind, ist die Parade gegen Kettenwaffen um 2 erschwert. Schilde können darüber hinaus gegen Kettenwaffen nur ihren einfachen Bonus auf die Verteidigung nutzen. Angriffe mit Kettenwaffe gelten bereits ab einem Ergebnis von 19 als Patzer. Mit Kettenwaffen ist keine Parade möglich.",
  ),
  lanzen("CT_7", "Lanzen", ""),
  peitschen(
    "CT_8",
    "Peitschen",
    "Da sie wegen der nur schwer kontrollierbaren Bewegungen kaum abzuwehren sind, ist  die Parade gegen Peitschen um 2 erschwert. Schilde  können darüber hinaus gegen Peitschen nur ihren  einfachen Bonus auf die Verteidigung nutzen. Angriffe mit Peitschen gelten bereits ab einem Ergebnis von 19 als Patzer. Mit Peitschen ist keine Parade möglich.",
  ),
  raufen(
    "CT_9",
    "Raufen",
    "Unbewaffnete erleiden bei einer erfolgreichen Parade mit Raufen gegen Bewaffnete trotzdem den vollen Schaden (und sollten stattdessen besser ausweichen). Wird eine Raufenattacke mit einer Waffe abgewehrt, erleidet der Angreifer den halben Waffenschaden der Waffe des Gegners. Mittels Raufen richtet ein Kämpfer grundsätzlich einen Schaden von 1W6 TP an, der aber wie üblich über die Leiteigenschaft modifiziert werden kann.",
  ),
  schilde(
    "CT_10",
    "Schilde",
    "Der Attacke- und Paradewert von Schilden wird wie bei allen anderen Kampftechniken auch berechnet. Die Parade mit der Kampftechnik Schilde ist jedoch um den doppelten Parade-Bonus des jeweiligen Schildes modifiziert und erleidet keine Abzüge durch das Führen mit der falschen Hand. Fernkampfangriffe und Attacken großer Gegner können mit einem Schild geblockt werden. Ein zweiter Schild erhöht diesen Bonus nicht. Um Fernkampfangriffe abzuwehren muss aktiv mit dem Schild pariert werden, eine Parade mit der Hauptwaffe reicht nicht aus. Mit einem Schild kann man auch angreifen.",
  ),
  schleudern("CT_11", "Schleudern", ""),
  schwerter("CT_12", "Schwerter", ""),
  stangenwaffen("CT_13", "Stangenwaffen", ""),
  wurfwaffen("CT_14", "Wurfwaffen", ""),
  zweihandhiebwaffen("CT_15", "Zweihandhiebwaffen", ""),
  zweihandschwerter("CT_16", "Zweihandschwerter", ""),
  feuerspeien("CT_17", "Feuerspeien", ""),
  blasrohre("CT_18", "Blasrohre", ""),
  diskusse("CT_19", "Diskusse", ""),
  faecher(
    "CT_20",
    "Fächer",
    "Fächer ein- oder ausklappen dauert jeweils 1 Aktion.\nMit dem ausgeklappten Fächer kann man versuchen, Geschosse (Bolzen, Pfeile, Kugeln, Wurfdolche - und Scheiben u. Ä., nicht aber Wurfspeere und -äxte) wie mit einem Schild zu parieren, allerdings erleidet man bei der Parade zusätzlich zu den üblichen Modifikatoren (siehe **Regelwerk** Seite **244**) noch eine Erschwernis von 1.\nMit einem offenen Fächer können nur Nahkampfangriffe der Kampftechniken Raufen, Dolche und Fechtwaffen pariert werden sowie Fernkampftechniken (siehe oben). Nur ein offener Fächer kann als kleiner Schild dienen.\nMit geschlossenem Fächer können Waffen aller Kampftechniken außer Kettenwaffen, Zweihandhiebwaffen, Zweihandschwerter und Fernkampftechniken pariert werden. Nur ein geschlossener Fächer kann als Parierwaffe dienen.",
  ),
  spiesswaffen(
    "CT_21",
    "Spießwaffen",
    "Mit überlangen Spießen können keine normalen Paraden ausgeführt werden, außer eventuell Formationsparaden.",
  );

  final String id;
  final String name;
  final String special;
  const CombatTechnique(this.id, this.name, this.special);
}

const Map<String, CombatTechnique> combatTechniques = {
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
