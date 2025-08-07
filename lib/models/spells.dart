import 'attributes.dart';
import 'rules.dart';
import 'generated/_spells.dart';
export 'generated/_spells.dart';

enum SpellGroup {
  zaubersprueche(1, "Zaubersprüche"),
  rituale(2, "Rituale"),
  flueche(3, "Flüche"),
  elfenlieder(4, "Elfenlieder"),
  zaubermelodien(5, "Zaubermelodien"),
  zaubertaenze(6, "Zaubertänze"),
  herrschaftsrituale(7, "Herrschaftsrituale"),
  schelmenzauber(8, "Schelmenzauber"),
  animistenkraefte(9, "Animistenkräfte"),
  geodenrituale(10, "Geodenrituale"),
  zibiljarituale(11, "Zibiljarituale");

  final int id;
  final String name;
  const SpellGroup(this.id, this.name);
}

enum SpellProperty {
  antimagie(1, "Antimagie"),
  daemonisch(2, "Dämonisch"),
  einfluss(3, "Einfluss"),
  elementar(4, "Elementar"),
  heilung(5, "Heilung"),
  hellsicht(6, "Hellsicht"),
  illusion(7, "Illusion"),
  sphaeren(8, "Sphären"),
  objekt(9, "Objekt"),
  telekinese(10, "Telekinese"),
  verwandlung(11, "Verwandlung"),
  temporal(12, "Temporal");

  final int id;
  final String name;
  const SpellProperty(this.id, this.name);
}

enum CheckModifier {
  spi("SPI"),
  spi2("SPI/2"),
  tou("TOU"),
  spitou("SPI/TOU");

  final String name;
  const CheckModifier(this.name);
}

class SpellWrapper implements Trial {
  final Spell spell;

  SpellWrapper(this.spell);

  @override
  Attribute get attr1 => spell.check1;
  @override
  Attribute get attr2 => spell.check2;
  @override
  Attribute get attr3 => spell.check3;
  @override
  String get name => spell.name;
}
