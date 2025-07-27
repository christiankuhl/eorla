abstract interface class RuleMixin {
  static RuleMixin from(int twoW6) {
    throw UnimplementedError();
  }

  (String, String) normalRule();
  (String, String) focusRule(int w20);

  String get title;
  String get effect;
}

enum CriticalDefenseRanged implements RuleMixin {
  sehrGuteGelegenheitZumAngriff(
    "Sehr gute Gelegenheit zum Angriff",
    "Der Held kann bis zum Ende der nächsten KR Erschwernisse auf AT und FK um 2 senken (bis zu einem Maximum von +/–0).",
  ),
  guteGelegenheitZumAngriff(
    "Gute Gelegenheit zum Angriff",
    "Der Held kann bis zum Ende der nächsten KR Erschwernisse auf AT und FK um 1 senken (bis zu einem Maximum von +/–0).",
  ),
  grosseVerteidigungsluecke(
    "Große Verteidigungslücke",
    "Die Verteidigung des Gegners, der den Abenteurer angegriffen hat, ist bis zum Ende der nächsten KR gegen den Helden um 3 erschwert.",
  ),
  kleineVerteidigungsluecke(
    "Kleine Verteidigungslücke",
    "Für den Gegner ist bis zum Ende der nächsten KR die Verteidigung um 1 erschwert.",
  ),
  angriffssituation(
    "Angriffssituation",
    "Der Held bekommt bis zum Ende der nächsten KR einen Bonus von +1 AT und +1 FK.",
  ),
  verteidigungsvorteil(
    "Verteidigungsvorteil",
    "Der Verteidigungswert sinkt nicht um 3 wie üblich bei der nächsten Verteidigung in dieser Kampfrunde.",
  ),
  verteidigungssituation(
    "Verteidigungssituation",
    "Der Held bekommt bis zum Ende der nächsten KR einen Bonus von +1 VW.",
  ),
  guteAngriffsposition(
    "Gute Angriffsposition",
    "Der Held bekommt bis zum Ende der nächsten KR einen Bonus von +2 AT und +2 FK.",
  ),
  herausragendeKampfsituation(
    "Herausragende Kampfsituation",
    "Der Held bekommt bis zum Ende der nächsten KR einen Bonus von +2 AT, +2 FK und +1 VW.",
  ),
  bloesse(
    "Blöße",
    "Bis zum Ende der nächsten KR sind alle Proben auf AT und FK, die gegen den Gegner gerichtet sind, um 1 erleichtert, gleich ob durch den Helden oder seine Gefährten.",
  ),
  aufDemPraesentierteller(
    "Auf dem Präsentierteller",
    "Bis zum Ende der nächsten KR sind Verteidigungen des Gegners um 1 erschwert, außerdem sind alle Proben auf AT und FK gegen ihn um 1 erleichtert, gleich ob durch den Helden oder seine Gefährten.",
  );

  @override
  final String title;
  @override
  final String effect;
  const CriticalDefenseRanged(this.title, this.effect);

  static CriticalDefenseRanged from(int twoW6) {
    switch (twoW6) {
      case 2:
        return CriticalDefenseRanged.sehrGuteGelegenheitZumAngriff;

      case 3:
        return CriticalDefenseRanged.guteGelegenheitZumAngriff;

      case 4:
        return CriticalDefenseRanged.grosseVerteidigungsluecke;

      case 5:
        return CriticalDefenseRanged.kleineVerteidigungsluecke;

      case 6:
        return CriticalDefenseRanged.angriffssituation;

      case 7:
        return CriticalDefenseRanged.verteidigungsvorteil;

      case 8:
        return CriticalDefenseRanged.verteidigungssituation;

      case 9:
        return CriticalDefenseRanged.guteAngriffsposition;

      case 10:
        return CriticalDefenseRanged.herausragendeKampfsituation;

      case 11:
        return CriticalDefenseRanged.bloesse;

      case 12:
        return CriticalDefenseRanged.aufDemPraesentierteller;

      default:
        assert(false, "unreachable!");
        return CriticalDefenseRanged.sehrGuteGelegenheitZumAngriff;
    }
  }

  @override
  (String, String) normalRule() {
    return (
      "Kritischer Erfolg!",
      "Die nächste Verteidigung in dieser Kampfrunde ist nicht um 3 erschwert.",
    );
  }

  @override
  (String, String) focusRule(int w20) {
    switch (this) {
      case CriticalDefenseRanged.sehrGuteGelegenheitZumAngriff:
        if (1 <= w20 && w20 <= 10) {
          return (
            "Sehr gute Gelegenheit zum Angriff",
            "Der Held kann bis zum Ende der nächsten KR Erschwernisse auf AT und FK um 2 senken (bis zu einem Maximum von +/–0).",
          );
        } else if (11 <= w20 && w20 <= 20) {
          return (
            "Sehr gute Gelegenheit zum Angriff",
            "Der Held kann bis zum Ende der nächsten KR Erschwernisse auf AT und FK um 3 senken (bis zu einem Maximum von +/–0), wenn er den Vorteil nutzt, sinkt seine Verteidigung im selben Zeitraum um 1.",
          );
        } else {
          assert(false, "unreachable!");
          return ("This should not occur!", "This should not occur!");
        }

      case CriticalDefenseRanged.guteGelegenheitZumAngriff:
        if (1 <= w20 && w20 <= 6) {
          return (
            "Gute Gelegenheit zum Angriff",
            "Der Held kann bis zum Ende der nächsten KR Erschwernisse auf AT und FK um 2 senken (bis zu einem Maximum von +/ 0), wenn er den Vorteil nutzt, sinkt seine Verteidigung im selben Zeitraum um 1.",
          );
        } else if (7 <= w20 && w20 <= 12) {
          return (
            "Gute Gelegenheit zum Angriff",
            "Der Held kann bis zum Ende der nächsten KR Erschwernisse auf AT und FK um 1 senken (bis zu einem Maximum von +/–0).",
          );
        } else if (13 <= w20 && w20 <= 18) {
          return (
            "Gute Gelegenheit zum Angriff",
            "Der Held kann bis zum Ende der nächsten KR Erschwernisse auf AT und FK um 1 senken (bis zu einem Maximum von +/–0), außerdem ist die Verteidigung gegen seine Angriffe im selben Zeitraum zusätzlich um 1 erschwert.",
          );
        } else if (19 <= w20 && w20 <= 20) {
          return ("Gute Gelegenheit zum Angriff", "nochmal würfeln");
        } else {
          assert(false, "unreachable!");
          return ("This should not occur!", "This should not occur!");
        }

      case CriticalDefenseRanged.grosseVerteidigungsluecke:
        if (1 <= w20 && w20 <= 5) {
          return (
            "Große Verteidigungslücke",
            "Die Verteidigung des Gegners, der den Abenteurer angegriffen hat, ist bis zum Ende der nächsten KR gegen den Helden um 3 erschwert, allerdings erleidet der Held eine Erschwernis von 1 Punkt, sofern er ein Kampfmanöver einsetzt.",
          );
        } else if (6 <= w20 && w20 <= 10) {
          return (
            "Große Verteidigungslücke",
            "Die Verteidigung des Gegners, der den Abenteurer angegriffen hat, ist bis zum Ende der nächsten KR gegen den Helden um 3 erschwert.",
          );
        } else if (11 <= w20 && w20 <= 15) {
          return (
            "Große Verteidigungslücke",
            "Die Verteidigung des Gegners, der den Abenteurer angegriffen hat, ist bis zum Ende der nächsten KR gegen den Helden um 3 erschwert. Außerdem kann der Held bis zum Ende der nächsten KR einmalig eine Erschwernis von 1 Punkt ignorieren, wenn er ein Manöver einsetzt.",
          );
        } else if (16 <= w20 && w20 <= 20) {
          return (
            "Große Verteidigungslücke",
            "Die Verteidigung des Gegners, der den Abenteurer angegriffen hat, ist bis zum Ende der nächsten KR gegen den Helden um 3 erschwert. Außerdem kann der Held bis zum Ende der nächsten KR einmalig eine Erschwernis von bis zu 2 Punkten ignorieren, wenn er ein Manöver einsetzt.",
          );
        } else {
          assert(false, "unreachable!");
          return ("This should not occur!", "This should not occur!");
        }

      case CriticalDefenseRanged.kleineVerteidigungsluecke:
        if (1 <= w20 && w20 <= 3) {
          return (
            "Kleine Verteidigungslücke",
            "Die Verteidigung des Gegners, der den Abenteurer angegriffen hat, ist bis zum Ende der nächsten KR gegen den Helden um 1 erschwert.",
          );
        } else if (4 <= w20 && w20 <= 6) {
          return (
            "Kleine Verteidigungslücke",
            "Die Verteidigung des Gegners, der den Abenteurer angegriffen hat, ist bis zum Ende der nächsten KR gegen den Helden um 2 erschwert, allerdings erleidet der Held eine Erschwernis von 1 Punkt, sofern er ein Kampfmanöver einsetzt.",
          );
        } else if (7 <= w20 && w20 <= 9) {
          return (
            "Kleine Verteidigungslücke",
            "Die Verteidigung des Gegners, der den Abenteurer angegriffen hat, ist bis zum Ende der nächsten KR gegen den Helden um 2 erschwert.",
          );
        } else if (10 <= w20 && w20 <= 12) {
          return (
            "Kleine Verteidigungslücke",
            "Die Verteidigung des Gegners, der den Abenteurer angegriffen hat, ist bis zum Ende der nächsten KR gegen den Helden um 2 erschwert. Außerdem kann der Held bis zum Ende der nächsten KR einmalig eine Erschwernis von 1 Punkt ignorieren, wenn er ein Manöver einsetzt.",
          );
        } else if (13 <= w20 && w20 <= 15) {
          return (
            "Kleine Verteidigungslücke",
            "Die Verteidigung des Gegners, der den Abenteurer angegriffen hat, ist bis zum Ende der nächsten KR gegen den Helden um 2 erschwert. Außerdem kann der Held bis zum Ende der nächsten KR einmalig eine Erschwernis von bis zu 2 Punkten ignorieren, wenn er ein Manöver einsetzt.",
          );
        } else if (16 <= w20 && w20 <= 18) {
          return (
            "Kleine Verteidigungslücke",
            "Die Verteidigung des Gegners, der den Abenteurer angegriffen hat, ist bis zum Ende der nächsten KR gegen den Helden um 2 erschwert. Außerdem kann der Held bis zum Ende der nächsten KR einmalig eine Erschwernis von bis zu 3 Punkten ignorieren, wenn er ein Manöver einsetzt.",
          );
        } else if (19 <= w20 && w20 <= 20) {
          return ("Kleine Verteidigungslücke", "nochmal würfeln");
        } else {
          assert(false, "unreachable!");
          return ("This should not occur!", "This should not occur!");
        }

      case CriticalDefenseRanged.angriffssituation:
        if (1 <= w20 && w20 <= 2) {
          return (
            "Angriffssituation",
            "Der Held bekommt bis zum Ende der nächsten KR einen Bonus von +1 AT und +1 FK, allerdings nur sofern er keine Basis- oder Spezialmanöver einsetzt.",
          );
        } else if (3 <= w20 && w20 <= 4) {
          return (
            "Angriffssituation",
            "Der Held bekommt bis zum Ende der nächsten KR einen Bonus von +1 AT und +1 FK, allerdings nur sofern er keine Spezialmanöver einsetzt.",
          );
        } else if (5 <= w20 && w20 <= 6) {
          return (
            "Angriffssituation",
            "Der Held bekommt bis zum Ende der nächsten KR einen Bonus von +1 AT und +1 FK.",
          );
        } else if (7 <= w20 && w20 <= 8) {
          return (
            "Angriffssituation",
            "Der Held bekommt bis zum Ende der nächsten KR einen Bonus von +1 AT und +1 FK. Darüber hinaus sind Basismanöver im selben Zeitraum zusätzlich um 1 erleichtert.",
          );
        } else if (9 <= w20 && w20 <= 10) {
          return (
            "Angriffssituation",
            "Der Held bekommt bis zum Ende der nächsten KR einen Bonus von +1 AT und +1 FK. Darüber hinaus sind Basis- und Spezialmanöver im selben Zeitraum zusätzlich um 1 erleichtert.",
          );
        } else if (11 <= w20 && w20 <= 12) {
          return (
            "Angriffssituation",
            "Der Held bekommt bis zum Ende der nächsten KR einen Bonus von +2 AT und +2 FK. Darüber hinaus sind Basis- und Spezialmanöver im selben Zeitraum zusätzlich um 2 erleichtert.",
          );
        } else if (13 <= w20 && w20 <= 14) {
          return (
            "Angriffssituation",
            "Der Held bekommt bis zum Ende der nächsten KR einen Bonus von +2 AT und +2 FK. Darüber hinaus sind Basis- und Spezialmanöver im selben Zeitraum zusätzlich um 3 erleichtert.",
          );
        } else if (15 <= w20 && w20 <= 20) {
          return ("Angriffssituation", "nochmal würfeln");
        } else {
          assert(false, "unreachable!");
          return ("This should not occur!", "This should not occur!");
        }

      case CriticalDefenseRanged.verteidigungsvorteil:
        if (1 <= w20 && w20 <= 2) {
          return (
            "Verteidigungsvorteil",
            "Der Verteidigungswert sinkt nicht um 3 wie üblich bei der nächsten Verteidigung in dieser Kampfrunde, sondern nur um 2, allerdings sind alle darauf folgenden Aktionen bis zum Ende der nächsten KR um 1 erschwert, sofern der Held von dem Vorteil profitiert.",
          );
        } else if (3 <= w20 && w20 <= 4) {
          return (
            "Verteidigungsvorteil",
            "Der Verteidigungswert sinkt nicht um 3 wie üblich bei der nächsten Verteidigung in dieser Kampfrunde, sondern nur um 2.",
          );
        } else if (5 <= w20 && w20 <= 6) {
          return (
            "Verteidigungsvorteil",
            "Der Verteidigungswert sinkt nicht um 3 wie üblich bei der nächsten Verteidigung in dieser Kampfrunde, sondern nur um 1, allerdings sind alle darauf folgenden Aktionen bis zum Ende der nächsten KR um 1 erschwert, sofern der Held von dem Vorteil profitiert.",
          );
        } else if (7 <= w20 && w20 <= 8) {
          return (
            "Verteidigungsvorteil",
            "Der Verteidigungswert sinkt nicht um 3 wie üblich bei der nächsten Verteidigung in dieser Kampfrunde, sondern nur um 1.",
          );
        } else if (9 <= w20 && w20 <= 10) {
          return (
            "Verteidigungsvorteil",
            "Der Verteidigungswert sinkt nicht um 3 wie üblich bei der nächsten Verteidigung in dieser Kampfrunde.",
          );
        } else if (11 <= w20 && w20 <= 12) {
          return (
            "Verteidigungsvorteil",
            "Der Verteidigungswert sinkt nicht um 3 wie üblich bei der nächsten Verteidigung in dieser Kampfrunde. Darüber hinaus sind alle Angriffe gegen den Helden bis zum Ende der nächsten KR um 1 zusätzlich erschwert.",
          );
        } else if (13 <= w20 && w20 <= 14) {
          return (
            "Verteidigungsvorteil",
            "Der Verteidigungswert sinkt nicht um 3 wie üblich bei der nächsten Verteidigung in dieser Kampfrunde. Darüber hinaus sind alle Angriffe gegen den Helden bis zum Ende der nächsten KR um 2 zusätzlich erschwert.",
          );
        } else if (15 <= w20 && w20 <= 16) {
          return (
            "Verteidigungsvorteil",
            "Der Verteidigungswert sinkt nicht um 3 wie üblich bei der nächsten Verteidigung in dieser Kampfrunde. Darüber hinaus sind alle Angriffe gegen den Helden bis zum Ende der nächsten KR um 2 zusätzlich erschwert und es können im selbem Zeitraum keine Manöver gegen ihn eingesetzt werden.",
          );
        } else if (17 <= w20 && w20 <= 20) {
          return ("Verteidigungsvorteil", "nochmal würfeln");
        } else {
          assert(false, "unreachable!");
          return ("This should not occur!", "This should not occur!");
        }

      case CriticalDefenseRanged.verteidigungssituation:
        if (1 <= w20 && w20 <= 2) {
          return (
            "Verteidigungssituation",
            "Der Held bekommt bis zum Ende der nächsten KR einen Bonus von +1 VW, allerdings sind Kampfmanöver, sofern er welche einsetzt, bis zum Ende der nächsten KR um –2 erschwert.",
          );
        } else if (3 <= w20 && w20 <= 4) {
          return (
            "Verteidigungssituation",
            "Der Held bekommt bis zum Ende der nächsten KR einen Bonus von +1 VW, allerdings sind Kampfmanöver, sofern er welche einsetzt, bis zum Ende der nächsten KR um –1 erschwert.",
          );
        } else if (5 <= w20 && w20 <= 6) {
          return (
            "Verteidigungssituation",
            "Der Held bekommt bis zum Ende der nächsten KR einen Bonus von +1 VW.",
          );
        } else if (7 <= w20 && w20 <= 8) {
          return (
            "Verteidigungssituation",
            "Der Held bekommt bis zum Ende der nächsten KR einen Bonus von +1 VW, Setzt er bei seiner Verteidigung ein Manöver ein, erhält er einen zusätzlichen Bonus von +1 VW (also insgesamt +2 VW).",
          );
        } else if (9 <= w20 && w20 <= 10) {
          return (
            "Verteidigungssituation",
            "Der Held bekommt bis zum Ende der nächsten KR einen Bonus von +2 VW. Setzt er bei seiner Verteidigung ein Manöver ein, erhält er einen zusätzlichen Bonus von +1 VW (also insgesamt +3 VW).",
          );
        } else if (11 <= w20 && w20 <= 12) {
          return (
            "Verteidigungssituation",
            "Der Held bekommt bis zum Ende der nächsten KR einen Bonus von +2 VW, Setzt er bei seiner Verteidigung ein Manöver ein, erhält er einen zusätzlichen Bonus von +2 VW (also insgesamt +4 VW).",
          );
        } else if (13 <= w20 && w20 <= 14) {
          return (
            "Verteidigungssituation",
            "Der Held bekommt bis zum Ende der nächsten KR einen Bonus von +3 VW, Setzt er bei seiner Verteidigung ein Manöver ein, erhält er einen zusätzlichen Bonus von +2 VW (also insgesamt +5 VW).",
          );
        } else if (15 <= w20 && w20 <= 20) {
          return ("Verteidigungssituation", "nochmal würfeln");
        } else {
          assert(false, "unreachable!");
          return ("This should not occur!", "This should not occur!");
        }

      case CriticalDefenseRanged.guteAngriffsposition:
        if (1 <= w20 && w20 <= 3) {
          return (
            "Gute Angriffsposition",
            "Der Held bekommt bis zum Ende der nächsten KR einen Bonus von +2 AT und +2 FK allerdings nur sofern er keine Basis- oder Spezialmanöver einsetzt.",
          );
        } else if (4 <= w20 && w20 <= 6) {
          return (
            "Gute Angriffsposition",
            "Der Held bekommt bis zum Ende der nächsten KR einen Bonus von +2 AT und +2 FK, allerdings nur sofern er keine Spezialmanöver einsetzt.",
          );
        } else if (7 <= w20 && w20 <= 9) {
          return (
            "Gute Angriffsposition",
            "Der Held bekommt bis zum Ende der nächsten KR einen Bonus von +2 AT und +2 FK.",
          );
        } else if (10 <= w20 && w20 <= 12) {
          return (
            "Gute Angriffsposition",
            "Der Held bekommt bis zum Ende der nächsten KR einen Bonus von +2 AT und +2 FK. Darüber hinaus sind Basismanöver im selben Zeitraum zusätzlich um 1 erleichtert.",
          );
        } else if (13 <= w20 && w20 <= 15) {
          return (
            "Gute Angriffsposition",
            "Der Held bekommt bis zum Ende der nächsten KR einen Bonus von +2 AT und +2 FK. Darüber hinaus sind Basis- und Spezialmanöver im selben Zeitraum zusätzlich um 1 erleichtert.",
          );
        } else if (16 <= w20 && w20 <= 18) {
          return (
            "Gute Angriffsposition",
            "Der Held bekommt bis zum Ende der nächsten KR einen Bonus von +2 AT und +2 FK. Darüber hinaus sind Basis- und Spezialmanöver im selben Zeitraum zusätzlich um 2 erleichtert.",
          );
        } else if (19 <= w20 && w20 <= 20) {
          return ("Gute Angriffsposition", "nochmal würfeln");
        } else {
          assert(false, "unreachable!");
          return ("This should not occur!", "This should not occur!");
        }

      case CriticalDefenseRanged.herausragendeKampfsituation:
        if (1 <= w20 && w20 <= 5) {
          return (
            "Herausragende Kampfsituation",
            "Der Held bekommt bis zum Ende der nächsten KR einen Bonus von +2 AT, +2 FK und +1 VW, allerdings nur sofern er keine Basis- oder Spezialmanöver einsetzt.",
          );
        } else if (6 <= w20 && w20 <= 10) {
          return (
            "Herausragende Kampfsituation",
            "Der Held bekommt bis zum Ende der nächsten KR einen Bonus von +2 AT, +2 FK und +1 VW.",
          );
        } else if (11 <= w20 && w20 <= 15) {
          return (
            "Herausragende Kampfsituation",
            "Der Held bekommt bis zum Ende der nächsten KR einen Bonus von +2 AT, +2 FK und +1 VW. Darüber hinaus sind Basis- und Spezialmanöver im selben Zeitraum zusätzlich um 1 erleichtert.",
          );
        } else if (16 <= w20 && w20 <= 20) {
          return (
            "Herausragende Kampfsituation",
            "Der Held bekommt bis zum Ende der nächsten KR einen Bonus von +2 AT, +2 FK und +1 VW. Darüber hinaus sind Basis- und Spezialmanöver im selben Zeitraum zusätzlich um 2 erleichtert.",
          );
        } else {
          assert(false, "unreachable!");
          return ("This should not occur!", "This should not occur!");
        }

      case CriticalDefenseRanged.bloesse:
        if (1 <= w20 && w20 <= 6) {
          return (
            "Blöße",
            "Bis zum Ende der nächsten KR sind alle Proben auf AT und FK, die gegen den Gegner gerichtet sind, um 1 erleichtert, gleich ob durch den Helden oder seine Gefährten, allerdings nur sofern keine Basis- oder Spezialmanöver eingesetzt werden.",
          );
        } else if (7 <= w20 && w20 <= 12) {
          return (
            "Blöße",
            "Bis zum Ende der nächsten KR sind alle Proben auf AT und FK, die gegen den Gegner gerichtet sind, um 1 erleichtert, gleich ob durch den Helden oder seine Gefährten.",
          );
        } else if (13 <= w20 && w20 <= 18) {
          return (
            "Blöße",
            "Bis zum Ende der nächsten KR sind alle Proben auf AT und FK, die gegen den Gegner gerichtet sind, um 1 erleichtert, gleich ob durch den Helden oder seine Gefährten. Darüber hinaus sind Basis- und Spezialmanöver im selben Zeitraum zusätzlich um 1 erleichtert.",
          );
        } else if (19 <= w20 && w20 <= 20) {
          return ("Blöße", "nochmal würfeln");
        } else {
          assert(false, "unreachable!");
          return ("This should not occur!", "This should not occur!");
        }

      case CriticalDefenseRanged.aufDemPraesentierteller:
        if (1 <= w20 && w20 <= 10) {
          return (
            "Auf dem Präsentierteller",
            "Bis zum Ende der nächsten KR sind Verteidigungen des Gegners um 1 erschwert, außerdem sind Basis- und Spezialmanöver gegen ihn um 1 erleichtert gleich ob durch den Helden oder seine Gefährten.",
          );
        } else if (11 <= w20 && w20 <= 20) {
          return (
            "Auf dem Präsentierteller",
            "Bis zum Ende der nächsten KR sind Verteidigungen des Gegners um 1 erschwert, außerdem sind alle Proben auf AT und FK gegen ihn um 1 erleichtert gleich ob durch den Helden oder seine Gefährten.",
          );
        } else {
          assert(false, "unreachable!");
          return ("This should not occur!", "This should not occur!");
        }
    }
  }
}

