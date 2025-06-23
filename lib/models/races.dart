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
}

const Map<String, Race> racesById = {
  "R_1": Race.menschen,
  "R_2": Race.elfen,
  "R_3": Race.halbelfen,
  "R_4": Race.zwerge,
};