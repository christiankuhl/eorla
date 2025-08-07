enum Attribute {
  mut("ATTR_1", "Mut", "MU"),
  klugheit("ATTR_2", "Klugheit", "KL"),
  intuition("ATTR_3", "Intuition", "IN"),
  charisma("ATTR_4", "Charisma", "CH"),
  fingerfertigkeit("ATTR_5", "Fingerfertigkeit", "FF"),
  gewandtheit("ATTR_6", "Gewandtheit", "GE"),
  konstitution("ATTR_7", "Konstitution", "KO"),
  koerperkraft("ATTR_8", "Körperkraft", "KK");

  final String id;
  final String name;
  final String short;

  const Attribute(this.id, this.name, this.short);
  static Map<String, Attribute> get byID => {
    for (var it in Attribute.values) it.id: it,
  };
}