enum CriticalDefenseMelee implements RuleMixin {
  geschickterAngriff(
    "Geschickter Angriff",
    "Der Held verfügt bis zum Ende der nächsten KR über einen Bonus von +2 auf AT gegen seinen Gegner.",
  ),
  geschickteVerteidigung(
    "Geschickte Verteidigung",
    "Der Held verfügt bis zum Ende der nächsten KR über einen Bonus von +2 auf VW gegen seinen Gegner.",
  ),
  geschickteKampfbewegungen(
    "Geschickte Kampfbewegungen",
    "Bis zum Ende der nächsten KR darf der Gegner keine Manöver gegen den Helden einsetzen.",
  ),
  aeusserstGeschickteKampfbewegungen(
    "Äußerst geschickte Kampfbewegungen",
    "Bis zum Ende der nächsten KR darf der Gegner keine Angriffe (AT, FK) gegen den Helden ausführen.",
  ),
  vorteilhaftePosition(
    "Vorteilhafte Position",
    "Der Held befindet sich bis zum Ende der nächsten KR gegen seinen Gegner in einer Vorteilhaften Position.",
  ),
  passierschlag(
    "Passierschlag",
    "Der Held kann sofort einen Passierschlag gegen seinen Gegner ausführen.",
  ),
  geschickterPassierschlag(
    "Geschickter Passierschlag",
    "Der Held kann sofort einen Passierschlag gegen seinen Gegner ausführen. Abweichend von der eigentlichen Regel (siehe Regelwerk Seite 237) kann er dabei Basismanöver einsetzen.",
  ),
  machtvollerPassierschlag(
    "Machtvoller Passierschlag",
    "Der Held kann sofort einen Passierschlag gegen seinen Gegner ausführen, dieser ist zuzüglich zu allen anderen Modifikatoren um 2 erschwert. Bei Gelingen richtet dieser Treffer +3 TP an.",
  ),
  guenstigeAngriffsposition(
    "Günstige Angriffsposition",
    "Der Held kann sofort einen Passierschlag gegen seinen Gegner ausführen. Zudem verfügt der Held bis zum Ende der nächsten KR gegen seinen Gegner über einen Bonus von +1 auf AT.",
  ),
  guenstigeVerteidigungsposition(
    "Günstige Verteidigungsposition",
    "Der Kämpfer kann sofort einen Passierschlag gegen seinen Gegner ausführen. Zudem verfügt der Held bis zum Ende der nächsten KR gegen seinen Gegner über einen Bonus von +2 auf VW.",
  ),
  zweiPassierschlaege(
    "Zwei Passierschläge",
    "Der Held kann sofort einen Passierschlag gegen seinen Gegner ausführen. Dieser ist um 2 erleichtert. Danach kann er einen weiteren durchführen, der nicht modifiziert ist.",
  );

  @override
  final String title;
  @override
  final String effect;
  const CriticalDefenseMelee(this.title, this.effect);

  static CriticalDefenseMelee from(int twoW6) {
    switch (twoW6) {
      case 2:
        return CriticalDefenseMelee.geschickterAngriff;

      case 3:
        return CriticalDefenseMelee.geschickteVerteidigung;

      case 4:
        return CriticalDefenseMelee.geschickteKampfbewegungen;

      case 5:
        return CriticalDefenseMelee.aeusserstGeschickteKampfbewegungen;

      case 6:
        return CriticalDefenseMelee.vorteilhaftePosition;

      case 7:
        return CriticalDefenseMelee.passierschlag;

      case 8:
        return CriticalDefenseMelee.geschickterPassierschlag;

      case 9:
        return CriticalDefenseMelee.machtvollerPassierschlag;

      case 10:
        return CriticalDefenseMelee.guenstigeAngriffsposition;

      case 11:
        return CriticalDefenseMelee.guenstigeVerteidigungsposition;

      case 12:
        return CriticalDefenseMelee.zweiPassierschlaege;

      default:
        assert(false, "unreachable!");
        return CriticalDefenseMelee.geschickterAngriff;
    }
  }

  @override
  (String, String) normalRule() {
    return ("Kritischer Erfolg!", "Der Held erhält einen Passierschlag!");
  }

  @override
  (String, String) focusRule(int w20) {
    switch (this) {
      case CriticalDefenseMelee.geschickterAngriff:
        if (1 <= w20 && w20 <= 10) {
          return (
            "Geschickter Angriff",
            "Der Held verfügt bis zum Ende der nächsten KR über einen Bonus von +2 auf AT gegen seinen Gegner.",
          );
        } else if (11 <= w20 && w20 <= 20) {
          return (
            "Geschickter Angriff",
            "Wenn der Held bis zum Ende der nächsten KR ein Manöver im Nahkampf einsetzt, kann er einmalig eine Erschwernis von bis zu 2 Punkten ignorieren.",
          );
        } else {
          assert(false, "unreachable!");
          return ("This should not occur!", "This should not occur!");
        }

      case CriticalDefenseMelee.geschickteVerteidigung:
        if (1 <= w20 && w20 <= 6) {
          return (
            "Geschickte Verteidigung",
            "Der Held verfügt bis zum Ende der nächsten KR über einen Bonus von +1 auf VW gegen seinen Gegner.",
          );
        } else if (7 <= w20 && w20 <= 12) {
          return (
            "Geschickte Verteidigung",
            "Der Held verfügt bis zum Ende der nächsten KR über einen Bonus von +2 auf VW gegen seinen Gegner.",
          );
        } else if (13 <= w20 && w20 <= 18) {
          return (
            "Geschickte Verteidigung",
            "Der Held verfügt bis zum Ende der nächsten KR über einen Bonus von +3 auf VW gegen seinen Gegner.",
          );
        } else if (19 <= w20 && w20 <= 20) {
          return ("Geschickte Verteidigung", "nochmal würfeln");
        } else {
          assert(false, "unreachable!");
          return ("This should not occur!", "This should not occur!");
        }

      case CriticalDefenseMelee.geschickteKampfbewegungen:
        if (1 <= w20 && w20 <= 5) {
          return (
            "Geschickte Kampfbewegungen",
            "Bis zum Ende der nächsten KR sind Manöver gegen den Helden für den Gegner um 2 zusätzlich erschwert.",
          );
        } else if (6 <= w20 && w20 <= 10) {
          return (
            "Geschickte Kampfbewegungen",
            "Wenn der Gegner bis zum Ende der nächsten KR Manöver gegen den Helden einsetzt, ist die Verteidigung gegen diese um 4 Punkte erleichtert.",
          );
        } else if (11 <= w20 && w20 <= 15) {
          return (
            "Geschickte Kampfbewegungen",
            "Bis zum Ende der nächsten KR darf der Gegner keine Manöver gegen den Helden einsetzen.",
          );
        } else if (16 <= w20 && w20 <= 20) {
          return (
            "Geschickte Kampfbewegungen",
            "Bis zum Ende der nächsten KR darf der Gegner keine Spezialmanöver gegen den Helden einsetzen.",
          );
        } else {
          assert(false, "unreachable!");
          return ("This should not occur!", "This should not occur!");
        }

      case CriticalDefenseMelee.aeusserstGeschickteKampfbewegungen:
        if (1 <= w20 && w20 <= 3) {
          return (
            "Äußerst geschickte Kampfbewegungen",
            "Bis zum Ende der nächsten KR sind alle Angriffe (AT, FK) des Gegners gegen den Helden um 2 erschwert.",
          );
        } else if (4 <= w20 && w20 <= 6) {
          return (
            "Äußerst geschickte Kampfbewegungen",
            "Bis zum Ende der nächsten KR sind alle Angriffe (AT, FK) des Gegners gegen den Helden um 4 erschwert.",
          );
        } else if (7 <= w20 && w20 <= 9) {
          return (
            "Äußerst geschickte Kampfbewegungen",
            "Bis zum Ende der nächsten KR darf der Gegner keine Angriffe (AT, FK) gegen den Helden ausführen.",
          );
        } else if (10 <= w20 && w20 <= 12) {
          return (
            "Äußerst geschickte Kampfbewegungen",
            "Bis zum Ende der nächsten KR darf der Gegner keine Angriffe (AT, FK) gegen den Helden ausführen. Außerdem kann der Held in diesem Zeitraum einmalig eine Erschwernis von bis zu 1 Punkt ignorieren, wenn er ein Manöver im Nahkampf einsetzt.",
          );
        } else if (13 <= w20 && w20 <= 15) {
          return (
            "Äußerst geschickte Kampfbewegungen",
            "Bis zum Ende der nächsten KR darf der Gegner keine Angriffe (AT, FK) gegen den Helden ausführen. Außerdem kann der Held in diesem Zeitraum einmalig eine Erschwernis von bis zu 2 Punkten ignorieren, wenn er ein Manöver im Nahkampf einsetzt.",
          );
        } else if (16 <= w20 && w20 <= 18) {
          return (
            "Äußerst geschickte Kampfbewegungen",
            "Bis zum Ende der nächsten KR darf der Gegner keine Angriffe (AT, FK) gegen den Helden ausführen. Außerdem kann der Held in diesem Zeitraum einmalig eine Erschwernis von bis zu 3 Punkten ignorieren, wenn er ein Manöver im Nahkampf einsetzt.",
          );
        } else if (19 <= w20 && w20 <= 20) {
          return ("Äußerst geschickte Kampfbewegungen", "Nochmal würfeln");
        } else {
          assert(false, "unreachable!");
          return ("This should not occur!", "This should not occur!");
        }

      case CriticalDefenseMelee.vorteilhaftePosition:
        if (1 <= w20 && w20 <= 2) {
          return (
            "Vorteilhafte Position",
            "Der Held muss bis zum Ende der nächsten KR nur 1 freie Aktion aufwenden, um in Vorteilhafte Position zu gelangen. Er muss dazu keine Probe ablegen.",
          );
        } else if (3 <= w20 && w20 <= 4) {
          return (
            "Vorteilhafte Position",
            "Der Held muss bis zum Ende der nächsten KR nur 1 Aktion aufwenden, um in Vorteilhafte Position zu gelangen. Er muss dazu keine Probe ablegen.",
          );
        } else if (5 <= w20 && w20 <= 6) {
          return (
            "Vorteilhafte Position",
            "Der Held befindet sich bis zum Ende der nächsten KR gegen seinen Gegner in einer Vorteilhaften Position.",
          );
        } else if (7 <= w20 && w20 <= 8) {
          return (
            "Vorteilhafte Position",
            "Der Held befindet sich bis zum Ende der nächsten KR gegen seinen Gegner in einer Vorteilhaften Position. Außerdem kann der Held in diesem Zeitraum zusätzlich einmalig eine Erschwernis von bis zu 1 Punkt ignorieren, wenn er ein Manöver im Nahkampf einsetzt.",
          );
        } else if (9 <= w20 && w20 <= 10) {
          return (
            "Vorteilhafte Position",
            "Der Held befindet sich bis zum Ende der nächsten KR gegen seinen Gegner in einer Vorteilhaften Position. Außerdem kann der Held in diesem Zeitraum zusätzlich einmalig eine Erschwernis von bis zu 2 Punkten ignorieren, wenn er ein Manöver im Nahkampf einsetzt.",
          );
        } else if (11 <= w20 && w20 <= 12) {
          return (
            "Vorteilhafte Position",
            "Der Held befindet sich bis zum Ende der nächsten KR gegen seinen Gegner in einer Vorteilhaften Position. Außerdem erhält der Held in diesem Zeitraum zusätzlich noch einen Bonus von +1 auf AT und +1 auf VW.",
          );
        } else if (13 <= w20 && w20 <= 14) {
          return (
            "Vorteilhafte Position",
            "Der Held befindet sich bis zum Ende der nächsten KR gegen seinen Gegner in einer Vorteilhaften Position. Außerdem erhält der Held in diesem Zeitraum zusätzlich noch einen Bonus von +2 auf AT und +1 auf VW.",
          );
        } else if (15 <= w20 && w20 <= 20) {
          return ("Vorteilhafte Position", "nochmal würfeln");
        } else {
          assert(false, "unreachable!");
          return ("This should not occur!", "This should not occur!");
        }

      case CriticalDefenseMelee.passierschlag:
        if (1 <= w20 && w20 <= 2) {
          return (
            "Passierschlag",
            "Der Held kann sofort einen Passierschlag gegen seinen Gegner ausführen, dieser ist zuzüglich zu allen anderen Modifikatoren um 3 erschwert.",
          );
        } else if (3 <= w20 && w20 <= 4) {
          return (
            "Passierschlag",
            "Der Held kann sofort einen Passierschlag gegen seinen Gegner ausführen, dieser ist zuzüglich zu allen anderen Modifikatoren um 2 erschwert.",
          );
        } else if (5 <= w20 && w20 <= 6) {
          return (
            "Passierschlag",
            "Der Held kann sofort einen Passierschlag gegen seinen Gegner ausführen, dieser ist zuzüglich zu allen anderen Modifikatoren um 1 erschwert.",
          );
        } else if (7 <= w20 && w20 <= 8) {
          return (
            "Passierschlag",
            "Der Held kann sofort einen Passierschlag gegen seinen Gegner ausführen.",
          );
        } else if (9 <= w20 && w20 <= 10) {
          return (
            "Passierschlag",
            "Der Held kann sofort einen Passierschlag gegen seinen Gegner ausführen, dieser ist zuzüglich zu allen anderen Modifikatoren um 1 erleichtert. Wenn der Held den Passierschlag nutzt, ist seine AT danach bis zum Ende der nächsten KR um 1 erschwert.",
          );
        } else if (11 <= w20 && w20 <= 12) {
          return (
            "Passierschlag",
            "Der Held kann sofort einen Passierschlag gegen seinen Gegner ausführen, dieser ist zuzüglich zu allen anderen Modifikatoren um 1 erleichtert.",
          );
        } else if (13 <= w20 && w20 <= 14) {
          return (
            "Passierschlag",
            "Der Held kann sofort einen Passierschlag gegen seinen Gegner ausführen, dieser ist zuzüglich zu allen anderen Modifikatoren um 2 erleichtert. Wenn der Held den Passierschlag nutzt, ist seine AT danach bis zum Ende der nächsten KR um 1 erschwert.",
          );
        } else if (15 <= w20 && w20 <= 16) {
          return (
            "Passierschlag",
            "Der Held kann sofort einen Passierschlag gegen seinen Gegner ausführen, dieser ist zuzüglich zu allen anderen Modifikatoren um 2 erleichtert.",
          );
        } else if (17 <= w20 && w20 <= 20) {
          return ("Passierschlag", "nochmal würfeln");
        } else {
          assert(false, "unreachable!");
          return ("This should not occur!", "This should not occur!");
        }

      case CriticalDefenseMelee.geschickterPassierschlag:
        if (1 <= w20 && w20 <= 2) {
          return (
            "Geschickter Passierschlag",
            "Der Held kann sofort einen Passierschlag gegen seinen Gegner ausführen, dieser ist zuzüglich zu allen anderen Modifikatoren um 3 erschwert. Abweichend von der eigentlichen Regel (siehe Regelwerk Seite 237) kann er dabei Basismanöver einsetzen.",
          );
        } else if (3 <= w20 && w20 <= 4) {
          return (
            "Geschickter Passierschlag",
            "Der Held kann sofort einen Passierschlag gegen seinen Gegner ausführen, dieser ist zuzüglich zu allen anderen Modifikatoren um 2 erschwert. Abweichend von der eigentlichen Regel (siehe Regelwerk Seite 237) kann er dabei Basismanöver einsetzen.",
          );
        } else if (5 <= w20 && w20 <= 6) {
          return (
            "Geschickter Passierschlag",
            "Der Held kann sofort einen Passierschlag gegen seinen Gegner ausführen, dieser ist zuzüglich zu allen anderen Modifikatoren um 1 erschwert. Abweichend von der eigentlichen Regel (siehe Regelwerk Seite 237) kann er dabei Basismanöver einsetzen.",
          );
        } else if (7 <= w20 && w20 <= 8) {
          return (
            "Geschickter Passierschlag",
            "Der Held kann sofort einen Passierschlag gegen seinen Gegner ausführen. Abweichend von der eigentlichen Regel (siehe Regelwerk Seite 237) kann er dabei Basismanöver einsetzen.",
          );
        } else if (9 <= w20 && w20 <= 10) {
          return (
            "Geschickter Passierschlag",
            "Der Held kann sofort einen Passierschlag gegen seinen Gegner ausführen. Abweichend von der eigentlichen Regel (siehe Regelwerk Seite 237) kann er dabei sowohl Basis- als auch Spezialmanöver einsetzen.",
          );
        } else if (11 <= w20 && w20 <= 12) {
          return (
            "Geschickter Passierschlag",
            "Der Held kann sofort einen Passierschlag gegen seinen Gegner ausführen, dieser ist zuzüglich zu allen anderen Modifikatoren um 1 erleichtert. Abweichend von der eigentlichen Regel (siehe Regelwerk Seite 237) kann er dabei sowohl Basis- als auch Spezialmanöver einsetzen.",
          );
        } else if (13 <= w20 && w20 <= 14) {
          return (
            "Geschickter Passierschlag",
            "Der Held kann sofort einen Passierschlag gegen seinen Gegner ausführen, dieser ist zuzüglich zu allen anderen Modifikatoren um 2 erleichtert. Abweichend von der eigentlichen Regel (siehe Regelwerk Seite 237) kann er dabei sowohl Basis- als auch Spezialmanöver einsetzen.",
          );
        } else if (15 <= w20 && w20 <= 20) {
          return ("Geschickter Passierschlag", "nochmal würfeln");
        } else {
          assert(false, "unreachable!");
          return ("This should not occur!", "This should not occur!");
        }

      case CriticalDefenseMelee.machtvollerPassierschlag:
        if (1 <= w20 && w20 <= 3) {
          return (
            "Machtvoller Passierschlag",
            "Der Held kann sofort einen Passierschlag gegen seinen Gegner ausführen, dieser ist zuzüglich zu allen anderen Modifikatoren um 2 erschwert. Bei Gelingen richtet dieser Treffer +2 TP an.",
          );
        } else if (4 <= w20 && w20 <= 6) {
          return (
            "Machtvoller Passierschlag",
            "Der Held kann sofort einen Passierschlag gegen seinen Gegner ausführen, dieser ist zuzüglich zu allen anderen Modifikatoren um 2 erschwert. Bei Gelingen richtet dieser Treffer +2 TP an und der Gegner erhält bis zum Ende der nächsten KR 1 Stufe Betäubung.",
          );
        } else if (7 <= w20 && w20 <= 9) {
          return (
            "Machtvoller Passierschlag",
            "Der Held kann sofort einen Passierschlag gegen seinen Gegner ausführen, dieser ist zuzüglich zu allen anderen Modifikatoren um 2 erschwert. Bei Gelingen richtet dieser Treffer +3 TP an.",
          );
        } else if (10 <= w20 && w20 <= 12) {
          return (
            "Machtvoller Passierschlag",
            "Der Held kann sofort einen Passierschlag gegen seinen Gegner ausführen, dieser ist zuzüglich zu allen anderen Modifikatoren um 2 erschwert. Bei Gelingen richtet dieser Treffer +3 TP an und der Gegner erhält bis zum Ende der nächsten KR 1 Stufe Betäubung.",
          );
        } else if (13 <= w20 && w20 <= 15) {
          return (
            "Machtvoller Passierschlag",
            "Der Held kann sofort einen Passierschlag gegen seinen Gegner ausführen, dieser ist zuzüglich zu allen anderen Modifikatoren um 2 erschwert. Bei Gelingen richtet dieser Treffer +4 TP an.",
          );
        } else if (16 <= w20 && w20 <= 18) {
          return (
            "Machtvoller Passierschlag",
            "Der Held kann sofort einen Passierschlag gegen seinen Gegner ausführen, dieser ist zuzüglich zu allen anderen Modifikatoren um 2 erschwert. Bei Gelingen richtet dieser Treffer +4 TP an und der Gegner erhält bis zum Ende der nächsten KR 1 Stufe Betäubung.",
          );
        } else if (19 <= w20 && w20 <= 20) {
          return ("Machtvoller Passierschlag", "nochmal würfeln");
        } else {
          assert(false, "unreachable!");
          return ("This should not occur!", "This should not occur!");
        }

      case CriticalDefenseMelee.guenstigeAngriffsposition:
        if (1 <= w20 && w20 <= 5) {
          return (
            "Günstige Angriffsposition",
            "Der Held kann sofort einen Passierschlag gegen seinen Gegner ausführen. Wenn der Held bis zum Ende der nächsten KR ein Manöver im Nahkampf einsetzt, kann er einmalig eine Erschwernis von 1 Punkt ignorieren.",
          );
        } else if (6 <= w20 && w20 <= 10) {
          return (
            "Günstige Angriffsposition",
            "Der Held kann sofort einen Passierschlag gegen seinen Gegner ausführen. Zudem verfügt der Held bis zum Ende der nächsten KR gegen seinen Gegner über einen Bonus von +1 auf AT.",
          );
        } else if (11 <= w20 && w20 <= 15) {
          return (
            "Günstige Angriffsposition",
            "Der Held kann sofort einen Passierschlag gegen seinen Gegner ausführen. Wenn der Held bis zum Ende der nächsten KR ein Manöver im Nahkampf einsetzt, kann er einmalig eine Erschwernis von bis zu 2 Punkten ignorieren.",
          );
        } else if (16 <= w20 && w20 <= 20) {
          return (
            "Günstige Angriffsposition",
            "Der Held kann sofort einen Passierschlag gegen seinen Gegner ausführen. Zudem verfügt der Held bis zum Ende der nächsten KR gegen seinen Gegner über einen Bonus von +2 auf AT.",
          );
        } else {
          assert(false, "unreachable!");
          return ("This should not occur!", "This should not occur!");
        }

      case CriticalDefenseMelee.guenstigeVerteidigungsposition:
        if (1 <= w20 && w20 <= 6) {
          return (
            "Günstige Verteidigungsposition",
            "Der Kämpfer kann sofort einen Passierschlag gegen seinen Gegner ausführen. Zudem verfügt der Held bis zum Ende der nächsten KR gegen seinen Gegner über einen Bonus von +1 auf VW.",
          );
        } else if (7 <= w20 && w20 <= 12) {
          return (
            "Günstige Verteidigungsposition",
            "Der Kämpfer kann sofort einen Passierschlag gegen seinen Gegner ausführen. Zudem verfügt der Held bis zum Ende der nächsten KR gegen seinen Gegner über einen Bonus von +2 auf VW.",
          );
        } else if (13 <= w20 && w20 <= 18) {
          return (
            "Günstige Verteidigungsposition",
            "Der Kämpfer kann sofort einen Passierschlag gegen seinen Gegner ausführen. Zudem verfügt der Held bis zum Ende der nächsten KR gegen seinen Gegner über einen Bonus von +3 auf VW.",
          );
        } else if (19 <= w20 && w20 <= 20) {
          return ("Günstige Verteidigungsposition", "nochmal würfeln");
        } else {
          assert(false, "unreachable!");
          return ("This should not occur!", "This should not occur!");
        }

      case CriticalDefenseMelee.zweiPassierschlaege:
        if (1 <= w20 && w20 <= 10) {
          return (
            "Zwei Passierschläge",
            "Der Held kann sofort einen Passierschlag gegen seinen Gegner ausführen. Dieser ist zuzüglich zu allen anderen Modifikatoren um 2 erleichtert. Danach kann er einen weiteren durchführen, der nicht zuzüglich modifiziert ist.",
          );
        } else if (11 <= w20 && w20 <= 20) {
          return (
            "Zwei Passierschläge",
            "Der Held kann sofort einen Passierschlag gegen seinen Gegner ausführen. Dieser ist zuzüglich zu allen anderen Modifikatoren um 4 erleichtert. Danach kann er einen weiteren durchführen, der zuzüglich um 2 erschwert ist.",
          );
        } else {
          assert(false, "unreachable!");
          return ("This should not occur!", "This should not occur!");
        }
    }
  }
}

