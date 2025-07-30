enum Race {
  menschen("R_1", "Menschen", 5, -5, -5, 8),
  elfen("R_2", "Elfen", 2, -4, -6, 8),
  halbelfen("R_3", "Halbelfen", 5, -4, -6, 8),
  zwerge("R_4", "Zwerge", 8, -4, -4, 6);

  final String id;
  final String name;
  final int lp;
  final int spi;
  final int tou;
  final int mov;

  const Race(this.id, this.name, this.lp, this.spi, this.tou, this.mov);

  @override
  String toString() {
    return name;
  }
}

const Map<String, Race> racesById = {
  "R_1": Race.menschen,
  "R_2": Race.elfen,
  "R_3": Race.halbelfen,
  "R_4": Race.zwerge,
};

enum Culture {
  andergaster("C_1", "Andergaster"),
  aranier("C_2", "Aranier"),
  bornlaender("C_3", "Bornländer"),
  fjarninger("C_4", "Fjarninger"),
  horasier("C_5", "Horasier"),
  maraskaner("C_6", "Maraskaner"),
  mhanadistani("C_7", "Mhanadistani"),
  mittelreicher("C_8", "Mittelreicher"),
  mohas("C_9", "Mohas"),
  nivesen("C_10", "Nivesen"),
  norbarden("C_11", "Norbarden"),
  nordaventurier("C_12", "Nordaventurier"),
  nostrier("C_13", "Nostrier"),
  novadis("C_14", "Novadis"),
  suedaventurier("C_15", "Südaventurier"),
  svellttaler("C_16", "Svellttaler"),
  thorwaler("C_17", "Thorwaler"),
  zyklopaeer("C_18", "Zyklopäer"),
  auelfen("C_19", "Auelfen"),
  firnelfen("C_20", "Firnelfen"),
  waldelfen("C_21", "Waldelfen"),
  ambosszwerge("C_22", "Ambosszwerge"),
  brillantzwerge("C_23", "Brillantzwerge"),
  erzzwerge("C_24", "Erzzwerge"),
  huegelzwerge("C_25", "Hügelzwerge"),
  zahori("C_26", "Zahori"),
  koboldweltler("C_27", "Koboldweltler"),
  steppenelfen("C_28", "Steppenelfen"),
  engasaler("C_29", "Engasaler"),
  ferkina("C_30", "Ferkina"),
  gjalsker("C_31", "Gjalsker"),
  trollzacker("C_32", "Trollzacker"),
  wildzwerge("C_33", "Wildzwerge");

  final String id;
  final String name;

  const Culture(this.id, this.name);

  @override
  String toString() {
    return name;
  }
}

const Map<String, Culture> culturesById = {
  "C_1": Culture.andergaster,
  "C_2": Culture.aranier,
  "C_3": Culture.bornlaender,
  "C_4": Culture.fjarninger,
  "C_5": Culture.horasier,
  "C_6": Culture.maraskaner,
  "C_7": Culture.mhanadistani,
  "C_8": Culture.mittelreicher,
  "C_9": Culture.mohas,
  "C_10": Culture.nivesen,
  "C_11": Culture.norbarden,
  "C_12": Culture.nordaventurier,
  "C_13": Culture.nostrier,
  "C_14": Culture.novadis,
  "C_15": Culture.suedaventurier,
  "C_16": Culture.svellttaler,
  "C_17": Culture.thorwaler,
  "C_18": Culture.zyklopaeer,
  "C_19": Culture.auelfen,
  "C_20": Culture.firnelfen,
  "C_21": Culture.waldelfen,
  "C_22": Culture.ambosszwerge,
  "C_23": Culture.brillantzwerge,
  "C_24": Culture.erzzwerge,
  "C_25": Culture.huegelzwerge,
  "C_26": Culture.zahori,
  "C_27": Culture.koboldweltler,
  "C_28": Culture.steppenelfen,
  "C_29": Culture.engasaler,
  "C_30": Culture.ferkina,
  "C_31": Culture.gjalsker,
  "C_32": Culture.trollzacker,
  "C_33": Culture.wildzwerge,
};
