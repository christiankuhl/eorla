enum ItemGroup {
  nahkampfwaffen(1, "Nahkampfwaffen"),
  fernkampfwaffen(2, "Fernkampfwaffen"),
  munition(3, "Munition"),
  ruestungen(4, "Rüstungen"),
  waffenzubehoer(5, "Waffenzubehör"),
  kleidung(6, "Kleidung"),
  reisebedarf(7, "Reisebedarf/Werkzeuge"),
  beleuchtung(8, "Beleuchtung"),
  verbandzeug(9, "Verbandzeug/Heilmittel"),
  behaeltnisse(10, "Behältnisse"),
  seileUndKetten(11, "Seile/Ketten"),
  diebeswerkzeug(12, "Diebeswerkzeug"),
  handwerkszeug(13, "Handwerkszeug"),
  orientierungshilfen(14, "Orientierungshilfen"),
  schmuck(15, "Schmuck"),
  edelsteine(16, "Edelsteine/Feingestein"),
  schreibwaren(17, "Schreibwaren"),
  buecher(18, "Bücher"),
  magischeArtefakte(19, "Magische Artefakte"),
  alchimica(20, "Alchimica"),
  gifte(21, "Gifte"),
  heilkraeuter(22, "Heilkräuter"),
  musikinstrumente(23, "Musikinstrumente"),
  genussmittelUndLuxus(24, "Genussmittel/Luxus"),
  tiere(25, "Tiere"),
  tierbedarf(26, "Tierbedarf"),
  fortbewegungsmittel(27, "Fortbewegungsmittel"),
  ausruestungDerGeweihtenschaft(28, "Ausrüstung der Geweihtenschaft"),
  zeremonialgegenstaende(29, "Zeremonialgegenstände"),
  liebesspielzeug(30, "Liebesspielzeug"),
  unbekannt(31, "Sonstiges");

  final int id;
  final String name;
  const ItemGroup(this.id, this.name);

  static Map<int, ItemGroup> get byID => {
    for (var it in ItemGroup.values) it.id: it,
  };
}

class InventoryItem {
  final String id;
  final String name;
  final ItemGroup group;
  final double? weight;
  final int? price;
  int? amount;

  InventoryItem(
    this.id,
    this.name,
    this.group,
    this.weight,
    this.price,
    this.amount,
  );

  factory InventoryItem.fromJson(Map<String, dynamic> item) {
    return InventoryItem(
      item["id"]!,
      item["name"] ?? "Unbenannter Ausrüstungsgegenstand",
      ItemGroup.byID[item["gr"] ?? 31]!,
      item["weight"]?.toDouble(),
      item["price"]?.toInt(),
      item["amount"]?.toInt(),
    );
  }
}

class Purse {
  int d;
  int s;
  int h;
  int k;

  Purse(this.d, this.s, this.h, this.k);

  factory Purse.fromJson(Map<String, dynamic> value) {
    return Purse(
      int.tryParse(value["d"] ?? "0")!,
      int.tryParse(value["s"] ?? "0")!,
      int.tryParse(value["h"] ?? "0")!,
      int.tryParse(value["k"] ?? "0")!,
    );
  }

  Map<String, String> toJson() {
    return {
      "d": d.toString(),
      "s": s.toString(),
      "h": h.toString(),
      "k": k.toString(),
    };
  }
}