enum BotchedAttackMelee implements RuleMixin {
  waffeZerstoert(
    "Waffe zerstört",
    "Die Waffe ist unwiederbringlich zerstört. Bei unzerstörbaren Waffen ist die Waffe zu Boden gefallen.",
  ),
  waffeSchwerBeschaedigt(
    "Waffe schwer beschädigt",
    "Die Waffe ist nicht mehr verwendbar, bis sie repariert wird. Bei unzerstörbaren Waffen ist die Waffe zu Boden gefallen.",
  ),
  waffeBeschaedigt(
    "Waffe beschädigt",
    "Die Waffe ist beschädigt worden. Alle Proben auf Attacke und Parade sind um 2 erschwert, bis sie repariert wird. Bei unzerstörbaren Waffen ist die Waffe zu Boden gefallen.",
  ),
  waffeVerloren("Waffe verloren", "Die Waffe ist zu Boden gefallen."),
  waffeSteckenGeblieben(
    "Waffe stecken geblieben",
    "Die Waffe des Helden ist in einem Baum, einer Holzwand, dem Boden oder Ähnlichem stecken geblieben. Um sie zu befreien, ist 1 Aktion und eine um 1 erschwerte Probe auf Kraftakt (Ziehen & Zerren) notwendig.",
  ),
  sturz(
    "Sturz",
    "Der Held stolpert und stürzt, wenn seinem Spieler nicht eine um 2 erschwerte Probe auf Körperbeherrschung (Balance) gelingt. Sollte er das nicht schaffen, erhält der Held den Status Liegend.",
  ),
  stolpern(
    "Stolpern",
    "Der Held stolpert, seine nächste Handlung ist um 2 erschwert.",
  ),
  fussVerdreht(
    "Fuß verdreht",
    "Der Held erhält für 3 Kampfrunden eine Stufe Schmerz.",
  ),
  beule(
    "Beule",
    "Der Held hat sich im Eifer des Gefechts den Kopf gestoßen. Er erhält für eine Stunde eine Stufe Betäubung.",
  ),
  selbstVerletzt(
    "Selbst verletzt",
    "Der Held hat sich selbst verletzt und erleidet Schaden. Der Schaden seiner Waffe wird unter Einbeziehung des Schadensbonus ausgewürfelt. Bei unbewaffneten Kämpfern wird 1W6 TP angenommen.",
  ),
  selbstSchwerVerletzt(
    "Selbst schwer verletzt",
    "Ein schwerer Eigentreffer des Helden. Der Schaden seiner Waffe wird unter Einbeziehung des Schadensbonus ausgewürfelt und dann verdoppelt. Bei unbewaffneten Kämpfern wird 1W6 TP angenommen.",
  );

  @override
  final String title;
  @override
  final String effect;
  const BotchedAttackMelee(this.title, this.effect);

  static BotchedAttackMelee from(int twoW6) {
    switch (twoW6) {
      case 2:
        return BotchedAttackMelee.waffeZerstoert;

      case 3:
        return BotchedAttackMelee.waffeSchwerBeschaedigt;

      case 4:
        return BotchedAttackMelee.waffeBeschaedigt;

      case 5:
        return BotchedAttackMelee.waffeVerloren;

      case 6:
        return BotchedAttackMelee.waffeSteckenGeblieben;

      case 7:
        return BotchedAttackMelee.sturz;

      case 8:
        return BotchedAttackMelee.stolpern;

      case 9:
        return BotchedAttackMelee.fussVerdreht;

      case 10:
        return BotchedAttackMelee.beule;

      case 11:
        return BotchedAttackMelee.selbstVerletzt;

      case 12:
        return BotchedAttackMelee.selbstSchwerVerletzt;

      default:
        assert(false, "unreachable!");
        return BotchedAttackMelee.waffeZerstoert;
    }
  }

  @override
  (String, String) normalRule() {
    return ("Patzer beim Angriff!", "Der Held erhält 2W6 + 2 Schadenspunkte!");
  }

