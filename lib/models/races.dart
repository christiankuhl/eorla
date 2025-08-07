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

  static Map<String, Race> get byID => {for (var it in Race.values) it.id: it};
}

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

  static Map<String, Culture> get byID => {
    for (var it in Culture.values) it.id: it,
  };
}

enum RaceVariant {
  mittellaender("RV_1", "Mittelländer"),
  nivesen("RV_2", "Nivesen"),
  norbarden("RV_3", "Norbarden"),
  thorwaler("RV_4", "Thorwaler"),
  tulamiden("RV_5", "Tulamiden"),
  waldmenschen("RV_6", "Waldmenschen"),
  utulus("RV_7", "Utulus"),
  auelfen("RV_8", "Auelfen"),
  firnelfen("RV_9", "Firnelfen"),
  waldelfen("RV_10", "Waldelfen");

  final String id;
  final String name;
  const RaceVariant(this.id, this.name);

  @override
  String toString() {
    return name;
  }

  static Map<String, RaceVariant> get byID => {
    for (var it in RaceVariant.values) it.id: it,
  };
}
