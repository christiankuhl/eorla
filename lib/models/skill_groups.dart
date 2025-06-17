import 'package:flutter/material.dart';
import '../models/skill.dart';

enum SkillGroup {
  koerpertalente("Körpertalente", "1", Icons.directions_run),
  gesellschaftstalente("Gesellschafts\u00ADtalente", "2", Icons.groups),
  naturtalente("Naturtalente", "3", Icons.terrain),
  wissenstalente("Wissenstalente", "4", Icons.menu_book),
  handwerkstalente("Handwerkstalente", "5", Icons.construction);

  final String name;
  final String id;
  final IconData icon;

  const SkillGroup(this.name, this.id, this.icon);
}

const Map<SkillGroup, List<Skill>> skillGroups = {
  SkillGroup.koerpertalente: [
    Skill.fliegen,
    Skill.gaukeleien,
    Skill.klettern,
    Skill.koerperbeherrschung,
    Skill.kraftakt,
    Skill.reiten,
    Skill.schwimmen,
    Skill.selbstbeherrschung,
    Skill.singen,
    Skill.sinnesschaerfe,
    Skill.tanzen,
    Skill.taschendiebstahl,
    Skill.verbergen,
    Skill.zechen,
  ],
  SkillGroup.gesellschaftstalente: [
    Skill.bekehrenUndUeberzeugen,
    Skill.betoeren,
    Skill.einschuechtern,
    Skill.etikette,
    Skill.gassenwissen,
    Skill.menschenkenntnis,
    Skill.ueberreden,
    Skill.verkleiden,
    Skill.willenskraft,
  ],
  SkillGroup.naturtalente: [
    Skill.faehrtensuchen,
    Skill.fesseln,
    Skill.fischenUndAngeln,
    Skill.orientierung,
    Skill.pflanzenkunde,
    Skill.tierkunde,
    Skill.wildnisleben,
  ],
  SkillGroup.wissenstalente: [
    Skill.brettUndGluecksspiel,
    Skill.geographie,
    Skill.geschichtswissen,
    Skill.goetterUndKulte,
    Skill.kriegskunst,
    Skill.magiekunde,
    Skill.mechanik,
    Skill.rechnen,
    Skill.rechtskunde,
    Skill.sagenUndLegenden,
    Skill.sphaerenkunde,
    Skill.sternkunde,
  ],
  SkillGroup.handwerkstalente: [
    Skill.alchimie,
    Skill.booteUndSchiffe,
    Skill.fahrzeuge,
    Skill.handel,
    Skill.heilkundeGift,
    Skill.heilkundeKrankheiten,
    Skill.heilkundeSeele,
    Skill.heilkundeWunden,
    Skill.holzbearbeitung,
    Skill.lebensmittelbearbeitung,
    Skill.lederbearbeitung,
    Skill.malenUndZeichnen,
    Skill.metallbearbeitung,
    Skill.musizieren,
    Skill.schloesserknacken,
    Skill.steinbearbeitung,
    Skill.stoffbearbeitung,
  ],
};