  @override
  (String, String) focusRule(int w20) {
    switch (this) {
      case BotchedAttackMelee.waffeZerstoert:
        if (1 <= w20 && w20 <= 10) {
          return (
            "Waffe zerstört",
            "Die Waffe kann nicht mehr repariert werden. Ihre Einzelteile treffen teilweise den Helden und verursachen 1W6 SP. Bei unzerstörbaren Waffen wird das Ergebnis wie Waffe verloren behandelt.",
          );
        } else if (11 <= w20 && w20 <= 20) {
          return (
            "Waffe zerstört",
            "Die Waffe ist zerbrochen. Die Probe, um sie zu reparieren ist um 3 erschwert, außerdem kostet die Reparatur 25 % des ursprünglichen Preises der Waffe. Bei unzerstörbaren Waffen wird das Ergebnis wie Waffe verloren behandelt.",
          );
        } else {
          assert(false, "unreachable!");
          return ("This should not occur!", "This should not occur!");
        }

      case BotchedAttackMelee.waffeSchwerBeschaedigt:
        if (1 <= w20 && w20 <= 6) {
          return (
            "Waffe schwer beschädigt",
            "Die Waffe ist nicht mehr verwendbar, bis sie repariert wird. Die Probe, um sie zu reparieren ist um 1 erschwert. Bei unzerstörbaren Waffen wird das Ergebnis wie Waffe verloren behandelt.",
          );
        } else if (7 <= w20 && w20 <= 12) {
          return (
            "Waffe schwer beschädigt",
            "Die Waffe ist nicht mehr verwendbar, bis sie repariert wird. Bei unzerstörbaren Waffen wird das Ergebnis wie Waffe verloren behandelt.",
          );
        } else if (13 <= w20 && w20 <= 18) {
          return (
            "Waffe schwer beschädigt",
            "Die Waffe ist zwar schwer beschädigt, aber noch einsetzbar. Alle Proben auf Attacke und Parade sind um 4 erschwert, bis sie repariert wird. Bei unzerstörbaren Waffen wird das Ergebnis wie Waffe verloren behandelt.",
          );
        } else if (19 <= w20 && w20 <= 20) {
          return ("Waffe schwer beschädigt", "nochmal würfeln");
        } else {
          assert(false, "unreachable!");
          return ("This should not occur!", "This should not occur!");
        }

      case BotchedAttackMelee.waffeBeschaedigt:
        if (1 <= w20 && w20 <= 5) {
          return (
            "Waffe beschädigt",
            "Die Waffe hat einen Kratzer abbekommen, aber dies hat keine regeltechnischen Auswirkungen. Bei unzerstörbaren Waffen wird das Ergebnis wie Waffe verloren behandelt.",
          );
        } else if (6 <= w20 && w20 <= 10) {
          return (
            "Waffe beschädigt",
            "Die Waffe wurde beschädigt. Alle Proben auf Attacke und Parade sind um 1 erschwert, bis sie repariert wird. Bei unzerstörbaren Waffen wird das Ergebnis wie Waffe verloren behandelt.",
          );
        } else if (11 <= w20 && w20 <= 15) {
          return (
            "Waffe beschädigt",
            "Die Waffe wurde beschädigt. Alle Proben auf Attacke und Parade sind um 2 erschwert, bis sie repariert wird. Bei unzerstörbaren Waffen wird das Ergebnis wie Waffe verloren behandelt.",
          );
        } else if (16 <= w20 && w20 <= 20) {
          return (
            "Waffe beschädigt",
            "Die Waffe wurde beschädigt. Alle Proben auf Attacke und Parade sind um 3 erschwert, bis sie repariert wird. Bei unzerstörbaren Waffen wird das Ergebnis wie Waffe verloren behandelt.",
          );
        } else {
          assert(false, "unreachable!");
          return ("This should not occur!", "This should not occur!");
        }

      case BotchedAttackMelee.waffeVerloren:
        if (1 <= w20 && w20 <= 3) {
          return (
            "Waffe verloren",
            "Die Waffe ist auf den Boden gefallen und muss nach den üblichen Regeln wieder aufgehoben werden (siehe Regelwerk Seite 239). Allerdings kann der Gegner dabei einen Passierschlag ausführen.",
          );
        } else if (4 <= w20 && w20 <= 6) {
          return (
            "Waffe verloren",
            "Die Waffe ist auf den Boden gefallen und muss nach den üblichen Regeln wieder aufgehoben werden (siehe Regelwerk Seite 239). Allerdings liegt sie 1W6+2 Schritt weit weg, sodass zusätzlich noch eine Bewegung ausgeführt werden muss, um sie zu erreichen.",
          );
        } else if (7 <= w20 && w20 <= 9) {
          return (
            "Waffe verloren",
            "Die Waffe ist auf den Boden gefallen und muss nach den üblichen Regeln wieder aufgehoben werden (siehe Regelwerk Seite 239). Allerdings ist die Probe um 2 erschwert.",
          );
        } else if (10 <= w20 && w20 <= 12) {
          return (
            "Waffe verloren",
            "Die Waffe ist auf den Boden gefallen und muss nach den üblichen Regeln wieder aufgehoben werden (siehe Regelwerk Seite 239).",
          );
        } else if (13 <= w20 && w20 <= 15) {
          return (
            "Waffe verloren",
            "Die Waffe ist auf den Boden gefallen, hat aber vorher einen vom Meister bestimmten Gefährten des Helden oder einen Unschuldigen fast getroffen, sodass dieser bis zum Ende der nächsten KR –3 auf VW aufweist. Ist niemand in der Nähe, erleidet der Held bis zum Ende der nächsten KR eine Erschwernis von 3 auf AT.",
          );
        } else if (16 <= w20 && w20 <= 18) {
          return (
            "Waffe verloren",
            "Die Waffe ist zwar auf den Boden gefallen und muss nach den üblichen Regeln wieder aufgehoben werden (siehe Regelwerk Seite 239), allerdings ist die Probe um 2 erleichtert.",
          );
        } else if (19 <= w20 && w20 <= 20) {
          return ("Waffe verloren", "nochmal würfeln.");
        } else {
          assert(false, "unreachable!");
          return ("This should not occur!", "This should not occur!");
        }

      case BotchedAttackMelee.waffeSteckenGeblieben:
        if (1 <= w20 && w20 <= 2) {
          return (
            "Waffe stecken geblieben",
            "Die Waffe fliegt dem Helden aus der Hand und trifft einen Gefährten oder einen Unschuldigen. Dieser kann versuchen, sich mit einer Schilde-PA zu verteidigen oder ausweichen. Bei Misslingen erleidet er den vollen Waffenschaden. Alle eingesetzten Manöver werden dabei berücksichtigt. Der Held kann seine Waffe nach den üblichen Regeln wiedererlangen (siehe Regelwerk Seite 239). Ist niemand in der Nähe, erleidet der Held bis zum Ende der nächsten KR eine Erschwernis von 3 auf AT.",
          );
        } else if (3 <= w20 && w20 <= 4) {
          return (
            "Waffe stecken geblieben",
            "Die Waffe des Helden ist in einem Baum, einer Holzwand, dem Boden oder Ähnlichem stecken geblieben. Um sie zu befreien, ist 1 Aktion und eine Probe auf Kraftakt (Ziehen & Zerren) notwendig.",
          );
        } else if (5 <= w20 && w20 <= 6) {
          return (
            "Waffe stecken geblieben",
            "Die Waffe des Helden ist in einem Baum, einer Holzwand, dem Boden oder Ähnlichem stecken geblieben. Um sie zu befreien, ist 1 Aktion und eine um 1 erschwerte Probe auf Kraftakt (Ziehen & Zerren) notwendig.",
          );
        } else if (7 <= w20 && w20 <= 8) {
          return (
            "Waffe stecken geblieben",
            "Die Waffe des Helden ist in einem Baum, einer Holzwand, dem Boden oder Ähnlichem stecken geblieben. Um sie zu befreien, ist 1 Aktion und eine um 2 erschwerte Probe auf Kraftakt (Ziehen & Zerren) notwendig.",
          );
        } else if (9 <= w20 && w20 <= 10) {
          return (
            "Waffe stecken geblieben",
            "Die Waffe des Helden ist in einem Baum, einer Holzwand, dem Boden oder Ähnlichem stecken geblieben. Um sie zu befreien, sind 5 Aktionen und eine um 2 erschwerte Probe auf Kraftakt (Ziehen & Zerren) notwendig.",
          );
        } else if (11 <= w20 && w20 <= 12) {
          return (
            "Waffe stecken geblieben",
            "Die Waffe des Helden ist in einem Baum, einer Holzwand, dem Boden oder Ähnlichem stecken geblieben. Um sie zu befreien, sind 1 Aktion und eine um 2 erschwerte Probe auf Kraftakt (Ziehen & Zerren) notwendig. Nach dem Befreien hat sie aber einen kleinen Schaden, der für eine Erschwernis von 1 auf AT und PA sorgt. Nach dem Kampf kann dieser Schaden behoben werden ohne dass eine Probe notwendig ist.",
          );
        } else if (13 <= w20 && w20 <= 14) {
          return (
            "Waffe stecken geblieben",
            "Die Waffe des Helden schwingt gegen einen Gefährten oder Unschuldigen. Dieser kann sofort eine VW einsetzen, um dem Treffer zu entgehen. Bei Misslingen erleidet er den vollen Waffenschaden. Alle eingesetzten Manöver werden dabei berücksichtigt. Ist niemand in der Nähe, erleidet der Held bis zum Ende der nächsten KR eine Erschwernis von 3 auf AT.",
          );
        } else if (15 <= w20 && w20 <= 20) {
          return ("Waffe stecken geblieben", "nochmal würfeln");
        } else {
          assert(false, "unreachable!");
          return ("This should not occur!", "This should not occur!");
        }

      case BotchedAttackMelee.sturz:
        if (1 <= w20 && w20 <= 2) {
          return (
            "Sturz",
            "Der Held erleidet den Zustand Liegend und zieht bis 1W3 seiner Gefährten, die zufällig bestimmt werden, ebenfalls zu Boden, sofern ihnen nicht eine Probe auf Körperbeherrschung (Balance) –2 gelingt. Sie erleiden ansonsten den Status Liegend. Sollten keine Gefährten in der unmittelbaren Nähe sein, erleidet der Held 1 Stufe Schmerz für 5 Minuten.",
          );
        } else if (3 <= w20 && w20 <= 4) {
          return (
            "Sturz",
            "Der Held stolpert und stürzt, wenn seinem Spieler nicht eine um 3 erschwerte Probe auf Körperbeherrschung (Balance) gelingt. Sollte er das nicht schaffen, erhält der Held den Status Liegend, erleidet 1W6+2 SP und für 3 KR 1 Stufe Betäubung.",
          );
        } else if (5 <= w20 && w20 <= 6) {
          return (
            "Sturz",
            "Der Held stolpert und stürzt, wenn seinem Spieler nicht eine um 3 erschwerte Probe auf Körperbeherrschung (Balance) gelingt. Sollte er das nicht schaffen, erhält der Held den Status Liegend und verletzte sich beim Sturz mit 1W6+2 SP.",
          );
        } else if (7 <= w20 && w20 <= 8) {
          return (
            "Sturz",
            "Der Held stolpert und stürzt, wenn seinem Spieler nicht eine um 2 erschwerte Probe auf Körperbeherrschung (Balance) gelingt. Sollte er das nicht schaffen, erhält der Held den Status Liegend und verletzte sich beim Sturz mit 1W6 SP.",
          );
        } else if (9 <= w20 && w20 <= 10) {
          return (
            "Sturz",
            "Der Held stolpert und stürzt, wenn seinem Spieler nicht eine um 2 erschwerte Probe auf Körperbeherrschung (Balance) gelingt. Sollte er das nicht schaffen, erhält der Held den Status Liegend.",
          );
        } else if (11 <= w20 && w20 <= 12) {
          return (
            "Sturz",
            "Der Held stolpert und stürzt, wenn seinem Spieler nicht eine um 1 erschwerte Probe auf Körperbeherrschung (Balance) gelingt. Sollte er das nicht schaffen, erhält der Held den Status Liegend.",
          );
        } else if (13 <= w20 && w20 <= 14) {
          return (
            "Sturz",
            "Der Held stolpert und stürzt, wenn seinem Spieler nicht eine Probe auf Körperbeherrschung (Balance) gelingt. Sollte er das nicht schaffen, erhält der Held den Status Liegend.",
          );
        } else if (15 <= w20 && w20 <= 16) {
          return (
            "Sturz",
            "Der Held stolpert und stürzt, wenn seinem Spieler nicht eine erleichterte Probe auf Körperbeherrschung (Balance) +1 gelingt. Sollte er das nicht schaffen, erhält der Held den Status Liegend.",
          );
        } else if (17 <= w20 && w20 <= 20) {
          return ("Sturz", "nochmal würfeln");
        } else {
          assert(false, "unreachable!");
          return ("This should not occur!", "This should not occur!");
        }

      case BotchedAttackMelee.stolpern:
        if (1 <= w20 && w20 <= 2) {
          return (
            "Stolpern",
            "Der Held stolpert in die Waffe des Gegners und erleidet den vollen Waffenschaden, zudem ist seine nächste Handlung um 2 erschwert.",
          );
        } else if (3 <= w20 && w20 <= 4) {
          return (
            "Stolpern",
            "Der Held stolpert, seine nächste Handlung ist um 3 erschwert.",
          );
        } else if (5 <= w20 && w20 <= 6) {
          return (
            "Stolpern",
            "Der Held verliert einen Gegenstand (außer seine Waffe), seine Hose rutscht herunter, oder er hängt irgendwo fest. Bis zum Ende der nächsten KR hat er eine Erschwernis von 2 auf alle Handlungen und er erleidet den Status Eingeengt und Fixiert.",
          );
        } else if (7 <= w20 && w20 <= 8) {
          return (
            "Stolpern",
            "Der Held stolpert, seine nächste Handlung ist um 2 erschwert.",
          );
        } else if (9 <= w20 && w20 <= 10) {
          return (
            "Stolpern",
            "Der Held stolpert, sodass bis zum Ende der nächsten KR alle Gegner gegen ihn einen Bonus von 2 auf AT erhalten. Der Abenteurer bekommt aber keine Erschwernis für seine nächste Handlung.",
          );
        } else if (11 <= w20 && w20 <= 12) {
          return (
            "Stolpern",
            "Der Held stolpert, seine nächste Handlung ist um 1 erschwert.",
          );
        } else if (13 <= w20 && w20 <= 14) {
          return (
            "Stolpern",
            "Der Held stolpert, sodass bis zum Ende der nächsten KR alle Gegner gegen ihn einen Bonus von 1 auf AT erhalten. Der Abenteurer bekommt aber keine Erschwernis für seine nächste Handlung.",
          );
        } else if (15 <= w20 && w20 <= 20) {
          return ("Stolpern", "nochmal würfeln.");
        } else {
          assert(false, "unreachable!");
          return ("This should not occur!", "This should not occur!");
        }

      case BotchedAttackMelee.fussVerdreht:
        if (1 <= w20 && w20 <= 3) {
          return ("Fuß verdreht", "Der Held erhält für 3 KR 2 Stufen Schmerz.");
        } else if (4 <= w20 && w20 <= 6) {
          return ("Fuß verdreht", "Der Held erhält für 5 KR 1 Stufe Schmerz.");
        } else if (7 <= w20 && w20 <= 9) {
          return ("Fuß verdreht", "Der Held erhält für 3 KR 1 Stufe Schmerz.");
        } else if (10 <= w20 && w20 <= 12) {
          return (
            "Fuß verdreht",
            "Der Held erleidet +2 TP, dafür aber keine Stufe Schmerz.",
          );
        } else if (13 <= w20 && w20 <= 15) {
          return ("Fuß verdreht", "Der Held erhält für 1 KR 1 Stufe Schmerz.");
        } else if (16 <= w20 && w20 <= 18) {
          return (
            "Fuß verdreht",
            "Der Held erleidet +1 TP, dafür aber keine Stufe Schmerz.",
          );
        } else if (19 <= w20 && w20 <= 20) {
          return ("Fuß verdreht", "nochmal würfeln.");
        } else {
          assert(false, "unreachable!");
          return ("This should not occur!", "This should not occur!");
        }

      case BotchedAttackMelee.beule:
        if (1 <= w20 && w20 <= 5) {
          return (
            "Beule",
            "Der Held bekommt 2 Stufen Betäubung für 1 Stunde (statt 1 Stufe).",
          );
        } else if (6 <= w20 && w20 <= 10) {
          return (
            "Beule",
            "Der Held bekommt 1 Stufe Betäubung und den Status Blutend.",
          );
        } else if (11 <= w20 && w20 <= 15) {
          return ("Beule", "Der Held bekommt 1 Stufe Betäubung für 1 Stunde.");
        } else if (16 <= w20 && w20 <= 20) {
          return ("Beule", "Der Held bekommt 1 Stufe Betäubung für 2 KR.");
        } else {
          assert(false, "unreachable!");
          return ("This should not occur!", "This should not occur!");
        }

      case BotchedAttackMelee.selbstVerletzt:
        if (1 <= w20 && w20 <= 6) {
          return (
            "Selbst verletzt",
            "Der Held hat sich selbst verletzt und erleidet Schaden. Der Schaden seiner Waffe wird unter Einbeziehung des Schadensbonus ausgewürfelt und dann halbiert. Bei unbewaffneten Kämpfern wird 1W6 TP angenommen.",
          );
        } else if (7 <= w20 && w20 <= 12) {
          return (
            "Selbst verletzt",
            "Der Held hat sich selbst verletzt und erleidet Schaden. Der Schaden seiner Waffe wird unter Einbeziehung des Schadensbonus ausgewürfelt. Bei unbewaffneten Kämpfern wird 1W6 TP angenommen.",
          );
        } else if (13 <= w20 && w20 <= 18) {
          return (
            "Selbst verletzt",
            "Der Held hat sich selbst verletzt und erleidet Schaden. Der Schaden seiner Waffe wird unter Einbeziehung des Schadensbonus ausgewürfelt. Bei unbewaffneten Kämpfern wird 1W6 TP angenommen. Zudem erleidet der Held den Status Blutend.",
          );
        } else if (19 <= w20 && w20 <= 20) {
          return ("Selbst verletzt", "nochmal würfeln.");
        } else {
          assert(false, "unreachable!");
          return ("This should not occur!", "This should not occur!");
        }

      case BotchedAttackMelee.selbstSchwerVerletzt:
        if (1 <= w20 && w20 <= 10) {
          return (
            "Selbst schwer verletzt",
            "Ein schwerer Eigentreffer des Helden. Der Schaden seiner Waffe wird unter Einbeziehung des Schadensbonus ausgewürfelt und dann verdoppelt. Bei unbewaffneten Kämpfern wird 1W6 TP angenommen. Zudem erleidet der Held den Status Blutend.",
          );
        } else if (11 <= w20 && w20 <= 20) {
          return (
            "Selbst schwer verletzt",
            "Ein schwerer Eigentreffer des Helden. Der Schaden seiner Waffe wird unter Einbeziehung des Schadensbonus ausgewürfelt. Bei unbewaffneten Kämpfern wird 1W6 TP angenommen. Zudem erleidet der Held den Status Blutend und bis zum Ende der nächsten KR sind alle seine Handlungen um 2 erschwert.",
          );
        } else {
          assert(false, "unreachable!");
          return ("This should not occur!", "This should not occur!");
        }
    }
  }
}

enum BotchedAttackRanged implements RuleMixin {
  waffeZerstoert(
    "Waffe zerstört",
    "Die Waffe ist unwiederbringlich zerstört. Bei unzerstörbaren Waffen gilt die Waffe als zu Boden gefallen.",
  ),
  waffeSchwerBeschaedigt(
    "Waffe schwer beschädigt",
    "Die Waffe ist nicht mehr einsetzbar, bis sie repariert wird. Bei unzerstörbaren Waffen gilt die Waffe als zu Boden gefallen.",
  ),
  waffeBeschaedigt(
    "Waffe beschädigt",
    "Die Waffe ist beschädigt worden. Alle Proben auf Fernkampf sind um 4 erschwert, bis sie repariert wird. Bei unzerstörbaren Waffen gilt die Waffe als zu Boden gefallen.",
  ),
  waffeVerloren("Waffe verloren", "Die Waffe ist zu Boden gefallen."),
  kameradUnschuldigerGetroffen(
    "Kamerad/Unschuldiger getroffen",
    "Das Geschoss trifft aus Versehen einen Freund oder einen am Kampf Unbeteiligten. Ist kein solches Ziel in der Nähe, wird diese Auswirkung wie 11 Selbst verletzt behandelt. Der Schaden der Waffe wird unter Einbeziehung des Schadensbonus ausgewürfelt.",
  ),
  fehlschuss(
    "Fehlschuss",
    "Der spektakuläre Fehlschuss trifft ein Objekt (Ladenschild heruntergeschossen, Glasfenster zu Bruch gegangen etc.).",
  ),
  zerrung(
    "Zerrung",
    "Der Held hat Rückenschmerzen und erleidet für die nächsten 3 Kampfrunden eine Stufe Schmerz.",
  ),
  sehneHerausgerutschtWaffeNichtRichtigGegriffenLadehemmung(
    "Sehne herausgerutscht / Waffe nicht richtig gegriffen / Ladehemmung",
    "Der Held benötigt 2 komplette Kampfrunden, um die Waffe wieder einsatzbereit zu machen.",
  ),
  zuKonzentriert(
    "Zu konzentriert",
    "Der Held ist mit Zielen oder mit seiner Waffe beschäftigt. Bis zu seiner nächsten Aktion kann er keine Verteidigungen ausführen.",
  ),
  selbstVerletzt(
    "Selbst verletzt",
    "Der Held hat sich selbst verletzt und erleidet Schaden. Der Schaden der Waffe wird unter Einbeziehung des Schadensbonus ausgewürfelt.",
  ),
  selbstSchwerVerletzt(
    "Selbst schwer verletzt",
    "Ein schwerer Eigentreffer. Der Schaden der Waffe wird unter Einbeziehung des Schadensbonus ausgewürfelt und dann verdoppelt.",
  );

  @override
  final String title;
  @override
  final String effect;
  const BotchedAttackRanged(this.title, this.effect);

  static BotchedAttackRanged from(int twoW6) {
    switch (twoW6) {
      case 2:
        return BotchedAttackRanged.waffeZerstoert;

      case 3:
        return BotchedAttackRanged.waffeSchwerBeschaedigt;

      case 4:
        return BotchedAttackRanged.waffeBeschaedigt;

      case 5:
        return BotchedAttackRanged.waffeVerloren;

      case 6:
        return BotchedAttackRanged.kameradUnschuldigerGetroffen;

      case 7:
        return BotchedAttackRanged.fehlschuss;

      case 8:
        return BotchedAttackRanged.zerrung;

      case 9:
        return BotchedAttackRanged
            .sehneHerausgerutschtWaffeNichtRichtigGegriffenLadehemmung;

      case 10:
        return BotchedAttackRanged.zuKonzentriert;

      case 11:
        return BotchedAttackRanged.selbstVerletzt;

      case 12:
        return BotchedAttackRanged.selbstSchwerVerletzt;

      default:
        assert(false, "unreachable!");
        return BotchedAttackRanged.waffeZerstoert;
    }
  }

  @override
  (String, String) normalRule() {
    return ("Patzer beim Angriff!", "Der Held erhält 2W6 + 2 Schadenspunkte!");
  }

