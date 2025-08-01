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

const Map<String, Spell> spellsById = {
  "SPELL_1": Spell.adlerauge,
  "SPELL_2": Spell.analysArkanstruktur,
  "SPELL_3": Spell.armatrutz,
  "SPELL_4": Spell.axxeleratus,
  "SPELL_5": Spell.balsamSalabunde,
  "SPELL_6": Spell.bannbaladin,
  "SPELL_7": Spell.blickInDieGedanken,
  "SPELL_8": Spell.blitzDichFind,
  "SPELL_9": Spell.corpofesso,
  "SPELL_10": Spell.disruptivo,
  "SPELL_11": Spell.duplicatus,
  "SPELL_12": Spell.falkenauge,
  "SPELL_13": Spell.flimFlam,
  "SPELL_14": Spell.fulminictus,
  "SPELL_15": Spell.gardianum,
  "SPELL_16": Spell.grosseGier,
  "SPELL_17": Spell.harmloseGestalt,
  "SPELL_18": Spell.hexengalle,
  "SPELL_19": Spell.hexenkrallen,
  "SPELL_20": Spell.horriphobus,
  "SPELL_21": Spell.ignifaxius,
  "SPELL_22": Spell.invocatioMinima,
  "SPELL_23": Spell.katzenaugen,
  "SPELL_24": Spell.kroetensprung,
  "SPELL_25": Spell.manifesto,
  "SPELL_26": Spell.manusMiracula,
  "SPELL_27": Spell.motoricus,
  "SPELL_28": Spell.nebelwand,
  "SPELL_29": Spell.oculusIllusionis,
  "SPELL_30": Spell.odemArcanum,
  "SPELL_31": Spell.paralysis,
  "SPELL_32": Spell.penetrizzel,
  "SPELL_33": Spell.psychostabilis,
  "SPELL_34": Spell.radau,
  "SPELL_35": Spell.respondami,
  "SPELL_36": Spell.salander,
  "SPELL_37": Spell.sanftmut,
  "SPELL_38": Spell.satuariasHerrlichkeit,
  "SPELL_39": Spell.silentium,
  "SPELL_40": Spell.somnigravis,
  "SPELL_41": Spell.spinnenlauf,
  "SPELL_42": Spell.spurlos,
  "SPELL_43": Spell.transversalis,
  "SPELL_44": Spell.visibili,
  "SPELL_45": Spell.wasseratem,
  "SPELL_46": Spell.arcanovi,
  "SPELL_47": Spell.dschinnenruf,
  "SPELL_48": Spell.elementarerDiener,
  "SPELL_49": Spell.invocatioMaior,
  "SPELL_50": Spell.invocatioMinor,
  "SPELL_51": Spell.zauberklingeGeisterspeer,
  "SPELL_68": Spell.aengsteLindern,
  "SPELL_69": Spell.atemnot,
  "SPELL_70": Spell.attributoKoerperkraft,
  "SPELL_71": Spell.claudibus,
  "SPELL_72": Spell.corpofrigo,
  "SPELL_73": Spell.dunkelheit,
  "SPELL_74": Spell.ecliptifactus,
  "SPELL_75": Spell.grosseVerwirrung,
  "SPELL_76": Spell.herrUeberDasTierreich,
  "SPELL_77": Spell.hexenholz,
  "SPELL_78": Spell.hexenknoten,
  "SPELL_79": Spell.hoellenpein,
  "SPELL_80": Spell.ignisphaero,
  "SPELL_81": Spell.klarumPurum,
  "SPELL_82": Spell.pestilenzErspueren,
  "SPELL_83": Spell.schlangenruf,
  "SPELL_84": Spell.sensibar,
  "SPELL_85": Spell.sumusElixiere,
  "SPELL_86": Spell.vipernblick,
  "SPELL_87": Spell.zungeBetaeuben,
  "SPELL_88": Spell.zwingtanz,
  "SPELL_89": Spell.ablativum,
  "SPELL_90": Spell.abvenenum,
  "SPELL_91": Spell.adlerschwinge,
  "SPELL_92": Spell.aeolito,
  "SPELL_93": Spell.alpgestalt,
  "SPELL_94": Spell.altisonus,
  "SPELL_95": Spell.angstAusloesen,
  "SPELL_96": Spell.archofaxius,
  "SPELL_97": Spell.archosphaero,
  "SPELL_98": Spell.aromatisIllusionis,
  "SPELL_99": Spell.attributoCharisma,
  "SPELL_100": Spell.attributoFingerfertigkeit,
  "SPELL_101": Spell.attributoKlugheit,
  "SPELL_102": Spell.aufwecken,
  "SPELL_103": Spell.augeDesLimbus,
  "SPELL_104": Spell.aureolus,
  "SPELL_105": Spell.aurisIllusionis,
  "SPELL_106": Spell.bandUndFessel,
  "SPELL_107": Spell.blickAufsWesen,
  "SPELL_108": Spell.blindheit,
  "SPELL_109": Spell.chamaelioni,
  "SPELL_110": Spell.daemonenbann,
  "SPELL_111": Spell.daemonenschild,
  "SPELL_112": Spell.debilitatio,
  "SPELL_113": Spell.desintegratus,
  "SPELL_114": Spell.einflussbann,
  "SPELL_115": Spell.eisenrost,
  "SPELL_116": Spell.elementarbann,
  "SPELL_117": Spell.elfenstimme,
  "SPELL_118": Spell.erinnerungVerlasseDich,
  "SPELL_119": Spell.exposami,
  "SPELL_120": Spell.favilludo,
  "SPELL_121": Spell.fischflosse,
  "SPELL_122": Spell.foramen,
  "SPELL_123": Spell.fortifex,
  "SPELL_124": Spell.gedankenbilder,
  "SPELL_125": Spell.gefunden,
  "SPELL_126": Spell.haselbusch,
  "SPELL_127": Spell.heilungsbann,
  "SPELL_128": Spell.hellsichtbann,
  "SPELL_129": Spell.heptagramma,
  "SPELL_130": Spell.herzschlagRuhe,
  "SPELL_131": Spell.hexagramma,
  "SPELL_132": Spell.ignorantia,
  "SPELL_133": Spell.illusionsbann,
  "SPELL_134": Spell.imperavi,
  "SPELL_135": Spell.impersona,
  "SPELL_136": Spell.incendio,
  "SPELL_137": Spell.invercano,
  "SPELL_138": Spell.karnifilo,
  "SPELL_139": Spell.kusch,
  "SPELL_140": Spell.lastDesAlters,
  "SPELL_141": Spell.lungeDesLeviatan,
  "SPELL_142": Spell.manusIllusionis,
  "SPELL_143": Spell.memorans,
  "SPELL_144": Spell.menetekel,
  "SPELL_145": Spell.nuntiovolo,
  "SPELL_146": Spell.objectobscuro,
  "SPELL_147": Spell.objectofixo,
  "SPELL_148": Spell.objektbann,
  "SPELL_149": Spell.oculusAstralis,
  "SPELL_150": Spell.orcanofaxius,
  "SPELL_151": Spell.orcanosphaero,
  "SPELL_152": Spell.pentagramma,
  "SPELL_153": Spell.physiostabilis,
  "SPELL_154": Spell.plumbumbarum,
  "SPELL_155": Spell.projectimago,
  "SPELL_156": Spell.reflectimago,
  "SPELL_157": Spell.regeneratio,
  "SPELL_158": Spell.sapefacta,
  "SPELL_159": Spell.schmerzenLindern,
  "SPELL_160": Spell.schwarzUndRot,
  "SPELL_161": Spell.schwarzerSchrecken,
  "SPELL_162": Spell.skelettarius,
  "SPELL_163": Spell.solidirid,
  "SPELL_164": Spell.taubheit,
  "SPELL_165": Spell.telekinesebann,
  "SPELL_166": Spell.tiergedanken,
  "SPELL_167": Spell.verwandlungsbann,
  "SPELL_168": Spell.vogelzwitschern,
  "SPELL_169": Spell.wolfstatze,
  "SPELL_170": Spell.caldofrigo,
  "SPELL_171": Spell.nihilogravo,
  "SPELL_172": Spell.accuratum,
  "SPELL_173": Spell.hagelschlagUndSturmgebruell,
  "SPELL_174": Spell.hartesSchmelze,
  "SPELL_175": Spell.leidensbund,
  "SPELL_176": Spell.magischerRaub,
  "SPELL_177": Spell.memorabiaFalsifir,
  "SPELL_178": Spell.movimento,
  "SPELL_179": Spell.ruheKoerper,
  "SPELL_180": Spell.unberuehrtVonSatinav,
  "SPELL_181": Spell.widerwille,
  "SPELL_182": Spell.wirbelform,
  "SPELL_183": Spell.xenographus,
  "SPELL_234": Spell.affenarme,
  "SPELL_235": Spell.affenruf,
  "SPELL_236": Spell.arachnea,
  "SPELL_237": Spell.attributoGewandheit,
  "SPELL_238": Spell.attributoIntuition,
  "SPELL_239": Spell.attributoMut,
  "SPELL_240": Spell.attributoKonstitution,
  "SPELL_241": Spell.avilea,
  "SPELL_242": Spell.basaltleib,
  "SPELL_243": Spell.brandungsleib,
  "SPELL_244": Spell.brennenderHass,
  "SPELL_245": Spell.daemonischesVergessen,
  "SPELL_246": Spell.drachenleib,
  "SPELL_247": Spell.eichenleib,
  "SPELL_248": Spell.eigeneAengste,
  "SPELL_249": Spell.eigeneDummheit,
  "SPELL_250": Spell.eispfeil,
  "SPELL_251": Spell.erzpfeil,
  "SPELL_252": Spell.eulenruf,
  "SPELL_253": Spell.federleib,
  "SPELL_254": Spell.feenstaub,
  "SPELL_255": Spell.feuerpfeil,
  "SPELL_256": Spell.firnlauf,
  "SPELL_257": Spell.flammenwand,
  "SPELL_258": Spell.fledermausruf,
  "SPELL_259": Spell.frostleib,
  "SPELL_260": Spell.geisteressenz,
  "SPELL_261": Spell.gifthaut,
  "SPELL_262": Spell.glutlauf,
  "SPELL_263": Spell.hexenspeichel,
  "SPELL_264": Spell.hilfreichePfote,
  "SPELL_265": Spell.hilfreicheSchwinge,
  "SPELL_266": Spell.hilfreicheTatze,
  "SPELL_267": Spell.himmelslauf,
  "SPELL_268": Spell.hornissenruf,
  "SPELL_269": Spell.humuspfeil,
  "SPELL_270": Spell.katzenruf,
  "SPELL_271": Spell.krabbelnderSchrecken,
  "SPELL_272": Spell.kraehenruf,
  "SPELL_273": Spell.kraftDesTieres,
  "SPELL_274": Spell.kulminatio,
  "SPELL_275": Spell.levthansFeuer,
  "SPELL_276": Spell.luftpfeil,
  "SPELL_277": Spell.malDerErschoepfung,
  "SPELL_278": Spell.malDerSchwaeche,
  "SPELL_279": Spell.objectovoco,
  "SPELL_280": Spell.pandaemonium,
  "SPELL_281": Spell.pestodem,
  "SPELL_282": Spell.reptilea,
  "SPELL_283": Spell.sanfterFall,
  "SPELL_284": Spell.schlechteAusstrahlung,
  "SPELL_285": Spell.schleierDerUnwissenheit,
  "SPELL_286": Spell.seelentierErkennen,
  "SPELL_287": Spell.seidenzunge,
  "SPELL_288": Spell.serpentialis,
  "SPELL_289": Spell.spinnenruf,
  "SPELL_290": Spell.standfest,
  "SPELL_291": Spell.steinwand,
  "SPELL_292": Spell.tiereBesprechen,
  "SPELL_293": Spell.unentflammbarkeit,
  "SPELL_294": Spell.ungeschickt,
  "SPELL_295": Spell.verunsicherung,
  "SPELL_296": Spell.wasserpfeil,
  "SPELL_297": Spell.weichesErstarre,
  "SPELL_298": Spell.welleDerReinigung,
  "SPELL_299": Spell.welleDesSchmerzes,
  "SPELL_300": Spell.wellenlauf,
  "SPELL_301": Spell.wipfellauf,
  "SPELL_302": Spell.wuestenlauf,
  "SPELL_303": Spell.zauberpferdHerbeirufen,
  "SPELL_304": Spell.adamantium,
  "SPELL_305": Spell.animatio,
  "SPELL_306": Spell.bandDerFreundschaft,
  "SPELL_307": Spell.baerenruhe,
  "SPELL_308": Spell.blickInDieVergangenheit,
  "SPELL_309": Spell.brandform,
  "SPELL_310": Spell.custodosigil,
  "SPELL_311": Spell.destructibo,
  "SPELL_312": Spell.einsMitDerNatur,
  "SPELL_313": Spell.ergebenheitDerWogen,
  "SPELL_314": Spell.erhabenheitDesMarmors,
  "SPELL_315": Spell.felsenform,
  "SPELL_316": Spell.freiheitDerWolken,
  "SPELL_317": Spell.geisterruf,
  "SPELL_318": Spell.geisterbeschwoerung,
  "SPELL_319": Spell.gletscherform,
  "SPELL_320": Spell.klarheitDesEises,
  "SPELL_321": Spell.koerperloseReise,
  "SPELL_322": Spell.madasSpiegel,
  "SPELL_323": Spell.nekropathia,
  "SPELL_324": Spell.pflanzenform,
  "SPELL_325": Spell.reinheitDerLohe,
  "SPELL_326": Spell.rufDerFeenwesen,
  "SPELL_327": Spell.seelenwanderung,
  "SPELL_328": Spell.standhafterWaechter,
  "SPELL_329": Spell.transmutare,
  "SPELL_330": Spell.traumgestalt,
  "SPELL_331": Spell.ueberlegenerKrieger,
  "SPELL_332": Spell.weisheitDerBaeume,
  "SPELL_334": Spell.wogenform,
  "SPELL_335": Spell.zaubernahrung,
  "SPELL_336": Spell.zauberschnurren,
  "SPELL_337": Spell.zauberwesenDerNatur,
  "SPELL_338": Spell.zauberzwang,
  "SPELL_386": Spell.begehrenErzeugen,
  "SPELL_387": Spell.brustformung,
  "SPELL_388": Spell.erregungSpueren,
  "SPELL_389": Spell.feuchteErregung,
  "SPELL_391": Spell.penisformung,
  "SPELL_392": Spell.spielzeugDerLust,
  "SPELL_393": Spell.vaginaformung,
  "SPELL_394": Spell.verlangenKontrollieren,
  "SPELL_395": Spell.abneigungenUndVorliebenErzeugen,
  "SPELL_396": Spell.begierdeAusloesen,
  "SPELL_397": Spell.uebertragungDerLiebeskuenste,
  "SPELL_402": Spell.daemonenpaktBeenden,
  "SPELL_403": Spell.aquafaxius,
  "SPELL_404": Spell.aquasphaero,
  "SPELL_405": Spell.auraDerErschoepfung,
  "SPELL_406": Spell.blitzball,
  "SPELL_407": Spell.boeserBlick,
  "SPELL_408": Spell.dornenwand,
  "SPELL_409": Spell.eiswand,
  "SPELL_410": Spell.erschoepfungenLindern,
  "SPELL_411": Spell.fesselfeld,
  "SPELL_412": Spell.frigifaxius,
  "SPELL_413": Spell.frigisphaero,
  "SPELL_414": Spell.halluzination,
  "SPELL_415": Spell.humofaxius,
  "SPELL_416": Spell.humosphaero,
  "SPELL_417": Spell.invinculo,
  "SPELL_418": Spell.nebelform,
  "SPELL_419": Spell.oktagramma,
  "SPELL_420": Spell.panikUeberkommeEuch,
  "SPELL_421": Spell.schimmernderSchild,
  "SPELL_422": Spell.schuppenhaut,
  "SPELL_423": Spell.sphaerenbann,
  "SPELL_424": Spell.sinesigil,
  "SPELL_425": Spell.sensattacco,
  "SPELL_426": Spell.stillstand,
  "SPELL_427": Spell.sturmDerVerunsicherung,
  "SPELL_428": Spell.sturmwand,
  "SPELL_429": Spell.temporalbann,
  "SPELL_430": Spell.tempusStasis,
  "SPELL_431": Spell.wellenwand,
  "SPELL_432": Spell.wogeDerVersteinerung,
  "SPELL_433": Spell.zornDerElemente,
  "SPELL_434": Spell.zweifelSchueren,
  "SPELL_435": Spell.applicatus,
  "SPELL_436": Spell.blickDurchFremdeAugen,
  "SPELL_437": Spell.chimaeroform,
  "SPELL_438": Spell.chronoklassis,
  "SPELL_439": Spell.chrononautos,
  "SPELL_440": Spell.gefaessDerJahre,
  "SPELL_441": Spell.immortalisLebenszeit,
  "SPELL_442": Spell.invocatioMaxima,
  "SPELL_443": Spell.infinitumImmerdar,
  "SPELL_444": Spell.meisterDerElemente,
  "SPELL_445": Spell.lawinenfallUndTruemmerfeld,
  "SPELL_446": Spell.planastrale,
  "SPELL_447": Spell.steinWandle,
  "SPELL_448": Spell.totesHandle,
  "SPELL_483": Spell.zitterfinger,
};

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