  @override
  (String, String) focusRule(int w20) {
    switch (this) {
      case BotchedAttackRanged.waffeZerstoert:
        if (1 <= w20 && w20 <= 10) {
          return (
            "Waffe zerstört",
            "Die Waffe kann nicht mehr repariert werden. Ihre Einzelteile treffen teilweise den Helden und verursachen 1W6 SP. Bei unzerstörbaren Waffen wird das Ergebnis wie Waffe verloren behandelt.",
          );
        } else if (11 <= w20 && w20 <= 20) {
          return (
            "Waffe zerstört",
            "Die Waffe ist zerbrochen. Die Probe, um sie zu reparieren ist um 3 erschwert, außerdem kostet die Reparatur 25 % des ursprünglichen Preises der Waffe. Bei unzerstörbaren Waffen wird das Ergebnis wie Waffe verloren behandelt.",
          );
        } else {
          assert(false, "unreachable!");
          return ("This should not occur!", "This should not occur!");
        }

      case BotchedAttackRanged.waffeSchwerBeschaedigt:
        if (1 <= w20 && w20 <= 6) {
          return (
            "Waffe schwer beschädigt",
            "Die Waffe ist nicht mehr verwendbar, bis sie repariert wird. Die Probe, um sie zu reparieren ist um 1 erschwert. Bei unzerstörbaren Waffen wird das Ergebnis wie Waffe verloren behandelt.",
          );
        } else if (7 <= w20 && w20 <= 12) {
          return (
            "Waffe schwer beschädigt",
            "Die Waffe ist nicht mehr verwendbar, bis sie repariert wird. Bei unzerstörbaren Waffen wird das Ergebnis wie Waffe verloren behandelt.",
          );
        } else if (13 <= w20 && w20 <= 18) {
          return (
            "Waffe schwer beschädigt",
            "Die Waffe ist zwar schwer beschädigt, aber noch einsetzbar. Alle Proben auf Fernkampf sind um 4 erschwert, bis sie repariert wird. Bei unzerstörbaren Waffen wird das Ergebnis wie Waffe verloren behandelt.",
          );
        } else if (19 <= w20 && w20 <= 20) {
          return ("Waffe schwer beschädigt", "nochmal würfeln");
        } else {
          assert(false, "unreachable!");
          return ("This should not occur!", "This should not occur!");
        }

      case BotchedAttackRanged.waffeBeschaedigt:
        if (1 <= w20 && w20 <= 5) {
          return (
            "Waffe beschädigt",
            "Die Waffe hat einen Kratzer abbekommen, aber dies hat keine regeltechnischen Auswirkungen. Bei unzerstörbaren Waffen wird das Ergebnis wie Waffe verloren behandelt.",
          );
        } else if (6 <= w20 && w20 <= 10) {
          return (
            "Waffe beschädigt",
            "Die Waffe wurde beschädigt. Alle Proben auf Fernkampf sind um 2 erschwert, bis sie repariert wird. Bei unzerstörbaren Waffen wird das Ergebnis wie Waffe verloren behandelt.",
          );
        } else if (11 <= w20 && w20 <= 15) {
          return (
            "Waffe beschädigt",
            "Die Waffe wurde beschädigt. Alle Proben auf Fernkampf sind um 4 erschwert, bis sie repariert wird. Bei unzerstörbaren Waffen wird das Ergebnis wie Waffe verloren behandelt.",
          );
        } else if (16 <= w20 && w20 <= 20) {
          return (
            "Waffe beschädigt",
            "Die Waffe wurde beschädigt. Alle Proben auf Fernkampf sind um 4 erschwert, bis sie repariert wird. Außerdem ist die Probe für die Reparatur um 1 erschwert. Bei unzerstörbaren Waffen wird das Ergebnis wie Waffe verloren behandelt.",
          );
        } else {
          assert(false, "unreachable!");
          return ("This should not occur!", "This should not occur!");
        }

      case BotchedAttackRanged.waffeVerloren:
        if (1 <= w20 && w20 <= 3) {
          return (
            "Waffe verloren",
            "Die Waffe ist auf den Boden gefallen und muss nach den üblichen Regeln wieder aufgehoben werden (siehe Regelwerk Seite 239). Sie liegt 1W6+2 Schritt weit weg, sodass noch eine Bewegung ausgeführt werden muss, um sie zu erreichen. Außerdem hat sie sich an einem Objekt verhakt oder ist eingeklemmt und kann nur mit 1 Aktion und einer Probe auf Kraftakt (Ziehen & Zerren) befreit werden.",
          );
        } else if (4 <= w20 && w20 <= 6) {
          return (
            "Waffe verloren",
            "Die Waffe ist auf den Boden gefallen und muss nach den üblichen Regeln wieder aufgehoben werden (siehe Regelwerk Seite 239). Allerdings liegt sie 1W6+2 Schritt weit weg, sodass zusätzlich noch eine Bewegung ausgeführt werden muss, um sie zu erreichen.",
          );
        } else if (7 <= w20 && w20 <= 9) {
          return (
            "Waffe verloren",
            "Die Waffe ist auf den Boden gefallen und muss nach den üblichen Regeln wieder aufgehoben werden (siehe Regelwerk Seite 239). Außerdem hat sie sich an einem Objekt verhakt oder ist eingeklemmt und kann nur mit 1 Aktion und einer Probe auf Kraftakt (Ziehen & Zerren) befreit werden.",
          );
        } else if (10 <= w20 && w20 <= 12) {
          return (
            "Waffe verloren",
            "Die Waffe ist auf den Boden gefallen und muss nach den üblichen Regeln wieder aufgehoben werden (siehe Regelwerk Seite 239).",
          );
        } else if (13 <= w20 && w20 <= 15) {
          return (
            "Waffe verloren",
            "Die Waffe ist auf den Boden gefallen, dabei hat sie selbst oder das Geschoss aber einen vom Meister bestimmten Gefährten des Helden oder einen Unschuldigen fast getroffen, sodass dieser bis zum Ende der nächsten KR –3 auf VW aufweist. Ist niemand in der Nähe, erleidet der Held bis zum Ende der nächsten KR eine Erschwernis von 3 auf FK.",
          );
        } else if (16 <= w20 && w20 <= 18) {
          return (
            "Waffe verloren",
            "Die Waffe ist zwar auf den Boden gefallen und muss nach den üblichen Regeln wieder aufgehoben werden (siehe Regelwerk Seite 239), allerdings ist die Probe um 2 erleichtert.",
          );
        } else if (19 <= w20 && w20 <= 20) {
          return ("Waffe verloren", "nochmal würfeln");
        } else {
          assert(false, "unreachable!");
          return ("This should not occur!", "This should not occur!");
        }

      case BotchedAttackRanged.kameradUnschuldigerGetroffen:
        if (1 <= w20 && w20 <= 2) {
          return (
            "Kamerad/Unschuldiger getroffen",
            "Das Geschoss trifft aus Versehen einen Freund oder einen am Kampf Unbeteiligten. Ist kein solches Ziel in der Nähe, wird diese Auswirkung Selbst verletzt behandelt. Der Schaden der Waffe wird unter Einbeziehung des Schadensbonus ausgewürfelt und bekommt danach noch einen Bonus von +2 TP. Das Opfer kann sich gegen den Angriff nicht verteidigen.",
          );
        } else if (3 <= w20 && w20 <= 4) {
          return (
            "Kamerad/Unschuldiger getroffen",
            "Das Geschoss trifft aus Versehen einen Freund oder einen am Kampf Unbeteiligten. Ist kein solches Ziel in der Nähe, wird diese Auswirkung Selbst verletzt behandelt. Der Schaden der Waffe wird unter Einbeziehung des Schadensbonus ausgewürfelt und bekommt danach noch einen Bonus von +2 TP. Das Opfer kann sich gegen den Angriff verteidigen erhält aber einen Malus von –2 auf Verteidigung.",
          );
        } else if (5 <= w20 && w20 <= 6) {
          return (
            "Kamerad/Unschuldiger getroffen",
            "Der Treffer beim Kamerad / Unschuldigen erfolgte in den rechten Arm. Ist kein solches Ziel in der Nähe, wird diese Auswirkung Selbst verletzt behandelt. Der Schaden der Waffe wird unter Einbeziehung des Schadensbonus ausgewürfelt und bekommt danach noch einen Bonus von +2 TP. Das Opfer kann sich gegen den Angriff verteidigen.",
          );
        } else if (7 <= w20 && w20 <= 8) {
          return (
            "Kamerad/Unschuldiger getroffen",
            "Das Geschoss trifft aus Versehen einen Freund oder einen am Kampf Unbeteiligten. Ist kein solches Ziel in der Nähe, wird diese Auswirkung Selbst verletzt behandelt. Der Schaden der Waffe wird unter Einbeziehung des Schadensbonus ausgewürfelt.",
          );
        } else if (9 <= w20 && w20 <= 10) {
          return (
            "Kamerad/Unschuldiger getroffen",
            "Das Geschoss trifft aus Versehen einen Freund oder einen am Kampf Unbeteiligten. Ist kein solches Ziel in der Nähe, wird diese Auswirkung Selbst verletzt behandelt. Der Schaden der Waffe wird unter Einbeziehung des Schadensbonus ausgewürfelt und bekommt danach einen Malus von –2 TP (bis zu einem Minimum von 1 TP). Das Opfer kann sich gegen den Angriff nicht verteidigen.",
          );
        } else if (11 <= w20 && w20 <= 12) {
          return (
            "Kamerad/Unschuldiger getroffen",
            "Das Geschoss trifft aus Versehen einen Freund oder einen am Kampf Unbeteiligten. Ist kein solches Ziel in der Nähe, wird diese Auswirkung Selbst verletzt behandelt. Der Schaden der Waffe wird unter Einbeziehung des Schadensbonus ausgewürfelt und bekommt danach noch einen Malus von –2 TP (bis zu einem Minimum von 1 TP). Das Opfer kann sich gegen den Angriff verteidigen.",
          );
        } else if (13 <= w20 && w20 <= 14) {
          return (
            "Kamerad/Unschuldiger getroffen",
            "Das Geschoss trifft aus Versehen einen Freund oder einen am Kampf Unbeteiligten. Ist kein solches Ziel in der Nähe, wird diese Auswirkung Selbst verletzt behandelt. Der Schaden der Waffe wird unter Einbeziehung des Schadensbonus ausgewürfelt und bekommt danach noch einen Malus von –2 TP (bis zu einem Minimum von 1 TP). Das Opfer kann sich gegen den Angriff verteidigen und erhält einen Bonus von +2 auf die Verteidigung.",
          );
        } else if (15 <= w20 && w20 <= 20) {
          return ("Kamerad/Unschuldiger getroffen", "nochmal würfeln");
        } else {
          assert(false, "unreachable!");
          return ("This should not occur!", "This should not occur!");
        }

      case BotchedAttackRanged.fehlschuss:
        if (1 <= w20 && w20 <= 2) {
          return (
            "Fehlschuss",
            "Die Kleidung eines Gefährten oder eines Unschuldigen wird getroffen und ist dadurch an ein Objekt festgenagelt, sodass er bis zum Ende der nächsten KR den Status Fixiert erleidet.",
          );
        } else if (3 <= w20 && w20 <= 4) {
          return ("Fehlschuss", "Die Ladezeit steigt um 2 Aktionen.");
        } else if (5 <= w20 && w20 <= 6) {
          return (
            "Fehlschuss",
            "Der Fehlschuss bleibt in einem Gefährten oder einen Unschuldigen hängen, richtet aber nur 1 SP an (falls das Ziel eine Rüstung mit mindestens RS 1 trägt: 0 SP).",
          );
        } else if (7 <= w20 && w20 <= 8) {
          return ("Fehlschuss", "Die Ladezeit steigt um 1 Aktion.");
        } else if (9 <= w20 && w20 <= 10) {
          return ("Fehlschuss", "Das Geschoss geht wird beim Schuss zerstört.");
        } else if (11 <= w20 && w20 <= 12) {
          return (
            "Fehlschuss",
            "Der spektakuläre Fehlschuss trifft ein Objekt (Ladenschild heruntergeschossen, Glasfenster zu Bruch gegangen etc.).",
          );
        } else if (13 <= w20 && w20 <= 14) {
          return (
            "Fehlschuss",
            "Es kommt zu einem Fehlschuss und das Geschoss ist verloren.",
          );
        } else if (15 <= w20 && w20 <= 16) {
          return (
            "Fehlschuss",
            "Der Schuss geht weit daneben und das Geschoss fliegt bis zu seiner maximalen Reichweite davon.",
          );
        } else if (17 <= w20 && w20 <= 20) {
          return ("Fehlschuss", "nochmal würfeln");
        } else {
          assert(false, "unreachable!");
          return ("This should not occur!", "This should not occur!");
        }

      case BotchedAttackRanged.zerrung:
        if (1 <= w20 && w20 <= 2) {
          return (
            "Zerrung",
            "1 Stufe Schmerz und 1 Stufe Paralyse für 1 Stunde.",
          );
        } else if (3 <= w20 && w20 <= 4) {
          return ("Zerrung", "1 Stufe Schmerz und 1 Stufe Paralyse für 5 KR.");
        } else if (5 <= w20 && w20 <= 6) {
          return (
            "Zerrung",
            "Der Held hat Nackenschmerzen und erleidet für die nächsten 3 Kampfrunden –2 VW.",
          );
        } else if (7 <= w20 && w20 <= 8) {
          return (
            "Zerrung",
            "Der Held hat Rückenschmerzen und erleidet für die nächsten 3 Kampfrunden 1 Stufe Schmerz.",
          );
        } else if (9 <= w20 && w20 <= 10) {
          return (
            "Zerrung",
            "Der Held hat eine Zerrung und erleidet bis zum Ende der nächsten KR 1 Stufe Schmerz.",
          );
        } else if (11 <= w20 && w20 <= 12) {
          return (
            "Zerrung",
            "Der Held hat Nackenschmerzen und erleidet für die nächsten 3 Kampfrunden –1 AT und –1 VW.",
          );
        } else if (13 <= w20 && w20 <= 14) {
          return (
            "Zerrung",
            "Der Held hat eine Zerrung in seinem rechten Arm (bei Linkshändern: linker Arm) und erleidet für die nächsten 3 Kampfrunden –2 auf AT.",
          );
        } else if (15 <= w20 && w20 <= 20) {
          return ("Zerrung", "nochmal würfeln");
        } else {
          assert(false, "unreachable!");
          return ("This should not occur!", "This should not occur!");
        }

      case BotchedAttackRanged
          .sehneHerausgerutschtWaffeNichtRichtigGegriffenLadehemmung:
        if (1 <= w20 && w20 <= 3) {
          return (
            "Sehne herausgerutscht / Waffe nicht richtig gegriffen / Ladehemmung",
            "Der Held benötigt 5 komplette Kampfrunden, um die Waffe wieder einsatzbereit zu machen.",
          );
        } else if (4 <= w20 && w20 <= 6) {
          return (
            "Sehne herausgerutscht / Waffe nicht richtig gegriffen / Ladehemmung",
            "Der Held benötigt 3 komplette Kampfrunden, um die Waffe wieder einsatzbereit zu machen.",
          );
        } else if (7 <= w20 && w20 <= 9) {
          return (
            "Sehne herausgerutscht / Waffe nicht richtig gegriffen / Ladehemmung",
            "Der Held benötigt 2 komplette Kampfrunden, um die Waffe wieder einsatzbereit zu machen.",
          );
        } else if (10 <= w20 && w20 <= 12) {
          return (
            "Sehne herausgerutscht / Waffe nicht richtig gegriffen / Ladehemmung",
            "Der Held benötigt 1 komplette Kampfrunden, um die Waffe wieder einsatzbereit zu machen.",
          );
        } else if (13 <= w20 && w20 <= 15) {
          return (
            "Sehne herausgerutscht / Waffe nicht richtig gegriffen / Ladehemmung",
            "Waffe Die Waffe macht bis zum Ende des Kampfes Schwierigkeiten, sodass alle Proben auf FK um 2 erschwert sind.",
          );
        } else if (16 <= w20 && w20 <= 18) {
          return (
            "Sehne herausgerutscht / Waffe nicht richtig gegriffen / Ladehemmung",
            "Die Waffe macht bis zum Ende des Kampfes Schwierigkeiten, sodass alle Proben auf FK um 1 erschwert sind.",
          );
        } else if (19 <= w20 && w20 <= 20) {
          return (
            "Sehne herausgerutscht / Waffe nicht richtig gegriffen / Ladehemmung",
            "nochmal würfeln",
          );
        } else {
          assert(false, "unreachable!");
          return ("This should not occur!", "This should not occur!");
        }

      case BotchedAttackRanged.zuKonzentriert:
        if (1 <= w20 && w20 <= 5) {
          return (
            "Zu konzentriert",
            "Der Held ist mit Zielen oder mit seiner Waffe beschäftigt. Er benötigt 2 Aktionen zum Abschießen/Werfen der Waffe. Der FK-Angriff wird damit zu einer Länger dauernden Handlung.",
          );
        } else if (6 <= w20 && w20 <= 10) {
          return (
            "Zu konzentriert",
            "Der Held ist mit Zielen oder mit seiner Waffe beschäftigt. Bis zu seiner nächsten Aktion sind Verteidigungen um 4 erschwert.",
          );
        } else if (11 <= w20 && w20 <= 15) {
          return (
            "Zu konzentriert",
            "Der Held ist mit Zielen oder mit seiner Waffe beschäftigt. Bis zu seiner nächsten Aktion kann er keine Verteidigungen ausführen.",
          );
        } else if (16 <= w20 && w20 <= 20) {
          return (
            "Zu konzentriert",
            "Der Held ist mit Zielen oder mit seiner Waffe beschäftigt. Bis zum Abschluss des FK-Angriffs kann er keine Verteidigungen ausführen und er benötigt 2 Aktionen zum Abschießen/Werfen der Waffe. Der FK-Angriff wird damit zu einer Länger dauernden Handlung.",
          );
        } else {
          assert(false, "unreachable!");
          return ("This should not occur!", "This should not occur!");
        }

      case BotchedAttackRanged.selbstVerletzt:
        if (1 <= w20 && w20 <= 6) {
          return (
            "Selbst verletzt",
            "Der Held hat sich selbst verletzt und erleidet Schaden. Der Schaden seiner Waffe wird unter Einbeziehung des Schadensbonus ausgewürfelt und dann halbiert.",
          );
        } else if (7 <= w20 && w20 <= 12) {
          return (
            "Selbst verletzt",
            "Der Held hat sich selbst verletzt und erleidet Schaden. Der Schaden seiner Waffe wird unter Einbeziehung des Schadensbonus ausgewürfelt.",
          );
        } else if (13 <= w20 && w20 <= 18) {
          return (
            "Selbst verletzt",
            "Der Held hat sich selbst verletzt und erleidet Schaden. Der Schaden seiner Waffe wird unter Einbeziehung des Schadensbonus ausgewürfelt. Zudem erleidet der Held den Status Blutend.",
          );
        } else if (19 <= w20 && w20 <= 20) {
          return ("Selbst verletzt", "nochmal würfeln");
        } else {
          assert(false, "unreachable!");
          return ("This should not occur!", "This should not occur!");
        }

      case BotchedAttackRanged.selbstSchwerVerletzt:
        if (1 <= w20 && w20 <= 10) {
          return (
            "Selbst schwer verletzt",
            "Ein schwerer Eigentreffer des Helden. Der Schaden seiner Waffe wird unter Einbeziehung des Schadensbonus ausgewürfelt und dann verdoppelt. Zudem erleidet der Held den Status Blutend.",
          );
        } else if (11 <= w20 && w20 <= 20) {
          return (
            "Selbst schwer verletzt",
            "Ein schwerer Eigentreffer des Helden. Der Schaden seiner Waffe wird unter Einbeziehung des Schadensbonus ausgewürfelt. Zudem erleidet der Held den Status Blutend und bis zum Ende der nächsten KR sind alle seine Handlungen um 2 erschwert.",
          );
        } else {
          assert(false, "unreachable!");
          return ("This should not occur!", "This should not occur!");
        }
    }
  }
}

enum CriticalAttack implements RuleMixin {
  leichterTreffer("Leichter Treffer", "Die Trefferpunkte werden um 2 erhöht."),
  leichtBetaeubenderTreffer(
    "Leicht betäubender Treffer",
    "Die Trefferpunkte werden um 2 erhöht und der Gegner bekommt 1 Stufe Betäubung für 2 KR.",
  ),
  mittelschwererTreffer(
    "Mittelschwerer Treffer",
    "Die Trefferpunkte samt Modifikatoren werden veranderthalbfacht (aufgerundet).",
  ),
  mittelschwererSchmerzhafterTreffer(
    "Mittelschwerer schmerzhafter Treffer",
    "Die Trefferpunkte samt Modifikatoren werden veranderthalbfacht (aufgerundet) und der Gegner bekommt 1 Stufe Schmerz für 5 KR.",
  ),
  mittelschwererBetaeubenderTreffer(
    "Mittelschwerer betäubender Treffer",
    "Die Trefferpunkte samt Modifikatoren werden veranderthalbfacht (aufgerundet) und der Gegner bekommt 1 Stufe Betäubung für 5 KR.",
  ),
  schwererTreffer(
    "Schwerer Treffer",
    "Die Trefferpunkte samt Modifikatoren werden verdoppelt.",
  ),
  schwererBetaeubenderTreffer(
    "Schwerer betäubender Treffer",
    "Die Trefferpunkte samt Modifikatoren werden verdoppelt und der Gegner erleidet 1 Stufe Betäubung für 5 KR.",
  ),
  schwererSchmerzhafterTreffer(
    "Schwerer schmerzhafter Treffer",
    "Die Trefferpunkte samt Modifikatoren werden verdoppelt und der Gegner erleidet 1 Stufe Schmerz für 5 KR.",
  ),
  ausDemGleichgewichtGebracht(
    "Aus dem Gleichgewicht gebracht",
    "Der Gegner erleidet bis zum Ende der nächsten KR eine Erschwernis von 4 auf Verteidigung. Außerdem muss er eine Probe auf Körperbeherrschung (Kampfmanöver) –2 bestehen, bei Misslingen erleidet er den Status Liegend.",
  ),
  gehirnerschuetterung(
    "Gehirnerschütterung",
    "Dem Gegner muss eine Probe auf Selbstbeherrschung (Handlungsfähigkeit bewahren) –2 gelingen, um nicht für 5 KR den Status Bewusstlos zu erleiden. Gleich ob die Probe ge- oder misslungen ist, erleidet der Gegner 2 Stufen Betäubung für 1 Stunde.",
  ),
  extremSchwererTreffer(
    "Extrem schwerer Treffer",
    "Die Trefferpunkte samt Modifikatoren werden verdreifacht.",
  );

  @override
  final String title;
  @override
  final String effect;
  const CriticalAttack(this.title, this.effect);

  static CriticalAttack from(int twoW6) {
    switch (twoW6) {
      case 2:
        return CriticalAttack.leichterTreffer;

      case 3:
        return CriticalAttack.leichtBetaeubenderTreffer;

      case 4:
        return CriticalAttack.mittelschwererTreffer;

      case 5:
        return CriticalAttack.mittelschwererSchmerzhafterTreffer;

      case 6:
        return CriticalAttack.mittelschwererBetaeubenderTreffer;

      case 7:
        return CriticalAttack.schwererTreffer;

      case 8:
        return CriticalAttack.schwererBetaeubenderTreffer;

      case 9:
        return CriticalAttack.schwererSchmerzhafterTreffer;

      case 10:
        return CriticalAttack.ausDemGleichgewichtGebracht;

      case 11:
        return CriticalAttack.gehirnerschuetterung;

      case 12:
        return CriticalAttack.extremSchwererTreffer;

      default:
        assert(false, "unreachable!");
        return CriticalAttack.leichterTreffer;
    }
  }

  @override
  (String, String) normalRule() {
    return ("Kritischer Erfolg!", "Die erwürfelten TP werden verdoppelt!");
  }

  @override
  (String, String) focusRule(int w20) {
    switch (this) {
      case CriticalAttack.leichterTreffer:
        if (1 <= w20 && w20 <= 10) {
          return ("Leichter Treffer", "Der Treffer richtet +1 TP an.");
        } else if (11 <= w20 && w20 <= 20) {
          return ("Leichter Treffer", "Der Treffer richtet +3 TP an.");
        } else {
          assert(false, "unreachable!");
          return ("This should not occur!", "This should not occur!");
        }

      case CriticalAttack.leichtBetaeubenderTreffer:
        if (1 <= w20 && w20 <= 6) {
          return (
            "Leicht betäubender Treffer",
            "Der Treffer richtet +1 TP an und der Gegner erhält 1 Stufe Betäubung für 1 KR.",
          );
        } else if (7 <= w20 && w20 <= 12) {
          return (
            "Leicht betäubender Treffer",
            "Der Treffer richtet +2 TP an und der Gegner erhält 1 Stufe Betäubung für 2 KR.",
          );
        } else if (13 <= w20 && w20 <= 18) {
          return (
            "Leicht betäubender Treffer",
            "Der Treffer richtet +3 TP an und der Gegner erhält 1 Stufe Betäubung für 3 KR.",
          );
        } else if (19 <= w20 && w20 <= 20) {
          return ("Leicht betäubender Treffer", "nochmal würfeln");
        } else {
          assert(false, "unreachable!");
          return ("This should not occur!", "This should not occur!");
        }

      case CriticalAttack.mittelschwererTreffer:
        if (1 <= w20 && w20 <= 5) {
          return (
            "Mittelschwerer Treffer",
            "Die Trefferpunkte samt Modifikatoren werden veranderthalbfacht (aufgerundet) und der Gegner erhält den Status Blutend.",
          );
        } else if (6 <= w20 && w20 <= 10) {
          return (
            "Mittelschwerer Treffer",
            "Die Trefferpunkte samt Modifikatoren werden veranderthalbfacht (aufgerundet).",
          );
        } else if (11 <= w20 && w20 <= 15) {
          return (
            "Mittelschwerer Treffer",
            "Der Gegner erhält den Status Blutend.",
          );
        } else if (16 <= w20 && w20 <= 20) {
          return (
            "Mittelschwerer Treffer",
            "Der Gegner muss eine Probe auf Körperbeherrschung (Kampfmanöver) bestehen, bei Misslingen erleidet er den Status Liegend.",
          );
        } else {
          assert(false, "unreachable!");
          return ("This should not occur!", "This should not occur!");
        }

      case CriticalAttack.mittelschwererSchmerzhafterTreffer:
        if (1 <= w20 && w20 <= 3) {
          return (
            "Mittelschwerer schmerzhafter Treffer",
            "Die Trefferpunkte samt Modifikatoren werden veranderthalbfacht (aufgerundet) und der Gegner erhält für 2 KR 1 Stufe Schmerz sowie 1 Stufe Betäubung.",
          );
        } else if (4 <= w20 && w20 <= 6) {
          return (
            "Mittelschwerer schmerzhafter Treffer",
            "Die Trefferpunkte samt Modifikatoren werden veranderthalbfacht (aufgerundet) und der Gegner erhält für 2 KR 1 Stufe Schmerz sowie den Status Blutend.",
          );
        } else if (7 <= w20 && w20 <= 9) {
          return (
            "Mittelschwerer schmerzhafter Treffer",
            "Die Trefferpunkte samt Modifikatoren werden veranderthalbfacht (aufgerundet) und der Gegner erhält für 2 KR 1 Stufe Schmerz.",
          );
        } else if (10 <= w20 && w20 <= 12) {
          return (
            "Mittelschwerer schmerzhafter Treffer",
            "Der Gegner erhält für 2 KR 1 Stufe Schmerz sowie den Status Blutend.",
          );
        } else if (13 <= w20 && w20 <= 15) {
          return (
            "Mittelschwerer schmerzhafter Treffer",
            "Der Gegner erhält für 2 KR 1 Stufe Schmerz.",
          );
        } else if (16 <= w20 && w20 <= 18) {
          return (
            "Mittelschwerer schmerzhafter Treffer",
            "Der Gegner erhält für 1 KR 1 Stufe Schmerz.",
          );
        } else if (19 <= w20 && w20 <= 20) {
          return ("Mittelschwerer schmerzhafter Treffer", "nochmal würfeln");
        } else {
          assert(false, "unreachable!");
          return ("This should not occur!", "This should not occur!");
        }

      case CriticalAttack.mittelschwererBetaeubenderTreffer:
        if (1 <= w20 && w20 <= 2) {
          return (
            "Mittelschwerer betäubender Treffer",
            "Die Trefferpunkte samt Modifikatoren werden veranderthalbfacht (aufgerundet) und dem Gegner muss eine Probe auf Selbstbeherrschung (Handlungsfähigkeit bewahren) gelingen, um nicht für 3 KR den Status Bewusstlos zu erleiden. Gleich ob die Probe ge- oder misslungen ist, erleidet der Held 1 Stufe Betäubung für 8 KR.",
          );
        } else if (3 <= w20 && w20 <= 4) {
          return (
            "Mittelschwerer betäubender Treffer",
            "Die Trefferpunkte samt Modifikatoren werden veranderthalbfacht (aufgerundet) und der Gegner erhält für 5 KR 2 Stufen Betäubung.",
          );
        } else if (5 <= w20 && w20 <= 6) {
          return (
            "Mittelschwerer betäubender Treffer",
            "Die Trefferpunkte samt Modifikatoren werden veranderthalbfacht (aufgerundet) und der Gegner erhält für 8 KR 1 Stufe Betäubung.",
          );
        } else if (7 <= w20 && w20 <= 8) {
          return (
            "Mittelschwerer betäubender Treffer",
            "Die Trefferpunkte samt Modifikatoren werden veranderthalbfacht (aufgerundet) und der Gegner erhält für 5 KR 1 Stufe Betäubung.",
          );
        } else if (9 <= w20 && w20 <= 10) {
          return (
            "Mittelschwerer betäubender Treffer",
            "Der Treffer richtet +1 TP an und der Gegner erhält für 5 KR 1 Stufe Betäubung.",
          );
        } else if (11 <= w20 && w20 <= 12) {
          return (
            "Mittelschwerer betäubender Treffer",
            "Der Treffer richtet +1 TP an und der Gegner erhält für 3 KR 2 Stufen Betäubung.",
          );
        } else if (13 <= w20 && w20 <= 14) {
          return (
            "Mittelschwerer betäubender Treffer",
            "Der Treffer richtet +1 TP an und der Gegner erhält für 1 KR 2 Stufen Betäubung.",
          );
        } else if (15 <= w20 && w20 <= 20) {
          return ("Mittelschwerer betäubender Treffer", "nochmal würfeln");
        } else {
          assert(false, "unreachable!");
          return ("This should not occur!", "This should not occur!");
        }

      case CriticalAttack.schwererTreffer:
        if (1 <= w20 && w20 <= 2) {
          return (
            "Schwerer Treffer",
            "Die Trefferpunkte samt Modifikatoren werden verdoppelt und der Gegner erhält für 5 KR 1 Stufe Betäubung sowie den Status Blutend.",
          );
        } else if (3 <= w20 && w20 <= 4) {
          return (
            "Schwerer Treffer",
            "Die Trefferpunkte samt Modifikatoren werden verdoppelt und der Gegner erhält für 5 KR 1 Stufe Betäubung.",
          );
        } else if (5 <= w20 && w20 <= 6) {
          return (
            "Schwerer Treffer",
            "Die Trefferpunkte samt Modifikatoren werden verdoppelt und der Gegner erhält den Status Blutend.",
          );
        } else if (7 <= w20 && w20 <= 8) {
          return (
            "Schwerer Treffer",
            "Die Trefferpunkte samt Modifikatoren werden verdoppelt TP werden verdoppelt und der Gegner erhält 1 Stufe Schmerz für 2 KR.",
          );
        } else if (9 <= w20 && w20 <= 10) {
          return (
            "Schwerer Treffer",
            "Die Trefferpunkte samt Modifikatoren werden verdoppelt.",
          );
        } else if (11 <= w20 && w20 <= 12) {
          return (
            "Schwerer Treffer",
            "Der Treffer richtet +5 TP an und der Gegner muss eine Probe auf Körperbeherrschung (Kampfmanöver) –1 bestehen, bei Misslingen erleidet er den Status Liegend.",
          );
        } else if (13 <= w20 && w20 <= 14) {
          return (
            "Schwerer Treffer",
            "Der Treffer richtet +3 TP an und der Gegner muss eine Probe auf Körperbeherrschung (Kampfmanöver) –1 bestehen, bei Misslingen erleidet er den Status Liegend.",
          );
        } else if (15 <= w20 && w20 <= 16) {
          return (
            "Schwerer Treffer",
            "Der Treffer richtet +1 TP an und der Gegner muss eine Probe auf Körperbeherrschung (Kampfmanöver) –1 bestehen, bei Misslingen erleidet er den Status Liegend.",
          );
        } else if (17 <= w20 && w20 <= 20) {
          return ("Schwerer Treffer", "nochmal würfeln");
        } else {
          assert(false, "unreachable!");
          return ("This should not occur!", "This should not occur!");
        }

      case CriticalAttack.schwererBetaeubenderTreffer:
        if (1 <= w20 && w20 <= 2) {
          return (
            "Schwerer betäubender Treffer",
            "Die Trefferpunkte samt Modifikatoren werden verdoppelt und dem Gegner muss eine Probe auf Selbstbeherrschung (Handlungsfähigkeit bewahren) –1 gelingen, um nicht für 5 KR den Status Bewusstlos zu erleiden. Gleich ob die Probe ge oder misslungen ist, erleidet der Held 1 Stufe Betäubung für 10 KR.",
          );
        } else if (3 <= w20 && w20 <= 4) {
          return (
            "Schwerer betäubender Treffer",
            "Die Trefferpunkte samt Modifikatoren werden verdoppelt und Gegner erhält für 5 KR 2 Stufen Betäubung.",
          );
        } else if (5 <= w20 && w20 <= 6) {
          return (
            "Schwerer betäubender Treffer",
            "Die Trefferpunkte samt Modifikatoren werden verdoppelt und Gegner erhält für 8 KR 1 Stufe Betäubung.",
          );
        } else if (7 <= w20 && w20 <= 8) {
          return (
            "Schwerer betäubender Treffer",
            "Die Trefferpunkte samt Modifikatoren werden verdoppelt und Gegner erhält für 5 KR 1 Stufe Betäubung.",
          );
        } else if (9 <= w20 && w20 <= 10) {
          return (
            "Schwerer betäubender Treffer",
            "Der Treffer richtet +3 TP an und der Gegner erhält für 5 KR 1 Stufe Betäubung.",
          );
        } else if (11 <= w20 && w20 <= 12) {
          return (
            "Schwerer betäubender Treffer",
            "Der Treffer richtet +3 TP an und der Gegner erhält für 3 KR 2 Stufen Betäubung.",
          );
        } else if (13 <= w20 && w20 <= 14) {
          return (
            "Schwerer betäubender Treffer",
            "Der Treffer richtet +3 TP an und der Gegner erhält für 1 KR 2 Stufen Betäubung.",
          );
        } else if (19 <= w20 && w20 <= 20) {
          return ("Schwerer betäubender Treffer", "nochmal würfeln");
        } else {
          assert(false, "unreachable!");
          return ("This should not occur!", "This should not occur!");
        }

      case CriticalAttack.schwererSchmerzhafterTreffer:
        if (1 <= w20 && w20 <= 3) {
          return (
            "Schwerer schmerzhafter Treffer",
            "Die Trefferpunkte samt Modifikatoren werden verdoppelt und der Gegner erhält für 5 KR 1 Stufe Schmerz sowie 1 Stufe Betäubung.",
          );
        } else if (4 <= w20 && w20 <= 6) {
          return (
            "Schwerer schmerzhafter Treffer",
            "Die Trefferpunkte samt Modifikatoren werden verdoppelt und der Gegner erhält für 5 KR 1 Stufe Schmerz sowie den Status Blutend.",
          );
        } else if (7 <= w20 && w20 <= 9) {
          return (
            "Schwerer schmerzhafter Treffer",
            "Die Trefferpunkte samt Modifikatoren werden verdoppelt und der Gegner erhält für 5 KR 1 Stufe Schmerz.",
          );
        } else if (10 <= w20 && w20 <= 12) {
          return (
            "Schwerer schmerzhafter Treffer",
            "Der Gegner erhält für 5 KR 1 Stufe Schmerz sowie den Status Blutend.",
          );
        } else if (13 <= w20 && w20 <= 15) {
          return (
            "Schwerer schmerzhafter Treffer",
            "Der Gegner erhält für 5 KR 1 Stufe Schmerz.",
          );
        } else if (16 <= w20 && w20 <= 18) {
          return (
            "Schwerer schmerzhafter Treffer",
            "Der Gegner erhält für 5 KR 2 Stufen Schmerz.",
          );
        } else if (19 <= w20 && w20 <= 20) {
          return ("Schwerer schmerzhafter Treffer", "nochmal würfeln");
        } else {
          assert(false, "unreachable!");
          return ("This should not occur!", "This should not occur!");
        }

      case CriticalAttack.ausDemGleichgewichtGebracht:
        if (1 <= w20 && w20 <= 5) {
          return (
            "Aus dem Gleichgewicht gebracht",
            "Die Trefferpunkte samt Modifikatoren werden verdoppelt und der Gegner erleidet bis zum Ende der nächsten KR eine Erschwernis von 2 auf Verteidigung. Außerdem muss er eine Probe auf Körperbeherrschung (Kampfmanöver) –2 bestehen, bei Misslingen erleidet er den Status Liegend.",
          );
        } else if (6 <= w20 && w20 <= 10) {
          return (
            "Aus dem Gleichgewicht gebracht",
            "Die Trefferpunkte samt Modifikatoren werden veranderthalbfacht (aufgerundet) und der Gegner erleidet bis zum Ende der nächsten KR eine Erschwernis von 2 auf Verteidigung. Außerdem muss er eine Probe auf Körperbeherrschung (Kampfmanöver) bestehen, bei Misslingen erleidet er den Status Liegend.",
          );
        } else if (11 <= w20 && w20 <= 15) {
          return (
            "Aus dem Gleichgewicht gebracht",
            "Der Gegner erleidet bis zum Ende der nächsten KR eine Erschwernis von 4 auf Verteidigung. Außerdem muss er eine Probe auf Körperbeherrschung (Kampfmanöver) –2 bestehen, bei Misslingen erleidet er den Status Liegend.",
          );
        } else if (16 <= w20 && w20 <= 20) {
          return (
            "Aus dem Gleichgewicht gebracht",
            "Der Gegner erleidet bis zum Ende der nächsten KR eine Erschwernis von 2 auf Verteidigung. Außerdem muss er eine Probe auf Körperbeherrschung (Kampfmanöver) bestehen, bei Misslingen erleidet er den Status Liegend.",
          );
        } else {
          assert(false, "unreachable!");
          return ("This should not occur!", "This should not occur!");
        }

      case CriticalAttack.gehirnerschuetterung:
        if (1 <= w20 && w20 <= 6) {
          return (
            "Gehirnerschütterung",
            "Die Trefferpunkte samt Modifikatoren werden veranderthalbfacht (aufgerundet) und dem Gegner muss eine Probe auf Selbstbeherrschung (Handlungsfähigkeit bewahren) –2 gelingen, um nicht für 5 KR den Status Bewusstlos zu erleiden. Gleich ob die Probe ge- oder misslungen ist, erleidet der Held 2 Stufen Betäubung für 1 Stunde.",
          );
        } else if (7 <= w20 && w20 <= 12) {
          return (
            "Gehirnerschütterung",
            "Dem Gegner muss eine Probe auf Selbstbeherrschung (Handlungsfähigkeit bewahren) –2 gelingen, um nicht für 5 KR den Status Bewusstlos zu erleiden. Gleich ob die Probe ge- oder misslungen ist, erleidet der Held 2 Stufen Betäubung für 1 Stunde.",
          );
        } else if (13 <= w20 && w20 <= 18) {
          return (
            "Gehirnerschütterung",
            "Dem Gegner muss eine Probe auf Selbstbeherrschung (Handlungsfähigkeit bewahren) gelingen, um nicht für 5 KR den Status Bewusstlos zu erleiden. Gleich ob die Probe ge- oder misslungen ist, erleidet der Held 1 Stufe Betäubung für 1 Stunde.",
          );
        } else if (19 <= w20 && w20 <= 20) {
          return ("Gehirnerschütterung", "nochmal würfeln");
        } else {
          assert(false, "unreachable!");
          return ("This should not occur!", "This should not occur!");
        }

      case CriticalAttack.extremSchwererTreffer:
        if (1 <= w20 && w20 <= 10) {
          return (
            "Extrem schwerer Treffer",
            "Die Trefferpunkte samt Modifikatoren werden verdreifacht.",
          );
        } else if (11 <= w20 && w20 <= 20) {
          return (
            "Extrem schwerer Treffer",
            "Die Trefferpunkte samt Modifikatoren werden verdoppelt und dem Gegner muss eine Probe auf Selbstbeherrschung (Handlungsfähigkeit bewahren) gelingen, um nicht für 1W3 KR den Status Handlungsunfähig zu erleiden. Gleich ob die Probe ge- oder misslungen ist, erleidet der Held 1 Stufe Schmerz für 3 KR.",
          );
        } else {
          assert(false, "unreachable!");
          return ("This should not occur!", "This should not occur!");
        }
    }
  }
}

enum BotchedDefenseNoShield implements RuleMixin {
  waffeZerstoert(
    "Waffe zerstört",
    "Die Waffe ist unwiederbringlich zerstört. Bei unzerstörbaren Waffen wird das Ergebnis wie bei 5 behandelt.",
  ),
  waffeSchwerBeschaedigt(
    "Waffe schwer beschädigt",
    "Die Waffe ist nicht mehr verwendbar, bis sie repariert wird. Bei unzerstörbaren Waffen wird das Ergebnis wie bei 5 behandelt.",
  ),
  waffeBeschaedigt(
    "Waffe beschädigt",
    "Die Waffe ist beschädigt worden. Alle Proben auf Attacke und Parade sind um 2 erschwert, bis sie repariert wird. Bei unzerstörbaren Waffen wird das Ergebnis wie bei 5 behandelt.",
  ),
  waffeVerloren("Waffe verloren", "Die Waffe ist zu Boden gefallen."),
  waffeSteckenGeblieben(
    "Waffe stecken geblieben",
    "Die Waffe des Helden ist in einem Baum, einer Holzwand, dem Boden oder Ähnlichem stecken geblieben. Um sie zu befreien, ist 1 Aktion und eine um 1 erschwerte Probe auf Kraftakt (Ziehen & Zerren) notwendig.",
  ),
  sturz(
    "Sturz",
    "Der Held stolpert und stürzt, wenn seinem Spieler nicht eine um 2 erschwerte Probe auf Körperbeherrschung (Balance) gelingt. Sollte er das nicht schaffen, erhält der Held den Status Liegend.",
  ),
  stolpern(
    "Stolpern",
    "Der Held stolpert, seine nächste Handlung ist um 2 erschwert.",
  ),
  fussVerdreht(
    "Fuß verdreht",
    "Der Held erhält für 3 Kampfrunden eine Stufe Schmerz.",
  ),
  beule(
    "Beule",
    "Der Held hat sich im Eifer des Gefechts den Kopf gestoßen. Er erhält für eine Stunde eine Stufe Betäubung.",
  ),
  selbstVerletzt(
    "Selbst verletzt",
    "Der Held hat sich selbst verletzt und erleidet Schaden. Der Schaden seiner Waffe wird unter Einbeziehung des Schadensbonus ausgewürfelt. Bei unbewaffneten Kämpfern wird 1W6 TP angenommen.",
  ),
  selbstSchwerVerletzt(
    "Selbst schwer verletzt",
    "Ein schwerer Eigentreffer des Helden. Der Schaden seiner Waffe wird unter Einbeziehung des Schadensbonus ausgewürfelt und dann verdoppelt. Bei unbewaffneten Kämpfern wird 1W6 TP angenommen.",
  );

  @override
  final String title;
  @override
  final String effect;
  const BotchedDefenseNoShield(this.title, this.effect);

  static BotchedDefenseNoShield from(int twoW6) {
    switch (twoW6) {
      case 2:
        return BotchedDefenseNoShield.waffeZerstoert;

      case 3:
        return BotchedDefenseNoShield.waffeSchwerBeschaedigt;

      case 4:
        return BotchedDefenseNoShield.waffeBeschaedigt;

      case 5:
        return BotchedDefenseNoShield.waffeVerloren;

      case 6:
        return BotchedDefenseNoShield.waffeSteckenGeblieben;

      case 7:
        return BotchedDefenseNoShield.sturz;

      case 8:
        return BotchedDefenseNoShield.stolpern;

      case 9:
        return BotchedDefenseNoShield.fussVerdreht;

      case 10:
        return BotchedDefenseNoShield.beule;

      case 11:
        return BotchedDefenseNoShield.selbstVerletzt;

      case 12:
        return BotchedDefenseNoShield.selbstSchwerVerletzt;

      default:
        assert(false, "unreachable!");
        return BotchedDefenseNoShield.waffeZerstoert;
    }
  }

  @override
  (String, String) normalRule() {
    return (
      "Patzer bei der Verteidigung!",
      "Der Held erhält 2W6 + 2 Schadenspunkte!",
    );
  }

  @override
  (String, String) focusRule(int w20) {
    switch (this) {
      case BotchedDefenseNoShield.waffeZerstoert:
        if (1 <= w20 && w20 <= 10) {
          return (
            "Waffe zerstört",
            "Waffe zerspringt in Einzelteile: Die Waffe kann nicht mehr repariert werden. Ihre Einzelteile treffen teilweise den Helden und verursachen 1W6 SP. Bei unzerstörbaren Waffen wird das Ergebnis wie Waffe verloren behandelt.",
          );
        } else if (11 <= w20 && w20 <= 20) {
          return (
            "Waffe zerstört",
            "Waffe zerbrochen: Die Waffe ist zerbrochen. Die Probe, um sie zu reparieren ist um 3 erschwert, außerdem kostet die Reparatur 25 % des ursprünglichen Preises der Waffe. Bei unzerstörbaren Waffen wird das Ergebnis wie Waffe verloren behandelt.",
          );
        } else {
          assert(false, "unreachable!");
          return ("This should not occur!", "This should not occur!");
        }

      case BotchedDefenseNoShield.waffeSchwerBeschaedigt:
        if (1 <= w20 && w20 <= 6) {
          return (
            "Waffe schwer beschädigt",
            "Extrem schwere Beschädigung: Die Waffe ist nicht mehr verwendbar, bis sie repariert wird. Die Probe, um sie zu reparieren ist um 1 erschwert. Bei unzerstörbaren Waffen wird das Ergebnis wie Waffe verloren behandelt.",
          );
        } else if (7 <= w20 && w20 <= 12) {
          return (
            "Waffe schwer beschädigt",
            "Waffe stark beschädigt: Die Waffe ist nicht mehr verwendbar, bis sie repariert wird. Bei unzerstörbaren Waffen wird das Ergebnis wie Waffe verloren behandelt.",
          );
        } else if (13 <= w20 && w20 <= 18) {
          return (
            "Waffe schwer beschädigt",
            "Waffe kaum noch zu gebrauchen: Die Waffe ist zwar schwer beschädigt, aber noch einsetzbar. Alle Proben auf Attacke und Parade sind um 4 erschwert, bis sie repariert wird. Bei unzerstörbaren Waffen wird das Ergebnis wie Waffe verloren behandelt.",
          );
        } else if (19 <= w20 && w20 <= 20) {
          return ("Waffe schwer beschädigt", "nochmal würfeln");
        } else {
          assert(false, "unreachable!");
          return ("This should not occur!", "This should not occur!");
        }

      case BotchedDefenseNoShield.waffeBeschaedigt:
        if (1 <= w20 && w20 <= 5) {
          return (
            "Waffe beschädigt",
            "Kratzer an der Waffe: Die Waffe hat einen Kratzer abbekommen, aber dies hat keine regeltechnischen Auswirkungen. Bei unzerstörbaren Waffen wird das Ergebnis wie Waffe verloren behandelt.",
          );
        } else if (6 <= w20 && w20 <= 10) {
          return (
            "Waffe beschädigt",
            "Leicht beschädigte Waffe: Die Waffe ist beschädigt worden. Alle Proben auf Attacke und Parade sind um 1 erschwert, bis sie repariert wird. Bei unzerstörbaren Waffen wird das Ergebnis wie Waffe verloren behandelt.",
          );
        } else if (11 <= w20 && w20 <= 15) {
          return (
            "Waffe beschädigt",
            "Beschädigte Waffe: Die Waffe ist beschädigt worden. Alle Proben auf Attacke und Parade sind um 2 erschwert, bis sie repariert wird. Bei unzerstörbaren Waffen wird das Ergebnis wie Waffe verloren behandelt.",
          );
        } else if (16 <= w20 && w20 <= 20) {
          return (
            "Waffe beschädigt",
            "Schwer beschädigte Waffe: Die Waffe ist beschädigt worden. Alle Proben auf Attacke und Parade sind um 3 erschwert, bis sie repariert wird. Bei unzerstörbaren Waffen wird das Ergebnis wie Waffe verloren behandelt.",
          );
        } else {
          assert(false, "unreachable!");
          return ("This should not occur!", "This should not occur!");
        }

      case BotchedDefenseNoShield.waffeVerloren:
        if (1 <= w20 && w20 <= 3) {
          return (
            "Waffe verloren",
            "Waffe liegt weit weg und ungünstig: Die Waffe ist auf den Boden gefallen und muss nach den üblichen Regeln wieder aufgehoben werden (siehe Regelwerk Seite 239). Sie liegt 1W6+2 Schritt weit weg, sodass noch eine Bewegung ausgeführt werden muss, um sie zu erreichen. Außerdem hat sie sich an einem Objekt verhakt oder ist eingeklemmt und kann nur mit 1 Aktion und einer Probe auf Kraftakt (Ziehen & Zerren) befreit werden.",
          );
        } else if (4 <= w20 && w20 <= 6) {
          return (
            "Waffe verloren",
            "Waffe weit weg: Die Waffe ist auf den Boden gefallen und muss nach den üblichen Regeln wieder aufgehoben werden (siehe Regelwerk Seite 239). Allerdings liegt sie 1W6+2 Schritt weit weg, sodass zusätzlich noch eine Bewegung ausgeführt werden muss, um sie zu erreichen.",
          );
        } else if (7 <= w20 && w20 <= 9) {
          return (
            "Waffe verloren",
            "Waffe liegt ungünstig: Die Waffe ist auf den Boden gefallen und muss nach den üblichen Regeln wieder aufgehoben werden (siehe Regelwerk Seite 239). Allerdings ist die Probe um 2 erschwert.",
          );
        } else if (10 <= w20 && w20 <= 12) {
          return (
            "Waffe verloren",
            "Waffe auf den Boden gefallen: Die Waffe ist auf den Boden gefallen und muss nach den üblichen Regeln wieder aufgehoben werden (siehe Regelwerk Seite 239).",
          );
        } else if (13 <= w20 && w20 <= 15) {
          return (
            "Waffe verloren",
            "Waffe streift einen Gefährten oder Unschuldigen: Die Waffe ist auf den Boden gefallen, hat aber vorher einen vom Meister bestimmten Gefährten des Helden oder einen Unschuldigen fast getroffen, sodass dieser bis zum Ende der nächsten KR –3 auf VW aufweist. Ist niemand in der Nähe, erleidet der Held bis zum Ende der nächsten KR eine Erschwernis von 3 auf AT.",
          );
        } else if (16 <= w20 && w20 <= 18) {
          return (
            "Waffe verloren",
            "Waffe liegt günstig: Die Waffe ist zwar auf den Boden gefallen und muss nach den üblichen Regeln wieder aufgehoben werden (siehe Regelwerk Seite 239), allerdings ist die Probe um 2 erleichtert.",
          );
        } else if (19 <= w20 && w20 <= 20) {
          return ("Waffe verloren", "nochmal würfeln");
        } else {
          assert(false, "unreachable!");
          return ("This should not occur!", "This should not occur!");
        }

      case BotchedDefenseNoShield.waffeSteckenGeblieben:
        if (1 <= w20 && w20 <= 2) {
          return (
            "Waffe stecken geblieben",
            "Gefährten oder Unschuldigen verletzt: Die Waffe fliegt dem Helden aus der Hand und trifft einen Gefährten oder einen Unschuldigen. Dieser kann versuchen, sich mit einer Schilde-PA zu verteidigen oder ausweichen. Bei Misslingen erleidet er den vollen Waffenschaden. Eingesetzte Manöver werden dabei berücksichtigt. Der Held kann seine Waffe nach den üblichen Regeln wiedererlangen (siehe Regelwerk Seite 239). Ist niemand in der Nähe, erleidet der Held bis zum Ende der nächsten KR eine Erschwernis von 3 auf AT.",
          );
        } else if (3 <= w20 && w20 <= 4) {
          return (
            "Waffe stecken geblieben",
            "Waffe steckt fest: Die Waffe des Helden ist in einem Baum, einer Holzwand, dem Boden oder Ähnlichem stecken geblieben. Um sie zu befreien, ist 1 Aktion und eine Probe auf Kraftakt (Ziehen & Zerren) notwendig.",
          );
        } else if (5 <= w20 && w20 <= 6) {
          return (
            "Waffe stecken geblieben",
            "Waffe steckt ziemlich fest: Die Waffe des Helden ist in einem Baum, einer Holzwand, dem Boden oder Ähnlichem stecken geblieben. Um sie zu befreien, ist 1 Aktion und eine um 1 erschwerte Probe auf Kraftakt (Ziehen & Zerren) notwendig.",
          );
        } else if (7 <= w20 && w20 <= 8) {
          return (
            "Waffe stecken geblieben",
            "Waffe steckt sehr tief fest: Die Waffe des Helden ist in einem Baum, einer Holzwand, dem Boden oder Ähnlichem stecken geblieben. Um sie zu befreien, ist 1 Aktion und eine um 2 erschwerte Probe auf Kraftakt (Ziehen & Zerren) notwendig.",
          );
        } else if (9 <= w20 && w20 <= 10) {
          return (
            "Waffe stecken geblieben",
            "Waffe steckt extrem tief fest: Die Waffe des Helden ist in einem Baum, einer Holzwand, dem Boden oder Ähnlichem stecken geblieben. Um sie zu befreien, sind 5 Aktionen und eine um 2 erschwerte Probe auf Kraftakt (Ziehen & Zerren) notwendig.",
          );
        } else if (11 <= w20 && w20 <= 12) {
          return (
            "Waffe stecken geblieben",
            "Waffe verbogen: Die Waffe des Helden ist in einem Baum, einer Holzwand, dem Boden oder Ähnlichem stecken geblieben. Um sie zu befreien, sind 1 Aktion und eine um 2 erschwerte Probe auf Kraftakt (Ziehen & Zerren) notwendig. Nach dem Befreien hat sie aber einen kleinen Schaden, der für eine Erschwernis von 1 auf AT und PA sorgt. Nach dem Kampf kann dieser Schaden behoben werden ohne dass eine Probe notwendig ist.",
          );
        } else if (13 <= w20 && w20 <= 14) {
          return (
            "Waffe stecken geblieben",
            "Waffe trifft Gefährten oder Unschuldigen: Die Waffe des Helden schwingt gegen einen Gefährten oder Unschuldigen. Dieser kann sofort eine VW einsetzen, um dem Treffer zu entgehen. Bei Misslingen erleidet er den vollen Waffenschaden. Alle eingesetzten Manöver werden dabei berücksichtigt. Ist niemand in der Nähe, erleidet der Held bis zum Ende der nächsten KR eine Erschwernis von 3 auf AT.",
          );
        } else if (15 <= w20 && w20 <= 20) {
          return ("Waffe stecken geblieben", "nochmal würfeln");
        } else {
          assert(false, "unreachable!");
          return ("This should not occur!", "This should not occur!");
        }

      case BotchedDefenseNoShield.sturz:
        if (1 <= w20 && w20 <= 2) {
          return (
            "Sturz",
            "Abgeräumt: Der Held erleidet den Zustand Liegend und zieht bis 1W3 seiner Gefährten, die zufällig bestimmt werden, ebenfalls zu Boden, sofern ihnen nicht eine Probe auf Körperbeherrschung (Balance) –2 gelingt. Sie erleiden ansonsten den Status Liegend. Sollten keine Gefährten in der unmittelbaren Nähe sein, erleidet der Held 1 Stufe Schmerz für 5 Minuten.",
          );
        } else if (3 <= w20 && w20 <= 4) {
          return (
            "Sturz",
            "Luftraubender Sturz: Der Held stolpert und stürzt, wenn seinem Spieler nicht eine um 3 erschwerte Probe auf Körperbeherrschung (Balance) gelingt. Sollte er das nicht schaffen, erhält der Held den Status Liegend, erleidet 1W6+2 SP und für 3 KR 1 Stufe Betäubung.",
          );
        } else if (5 <= w20 && w20 <= 6) {
          return (
            "Sturz",
            "Sehr schmerzhafter Sturz: Der Held stolpert und stürzt, wenn seinem Spieler nicht eine um 3 erschwerte Probe auf Körperbeherrschung (Balance) gelingt. Sollte er das nicht schaffen, erhält der Held den Status Liegend und verletzte sich beim Sturz mit 1W6+2 SP.",
          );
        } else if (7 <= w20 && w20 <= 8) {
          return (
            "Sturz",
            "Schmerzhafter Sturz: Der Held stolpert und stürzt, wenn seinem Spieler nicht eine um 2 erschwerte Probe auf Körperbeherrschung (Balance) gelingt. Sollte er das nicht schaffen, erhält der Held den Status Liegend und verletzte sich beim Sturz mit 1W6 SP.",
          );
        } else if (9 <= w20 && w20 <= 10) {
          return (
            "Sturz",
            "Gestürzt: Der Held stolpert und stürzt, wenn seinem Spieler nicht eine um 2 erschwerte Probe auf Körperbeherrschung (Balance) gelingt. Sollte er das nicht schaffen, erhält der Held den Status Liegend.",
          );
        } else if (11 <= w20 && w20 <= 12) {
          return (
            "Sturz",
            "Leichter Sturz: Der Held stolpert und stürzt, wenn seinem Spieler nicht eine um 1 erschwerte Probe auf Körperbeherrschung (Balance) gelingt. Sollte er das nicht schaffen, erhält der Held den Status Liegend.",
          );
        } else if (13 <= w20 && w20 <= 14) {
          return (
            "Sturz",
            "Harmloser Sturz: Der Held stolpert und stürzt, wenn seinem Spieler nicht eine Probe auf Körperbeherrschung (Balance) gelingt. Sollte er das nicht schaffen, erhält der Held den Status Liegend.",
          );
        } else if (15 <= w20 && w20 <= 16) {
          return (
            "Sturz",
            "Fehltritt: Der Held stolpert und stürzt, wenn seinem Spieler nicht eine erleichterte Probe auf Körperbeherrschung (Balance) +1 gelingt. Sollte er das nicht schaffen, erhält der Held den Status Liegend.",
          );
        } else if (17 <= w20 && w20 <= 20) {
          return ("Sturz", "nochmal würfeln");
        } else {
          assert(false, "unreachable!");
          return ("This should not occur!", "This should not occur!");
        }

      case BotchedDefenseNoShield.stolpern:
        if (1 <= w20 && w20 <= 2) {
          return (
            "Stolpern",
            "In die Waffe des Gegners gestolpert: Der Held stolpert in die Waffe des Gegners und erleidet den vollen Waffenschaden, zudem ist seine nächste Handlung um 2 erschwert.",
          );
        } else if (3 <= w20 && w20 <= 4) {
          return (
            "Stolpern",
            "Schwer gestolpert: Der Held stolpert, seine nächste Handlung ist um 3 erschwert.",
          );
        } else if (5 <= w20 && w20 <= 6) {
          return (
            "Stolpern",
            "MissgeschicDer Held verliert einen Gegenstand (außer seine Waffe), seine Hose rutscht herunter, oder er hängt irgendwo fest. Bis zum Ende der nächsten KR hat er eine Erschwernis von 2 auf alle Handlungen und er erleidet den Status Eingeengt und Fixiert.",
          );
        } else if (7 <= w20 && w20 <= 8) {
          return (
            "Stolpern",
            "Gestolpert: Der Held stolpert, seine nächste Handlung ist um 2 erschwert.",
          );
        } else if (9 <= w20 && w20 <= 10) {
          return (
            "Stolpern",
            "Schwer aus dem Gleichgewicht geraten: Der Held stolpert, sodass bis zum Ende der nächsten KR alle Gegner gegen ihn einen Bonus von 2 auf AT erhalten. Der Abenteurer bekommt aber keine Erschwernis für seine nächste Handlung.",
          );
        } else if (11 <= w20 && w20 <= 12) {
          return (
            "Stolpern",
            "Leicht gestolpert: Der Held stolpert, seine nächste Handlung ist um 1 erschwert.",
          );
        } else if (13 <= w20 && w20 <= 14) {
          return (
            "Stolpern",
            "Aus dem Gleichgewicht geraten: Der Held stolpert, sodass bis zum Ende der nächsten KR alle Gegner gegen ihn einen Bonus von 1 auf AT erhalten. Der Abenteurer bekommt aber keine Erschwernis für seine nächste Handlung.",
          );
        } else if (15 <= w20 && w20 <= 20) {
          return ("Stolpern", "nochmal würfeln");
        } else {
          assert(false, "unreachable!");
          return ("This should not occur!", "This should not occur!");
        }

      case BotchedDefenseNoShield.fussVerdreht:
        if (1 <= w20 && w20 <= 3) {
          return (
            "Fuß verdreht",
            "Fuß verdreht und überdehnt: Der Held erhält für 3 KR 2 Stufen Schmerz.",
          );
        } else if (4 <= w20 && w20 <= 6) {
          return (
            "Fuß verdreht",
            "Schlimm schmerzender Fuß: Der Held erhält für 5 KR 1 Stufe Schmerz.",
          );
        } else if (7 <= w20 && w20 <= 9) {
          return (
            "Fuß verdreht",
            "Schmerzender Fuß: Der Held erhält für 3 KR 1 Stufe Schmerz.",
          );
        } else if (10 <= w20 && w20 <= 12) {
          return (
            "Fuß verdreht",
            "Schwer verknackst: Der Held erleidet +2 TP, dafür aber keine Stufe Schmerz.",
          );
        } else if (13 <= w20 && w20 <= 15) {
          return (
            "Fuß verdreht",
            "Leicht schmerzender Fuß: Der Held erhält für 1 KR 1 Stufe Schmerz.",
          );
        } else if (16 <= w20 && w20 <= 18) {
          return (
            "Fuß verdreht",
            "Leicht verknackst: Der Held erleidet +1 TP, dafür aber keine Stufe Schmerz.",
          );
        } else if (19 <= w20 && w20 <= 20) {
          return ("Fuß verdreht", "nochmal würfeln");
        } else {
          assert(false, "unreachable!");
          return ("This should not occur!", "This should not occur!");
        }

      case BotchedDefenseNoShield.beule:
        if (1 <= w20 && w20 <= 5) {
          return (
            "Beule",
            "Große Beule: Der Held bekommt 2 Stufen Betäubung für 1 Stunde (statt 1 Stufe).",
          );
        } else if (6 <= w20 && w20 <= 10) {
          return (
            "Beule",
            "Blutende Beule: Der Held bekommt 1 Stufe Betäubung und den Status Blutend.",
          );
        } else if (11 <= w20 && w20 <= 15) {
          return (
            "Beule",
            "Kopfschmerzen: Der Held bekommt 1 Stufe Betäubung für 1 Stunde.",
          );
        } else if (16 <= w20 && w20 <= 20) {
          return (
            "Beule",
            "Leichte Kopfschmerzen: Der Held bekommt 1 StufeBetäubung für 2 KR.",
          );
        } else {
          assert(false, "unreachable!");
          return ("This should not occur!", "This should not occur!");
        }

      case BotchedDefenseNoShield.selbstVerletzt:
        if (1 <= w20 && w20 <= 20) {
          return (
            "Selbst verletzt",
            "Der Held hat sich selbst verletzt und erleidet Schaden. Der Schaden seiner Waffe wird unter Einbeziehung des Schadensbonus ausgewürfelt. Bei unbewaffneten Kämpfern wird 1W6 TP angenommen.",
          );
        } else {
          assert(false, "unreachable!");
          return ("This should not occur!", "This should not occur!");
        }

      case BotchedDefenseNoShield.selbstSchwerVerletzt:
        if (1 <= w20 && w20 <= 20) {
          return (
            "Selbst schwer verletzt",
            "Ein schwerer Eigentreffer des Helden. Der Schaden seiner Waffe wird unter Einbeziehung des Schadensbonus ausgewürfelt und dann verdoppelt. Bei unbewaffneten Kämpfern wird 1W6 TP angenommen.",
          );
        } else {
          assert(false, "unreachable!");
          return ("This should not occur!", "This should not occur!");
        }
    }
  }
}

enum BotchedDefenseShield implements RuleMixin {
  schildZerstoert(
    "Schild zerstört",
    "Der Schild ist unwiederbringlich zerstört. Bei unzerstörbaren Schilden wird das Ergebnis wie bei 5 behandelt.",
  ),
  schildSchwerBeschaedigt(
    "Schild schwer beschädigt",
    "Der Schild ist nicht mehr verwendbar, bis er repariert wird. Bei unzerstörbaren Schilden wird das Ergebnis wie bei 5 behandelt.",
  ),
  schildBeschaedigt(
    "Schild beschädigt",
    "Der Schild ist beschädigt worden. Alle Proben auf Attacke und Parade sind um 2 erschwert, bis er repariert wird. Bei unzerstörbaren Schilden wird das Ergebnis wie bei 5 behandelt.",
  ),
  schildVerloren("Schild verloren", "Der Schild ist zu Boden gefallen."),
  schildSteckenGeblieben(
    "Schild stecken geblieben",
    "Der Schild des Helden ist in einem Baum, einer Holzwand, dem Boden oder Ähnlichem stecken geblieben. Um ihn zu befreien, ist 1 Aktion und eine um 1 erschwerte Probe auf Kraftakt (Ziehen & Zerren) notwendig.",
  ),
  sturz(
    "Sturz",
    "Der Held stolpert und stürzt, wenn ihm nicht eine um 2 erschwerte Probe auf Körperbeherrschung (Balance) gelingt. Sollte er das nicht schaffen, erhält er den Status Liegend.",
  ),
  stolpern(
    "Stolpern",
    "Der Held stolpert, seine nächste Handlung ist um 2 erschwert.",
  ),
  fussVerdreht(
    "Fuß verdreht",
    "Der Held erhält für 3 Kampfrunden eine Stufe Schmerz.",
  ),
  beule(
    "Beule",
    "Der Held hat sich im Eifer des Gefechts den Kopf gestoßen. Er erhält eine Stufe Betäubung für eine Stunde.",
  ),
  selbstVerletzt(
    "Selbst verletzt",
    "Der Held hat sich selbst verletzt und erleidet Schaden. Der Schaden seiner Waffe wird unter Einbeziehung des Schadensbonus ausgewürfelt. Bei unbewaffneten Kämpfern wird 1W6 TP angenommen.",
  ),
  selbstSchwerVerletzt(
    "Selbst schwer verletzt",
    "Ein schwerer Eigentreffer des Helden. Der Schaden seiner Waffe wird unter Einbeziehung des Schadensbonus ausgewürfelt und dann verdoppelt. Bei unbewaffneten Kämpfern wird 1W6 TP angenommen.",
  );

  @override
  final String title;
  @override
  final String effect;
  const BotchedDefenseShield(this.title, this.effect);

  static BotchedDefenseShield from(int twoW6) {
    switch (twoW6) {
      case 2:
        return BotchedDefenseShield.schildZerstoert;

      case 3:
        return BotchedDefenseShield.schildSchwerBeschaedigt;

      case 4:
        return BotchedDefenseShield.schildBeschaedigt;

      case 5:
        return BotchedDefenseShield.schildVerloren;

      case 6:
        return BotchedDefenseShield.schildSteckenGeblieben;

      case 7:
        return BotchedDefenseShield.sturz;

      case 8:
        return BotchedDefenseShield.stolpern;

      case 9:
        return BotchedDefenseShield.fussVerdreht;

      case 10:
        return BotchedDefenseShield.beule;

      case 11:
        return BotchedDefenseShield.selbstVerletzt;

      case 12:
        return BotchedDefenseShield.selbstSchwerVerletzt;

      default:
        assert(false, "unreachable!");
        return BotchedDefenseShield.schildZerstoert;
    }
  }

  @override
  (String, String) normalRule() {
    return (
      "Patzer bei der Verteidigung!",
      "Der Held erhält 2W6 + 2 Schadenspunkte!",
    );
  }

  @override
  (String, String) focusRule(int w20) {
    switch (this) {
      case BotchedDefenseShield.schildZerstoert:
        if (1 <= w20 && w20 <= 10) {
          return (
            "Schild zerstört",
            "Waffe zerspringt in Einzelteile: Die Waffe kann nicht mehr repariert werden. Ihre Einzelteile treffen teilweise den Helden und verursachen 1W6 SP. Bei unzerstörbaren Waffen wird das Ergebnis wie Waffe verloren behandelt.",
          );
        } else if (11 <= w20 && w20 <= 20) {
          return (
            "Schild zerstört",
            "Waffe zerbrochen: Die Waffe ist zerbrochen. Die Probe, um sie zu reparieren ist um 3 erschwert, außerdem kostet die Reparatur 25 % des ursprünglichen Preises der Waffe. Bei unzerstörbaren Waffen wird das Ergebnis wie Waffe verloren behandelt.",
          );
        } else {
          assert(false, "unreachable!");
          return ("This should not occur!", "This should not occur!");
        }

      case BotchedDefenseShield.schildSchwerBeschaedigt:
        if (1 <= w20 && w20 <= 6) {
          return (
            "Schild schwer beschädigt",
            "Extrem schwere Beschädigung: Die Waffe ist nicht mehr verwendbar, bis sie repariert wird. Die Probe, um sie zu reparieren ist um 1 erschwert. Bei unzerstörbaren Waffen wird das Ergebnis wie Waffe verloren behandelt.",
          );
        } else if (7 <= w20 && w20 <= 12) {
          return (
            "Schild schwer beschädigt",
            "Waffe stark beschädigt: Die Waffe ist nicht mehr verwendbar, bis sie repariert wird. Bei unzerstörbaren Waffen wird das Ergebnis wie Waffe verloren behandelt.",
          );
        } else if (13 <= w20 && w20 <= 18) {
          return (
            "Schild schwer beschädigt",
            "Waffe kaum noch zu gebrauchen: Die Waffe ist zwar schwer beschädigt, aber noch einsetzbar. Alle Proben auf Attacke und Parade sind um 4 erschwert, bis sie repariert wird. Bei unzerstörbaren Waffen wird das Ergebnis wie Waffe verloren behandelt.",
          );
        } else if (19 <= w20 && w20 <= 20) {
          return ("Schild schwer beschädigt", "nochmal würfeln");
        } else {
          assert(false, "unreachable!");
          return ("This should not occur!", "This should not occur!");
        }

      case BotchedDefenseShield.schildBeschaedigt:
        if (1 <= w20 && w20 <= 5) {
          return (
            "Schild beschädigt",
            "Kratzer an der Waffe: Die Waffe hat einen Kratzer abbekommen, aber dies hat keine regeltechnischen Auswirkungen. Bei unzerstörbaren Waffen wird das Ergebnis wie Waffe verloren behandelt.",
          );
        } else if (6 <= w20 && w20 <= 10) {
          return (
            "Schild beschädigt",
            "Leicht beschädigte Waffe: Die Waffe ist beschädigt worden. Alle Proben auf Attacke und Parade sind um 1 erschwert, bis sie repariert wird. Bei unzerstörbaren Waffen wird das Ergebnis wie Waffe verloren behandelt.",
          );
        } else if (11 <= w20 && w20 <= 15) {
          return (
            "Schild beschädigt",
            "Beschädigte Waffe: Die Waffe ist beschädigt worden. Alle Proben auf Attacke und Parade sind um 2 erschwert, bis sie repariert wird. Bei unzerstörbaren Waffen wird das Ergebnis wie Waffe verloren behandelt.",
          );
        } else if (16 <= w20 && w20 <= 20) {
          return (
            "Schild beschädigt",
            "Schwer beschädigte Waffe: Die Waffe ist beschädigt worden. Alle Proben auf Attacke und Parade sind um 3 erschwert, bis sie repariert wird. Bei unzerstörbaren Waffen wird das Ergebnis wie Waffe verloren behandelt.",
          );
        } else {
          assert(false, "unreachable!");
          return ("This should not occur!", "This should not occur!");
        }

      case BotchedDefenseShield.schildVerloren:
        if (1 <= w20 && w20 <= 3) {
          return (
            "Schild verloren",
            "Waffe liegt weit weg und ungünstig: Die Waffe ist auf den Boden gefallen und muss nach den üblichen Regeln wieder aufgehoben werden (siehe Regelwerk Seite 239). Sie liegt 1W6+2 Schritt weit weg, sodass noch eine Bewegung ausgeführt werden muss, um sie zu erreichen. Außerdem hat sie sich an einem Objekt verhakt oder ist eingeklemmt und kann nur mit 1 Aktion und einer Probe auf Kraftakt (Ziehen & Zerren) befreit werden.",
          );
        } else if (4 <= w20 && w20 <= 6) {
          return (
            "Schild verloren",
            "Waffe weit weg: Die Waffe ist auf den Boden gefallen und muss nach den üblichen Regeln wieder aufgehoben werden (siehe Regelwerk Seite 239). Allerdings liegt sie 1W6+2 Schritt weit weg, sodass zusätzlich noch eine Bewegung ausgeführt werden muss, um sie zu erreichen.",
          );
        } else if (7 <= w20 && w20 <= 9) {
          return (
            "Schild verloren",
            "Waffe liegt ungünstig: Die Waffe ist auf den Boden gefallen und muss nach den üblichen Regeln wieder aufgehoben werden (siehe Regelwerk Seite 239). Allerdings ist die Probe um 2 erschwert.",
          );
        } else if (10 <= w20 && w20 <= 12) {
          return (
            "Schild verloren",
            "Waffe auf den Boden gefallen: Die Waffe ist auf den Boden gefallen und muss nach den üblichen Regeln wieder aufgehoben werden (siehe Regelwerk Seite 239).",
          );
        } else if (13 <= w20 && w20 <= 15) {
          return (
            "Schild verloren",
            "Waffe streift einen Gefährten oder Unschuldigen: Die Waffe ist auf den Boden gefallen, hat aber vorher einen vom Meister bestimmten Gefährten des Helden oder einen Unschuldigen fast getroffen, sodass dieser bis zum Ende der nächsten KR –3 auf VW aufweist. Ist niemand in der Nähe, erleidet der Held bis zum Ende der nächsten KR eine Erschwernis von 3 auf AT.",
          );
        } else if (16 <= w20 && w20 <= 18) {
          return (
            "Schild verloren",
            "Waffe liegt günstig: Die Waffe ist zwar auf den Boden gefallen und muss nach den üblichen Regeln wieder aufgehoben werden (siehe Regelwerk Seite 239), allerdings ist die Probe um 2 erleichtert.",
          );
        } else if (19 <= w20 && w20 <= 20) {
          return ("Schild verloren", "nochmal würfeln");
        } else {
          assert(false, "unreachable!");
          return ("This should not occur!", "This should not occur!");
        }

      case BotchedDefenseShield.schildSteckenGeblieben:
        if (1 <= w20 && w20 <= 2) {
          return (
            "Schild stecken geblieben",
            "Gefährten oder Unschuldigen verletzt: Die Waffe fliegt dem Helden aus der Hand und trifft einen Gefährten oder einen Unschuldigen. Dieser kann versuchen, sich mit einer Schilde-PA zu verteidigen oder ausweichen. Bei Misslingen erleidet er den vollen Waffenschaden. Eingesetzte Manöver werden dabei berücksichtigt. Der Held kann seine Waffe nach den üblichen Regeln wiedererlangen (siehe Regelwerk Seite 239). Ist niemand in der Nähe, erleidet der Held bis zum Ende der nächsten KR eine Erschwernis von 3 auf AT.",
          );
        } else if (3 <= w20 && w20 <= 4) {
          return (
            "Schild stecken geblieben",
            "Waffe steckt fest: Die Waffe des Helden ist in einem Baum, einer Holzwand, dem Boden oder Ähnlichem stecken geblieben. Um sie zu befreien, ist 1 Aktion und eine Probe auf Kraftakt (Ziehen & Zerren) notwendig.",
          );
        } else if (5 <= w20 && w20 <= 6) {
          return (
            "Schild stecken geblieben",
            "Waffe steckt ziemlich fest: Die Waffe des Helden ist in einem Baum, einer Holzwand, dem Boden oder Ähnlichem stecken geblieben. Um sie zu befreien, ist 1 Aktion und eine um 1 erschwerte Probe auf Kraftakt (Ziehen & Zerren) notwendig.",
          );
        } else if (7 <= w20 && w20 <= 8) {
          return (
            "Schild stecken geblieben",
            "Waffe steckt sehr tief fest: Die Waffe des Helden ist in einem Baum, einer Holzwand, dem Boden oder Ähnlichem stecken geblieben. Um sie zu befreien, ist 1 Aktion und eine um 2 erschwerte Probe auf Kraftakt (Ziehen & Zerren) notwendig.",
          );
        } else if (9 <= w20 && w20 <= 10) {
          return (
            "Schild stecken geblieben",
            "Waffe steckt extrem tief fest: Die Waffe des Helden ist in einem Baum, einer Holzwand, dem Boden oder Ähnlichem stecken geblieben. Um sie zu befreien, sind 5 Aktionen und eine um 2 erschwerte Probe auf Kraftakt (Ziehen & Zerren) notwendig.",
          );
        } else if (11 <= w20 && w20 <= 12) {
          return (
            "Schild stecken geblieben",
            "Waffe verbogen: Die Waffe des Helden ist in einem Baum, einer Holzwand, dem Boden oder Ähnlichem stecken geblieben. Um sie zu befreien, sind 1 Aktion und eine um 2 erschwerte Probe auf Kraftakt (Ziehen & Zerren) notwendig. Nach dem Befreien hat sie aber einen kleinen Schaden, der für eine Erschwernis von 1 auf AT und PA sorgt. Nach dem Kampf kann dieser Schaden behoben werden ohne dass eine Probe notwendig ist.",
          );
        } else if (13 <= w20 && w20 <= 14) {
          return (
            "Schild stecken geblieben",
            "Waffe trifft Gefährten oder Unschuldigen: Die Waffe des Helden schwingt gegen einen Gefährten oder Unschuldigen. Dieser kann sofort eine VW einsetzen, um dem Treffer zu entgehen. Bei Misslingen erleidet er den vollen Waffenschaden. Alle eingesetzten Manöver werden dabei berücksichtigt. Ist niemand in der Nähe, erleidet der Held bis zum Ende der nächsten KR eine Erschwernis von 3 auf AT.",
          );
        } else if (15 <= w20 && w20 <= 20) {
          return ("Schild stecken geblieben", "nochmal würfeln");
        } else {
          assert(false, "unreachable!");
          return ("This should not occur!", "This should not occur!");
        }

      case BotchedDefenseShield.sturz:
        if (1 <= w20 && w20 <= 2) {
          return (
            "Sturz",
            "Abgeräumt: Der Held erleidet den Zustand Liegend und zieht bis 1W3 seiner Gefährten, die zufällig bestimmt werden, ebenfalls zu Boden, sofern ihnen nicht eine Probe auf Körperbeherrschung (Balance) –2 gelingt. Sie erleiden ansonsten den Status Liegend. Sollten keine Gefährten in der unmittelbaren Nähe sein, erleidet der Held 1 Stufe Schmerz für 5 Minuten.",
          );
        } else if (3 <= w20 && w20 <= 4) {
          return (
            "Sturz",
            "Luftraubender Sturz: Der Held stolpert und stürzt, wenn seinem Spieler nicht eine um 3 erschwerte Probe auf Körperbeherrschung (Balance) gelingt. Sollte er das nicht schaffen, erhält der Held den Status Liegend, erleidet 1W6+2 SP und für 3 KR 1 Stufe Betäubung.",
          );
        } else if (5 <= w20 && w20 <= 6) {
          return (
            "Sturz",
            "Sehr schmerzhafter Sturz: Der Held stolpert und stürzt, wenn seinem Spieler nicht eine um 3 erschwerte Probe auf Körperbeherrschung (Balance) gelingt. Sollte er das nicht schaffen, erhält der Held den Status Liegend und verletzte sich beim Sturz mit 1W6+2 SP.",
          );
        } else if (7 <= w20 && w20 <= 8) {
          return (
            "Sturz",
            "Schmerzhafter Sturz: Der Held stolpert und stürzt, wenn seinem Spieler nicht eine um 2 erschwerte Probe auf Körperbeherrschung (Balance) gelingt. Sollte er das nicht schaffen, erhält der Held den Status Liegend und verletzte sich beim Sturz mit 1W6 SP.",
          );
        } else if (9 <= w20 && w20 <= 10) {
          return (
            "Sturz",
            "Gestürzt: Der Held stolpert und stürzt, wenn seinem Spieler nicht eine um 2 erschwerte Probe auf Körperbeherrschung (Balance) gelingt. Sollte er das nicht schaffen, erhält der Held den Status Liegend.",
          );
        } else if (11 <= w20 && w20 <= 12) {
          return (
            "Sturz",
            "Leichter Sturz: Der Held stolpert und stürzt, wenn seinem Spieler nicht eine um 1 erschwerte Probe auf Körperbeherrschung (Balance) gelingt. Sollte er das nicht schaffen, erhält der Held den Status Liegend.",
          );
        } else if (13 <= w20 && w20 <= 14) {
          return (
            "Sturz",
            "Harmloser Sturz: Der Held stolpert und stürzt, wenn seinem Spieler nicht eine Probe auf Körperbeherrschung (Balance) gelingt. Sollte er das nicht schaffen, erhält der Held den Status Liegend.",
          );
        } else if (15 <= w20 && w20 <= 16) {
          return (
            "Sturz",
            "Fehltritt: Der Held stolpert und stürzt, wenn seinem Spieler nicht eine erleichterte Probe auf Körperbeherrschung (Balance) +1 gelingt. Sollte er das nicht schaffen, erhält der Held den Status Liegend.",
          );
        } else if (17 <= w20 && w20 <= 20) {
          return ("Sturz", "nochmal würfeln");
        } else {
          assert(false, "unreachable!");
          return ("This should not occur!", "This should not occur!");
        }

      case BotchedDefenseShield.stolpern:
        if (1 <= w20 && w20 <= 2) {
          return (
            "Stolpern",
            "In die Waffe des Gegners gestolpert: Der Held stolpert in die Waffe des Gegners und erleidet den vollen Waffenschaden, zudem ist seine nächste Handlung um 2 erschwert.",
          );
        } else if (3 <= w20 && w20 <= 4) {
          return (
            "Stolpern",
            "Schwer gestolpert: Der Held stolpert, seine nächste Handlung ist um 3 erschwert.",
          );
        } else if (5 <= w20 && w20 <= 6) {
          return (
            "Stolpern",
            "MissgeschicDer Held verliert einen Gegenstand (außer seine Waffe), seine Hose rutscht herunter, oder er hängt irgendwo fest. Bis zum Ende der nächsten KR hat er eine Erschwernis von 2 auf alle Handlungen und er erleidet den Status Eingeengt und Fixiert.",
          );
        } else if (7 <= w20 && w20 <= 8) {
          return (
            "Stolpern",
            "Gestolpert: Der Held stolpert, seine nächste Handlung ist um 2 erschwert.",
          );
        } else if (9 <= w20 && w20 <= 10) {
          return (
            "Stolpern",
            "Schwer aus dem Gleichgewicht geraten: Der Held stolpert, sodass bis zum Ende der nächsten KR alle Gegner gegen ihn einen Bonus von 2 auf AT erhalten. Der Abenteurer bekommt aber keine Erschwernis für seine nächste Handlung.",
          );
        } else if (11 <= w20 && w20 <= 12) {
          return (
            "Stolpern",
            "Leicht gestolpert: Der Held stolpert, seine nächste Handlung ist um 1 erschwert.",
          );
        } else if (13 <= w20 && w20 <= 14) {
          return (
            "Stolpern",
            "Aus dem Gleichgewicht geraten: Der Held stolpert, sodass bis zum Ende der nächsten KR alle Gegner gegen ihn einen Bonus von 1 auf AT erhalten. Der Abenteurer bekommt aber keine Erschwernis für seine nächste Handlung.",
          );
        } else if (15 <= w20 && w20 <= 20) {
          return ("Stolpern", "nochmal würfeln");
        } else {
          assert(false, "unreachable!");
          return ("This should not occur!", "This should not occur!");
        }

      case BotchedDefenseShield.fussVerdreht:
        if (1 <= w20 && w20 <= 3) {
          return (
            "Fuß verdreht",
            "Fuß verdreht und überdehnt: Der Held erhält für 3 KR 2 Stufen Schmerz.",
          );
        } else if (4 <= w20 && w20 <= 6) {
          return (
            "Fuß verdreht",
            "Schlimm schmerzender Fuß: Der Held erhält für 5 KR 1 Stufe Schmerz.",
          );
        } else if (7 <= w20 && w20 <= 9) {
          return (
            "Fuß verdreht",
            "Schmerzender Fuß: Der Held erhält für 3 KR 1 Stufe Schmerz.",
          );
        } else if (10 <= w20 && w20 <= 12) {
          return (
            "Fuß verdreht",
            "Schwer verknackst: Der Held erleidet +2 TP, dafür aber keine Stufe Schmerz.",
          );
        } else if (13 <= w20 && w20 <= 15) {
          return (
            "Fuß verdreht",
            "Leicht schmerzender Fuß: Der Held erhält für 1 KR 1 Stufe Schmerz.",
          );
        } else if (16 <= w20 && w20 <= 18) {
          return (
            "Fuß verdreht",
            "Leicht verknackst: Der Held erleidet +1 TP, dafür aber keine Stufe Schmerz.",
          );
        } else if (19 <= w20 && w20 <= 20) {
          return ("Fuß verdreht", "nochmal würfeln");
        } else {
          assert(false, "unreachable!");
          return ("This should not occur!", "This should not occur!");
        }

      case BotchedDefenseShield.beule:
        if (1 <= w20 && w20 <= 5) {
          return (
            "Beule",
            "Große Beule: Der Held bekommt 2 Stufen Betäubung für 1 Stunde (statt 1 Stufe).",
          );
        } else if (6 <= w20 && w20 <= 10) {
          return (
            "Beule",
            "Blutende Beule: Der Held bekommt 1 Stufe Betäubung und den Status Blutend.",
          );
        } else if (11 <= w20 && w20 <= 15) {
          return (
            "Beule",
            "Kopfschmerzen: Der Held bekommt 1 Stufe Betäubung für 1 Stunde.",
          );
        } else if (16 <= w20 && w20 <= 20) {
          return (
            "Beule",
            "Leichte Kopfschmerzen: Der Held bekommt 1 StufeBetäubung für 2 KR.",
          );
        } else {
          assert(false, "unreachable!");
          return ("This should not occur!", "This should not occur!");
        }

      case BotchedDefenseShield.selbstVerletzt:
        if (1 <= w20 && w20 <= 20) {
          return (
            "Selbst verletzt",
            "Der Held hat sich selbst verletzt und erleidet Schaden. Der Schaden seiner Waffe wird unter Einbeziehung des Schadensbonus ausgewürfelt. Bei unbewaffneten Kämpfern wird 1W6 TP angenommen.",
          );
        } else {
          assert(false, "unreachable!");
          return ("This should not occur!", "This should not occur!");
        }

      case BotchedDefenseShield.selbstSchwerVerletzt:
        if (1 <= w20 && w20 <= 20) {
          return (
            "Selbst schwer verletzt",
            "Ein schwerer Eigentreffer des Helden. Der Schaden seiner Waffe wird unter Einbeziehung des Schadensbonus ausgewürfelt und dann verdoppelt. Bei unbewaffneten Kämpfern wird 1W6 TP angenommen.",
          );
        } else {
          assert(false, "unreachable!");
          return ("This should not occur!", "This should not occur!");
        }
    }
  }
}
