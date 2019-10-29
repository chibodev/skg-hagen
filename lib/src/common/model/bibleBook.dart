class BibleBook {
  String _name;

  static const String _1MOSE = "1. Mose";
  static const String _2MOSE = "2. Mose";
  static const String _3MOSE = "3. Mose";
  static const String _4MOSE = "4. Mose";
  static const String _5MOSE = "5. Mose";
  static const String _JOSUA = "Josua";
  static const String _RICHTER = "Richter";
  static const String _RUTH = "Ruth";
  static const String _1SAMUEL = "1. Samuel";
  static const String _2SAMUEL = "2. Samuel";
  static const String _1KOENIGE = "1. Könige";
  static const String _2KOENIGE = "2. Könige";
  static const String _1CHRONIK = "1. Chronik";
  static const String _2CHRONIK = "2. Chronik";
  static const String _ESRA = "Esra";
  static const String _NEHEMIA = "Nehemia";
  static const String _ESTHER = "Esther";
  static const String _HIOB = "Hiob";
  static const String _PSALMEN = "Psalmen";
  static const String _SPRUECHE = "Sprüche";
  static const String _PREDIGER = "Prediger (Kohelet)";
  static const String _HOHELIED = "Hohelied";
  static const String _JESAJA = "Jesaja";
  static const String _JEREMIA = "Jeremia";
  static const String _KLAGELIEDER = "Klagelieder";
  static const String _HESEKIEL = "Hesekiel";
  static const String _DANIEL = "Daniel";
  static const String _HOSEA = "Hosea";
  static const String _JOEL = "Joel";
  static const String _AMOS = "Amos";
  static const String _OBADJA = "Obadja";
  static const String _JONA = "Jona";
  static const String _MICHA = "Micha";
  static const String _NAHUM = "Nahum";
  static const String _HABAKUK = "Habakuk";
  static const String _ZEPHANJA = "Zephanja";
  static const String _HAGGAI = "Haggai";
  static const String _SACHARJA = "Sacharja";
  static const String _MALEACHI = "Maleachi";
  static const String _MATTHAEUS = "Matthäus";
  static const String _MARKUS = "Markus";
  static const String _LUKAS = "Lukas";
  static const String _JOHANNES = "Johannes";
  static const String _APOSTELGESCHICHTE = "Apostelgeschichte";
  static const String _ROEMER = "Römer";
  static const String _1KORINTHER = "1. Korinther";
  static const String _2KORINTHER = "2. Korinther";
  static const String _GALATER = "Galater";
  static const String _EPHESER = "Epheser";
  static const String _PHILIPPER = "Philipper";
  static const String _KOLOSSER = "Kolosser";
  static const String _1THESSALONICHER = "1. Thessalonicher";
  static const String _2THESSALONICHER = "2. Thessalonicher";
  static const String _1TIMOTHEUS = "1. Timotheus";
  static const String _2TIMOTHEUS = "2. Timotheus";
  static const String _TITUS = "Titus";
  static const String _PHILEMON = "Philemon";
  static const String _1PETRUS = "1. Petrus";
  static const String _2PETRUS = "2. Petrus";
  static const String _1JOHANNES = "1. Johannes";
  static const String _2JOHANNES = "2. Johannes";
  static const String _3JOHANNES = "3. Johannes";
  static const String _HEBRAEER = "Hebräer";
  static const String _JAKOBUS = "Jakobus";
  static const String _JUDAS = "Judas";
  static const String _OFFENBARUNG = "Offenbarung";

  static const Map<String, String> MAPPER = <String, String>{
    _1MOSE: "1. Mos",
    _2MOSE: "2. Mos",
    _3MOSE: "3. Mos",
    _4MOSE: "4. Mos",
    _5MOSE: "5. Mos",
    _JOSUA: "Jos",
    _RICHTER: "Ri",
    _RUTH: "Ru",
    _1SAMUEL: "1. Sam",
    _2SAMUEL: "2. Sam",
    _1KOENIGE: "1. Kön",
    _2KOENIGE: "2. Kön",
    _1CHRONIK: "1. Chr",
    _2CHRONIK: "2. Chr",
    _ESRA: "Esra",
    _NEHEMIA: "Neh",
    _ESTHER: "Est",
    _HIOB: "Hi",
    _PSALMEN: "Ps",
    _SPRUECHE: "Spr",
    _PREDIGER: "Pred",
    _HOHELIED: "Hld",
    _JESAJA: "Jes",
    _JEREMIA: "Jer",
    _KLAGELIEDER: "Klgl",
    _HESEKIEL: "Hes",
    _DANIEL: "Dan",
    _HOSEA: "Hos",
    _JOEL: "Joel",
    _AMOS: "Am",
    _OBADJA: "Obd",
    _JONA: "Jona",
    _MICHA: "Mi",
    _NAHUM: "Nah",
    _HABAKUK: "Hab",
    _ZEPHANJA: "Zep",
    _HAGGAI: "Hag",
    _SACHARJA: "Sach",
    _MALEACHI: "Mal",
    _MATTHAEUS: "Ma",
    _MARKUS: "Mk",
    _LUKAS: "Lk",
    _JOHANNES: "Joh",
    _APOSTELGESCHICHTE: "Apg",
    _ROEMER: "ROEm",
    _1KORINTHER: "1. Kor",
    _2KORINTHER: "2. Kor",
    _GALATER: "Gal",
    _EPHESER: "Eph",
    _PHILIPPER: "Phil",
    _KOLOSSER: "Kol",
    _1THESSALONICHER: "1. Thes",
    _2THESSALONICHER: "2. Thes",
    _1TIMOTHEUS: "1. Tim",
    _2TIMOTHEUS: "2. Tim",
    _TITUS: "Tit",
    _PHILEMON: "Phlm",
    _1PETRUS: "1. Pet",
    _2PETRUS: "2. Pet",
    _1JOHANNES: "1. Joh",
    _2JOHANNES: "2. Joh",
    _3JOHANNES: "3. Joh",
    _HEBRAEER: "Hebr",
    _JAKOBUS: "Jak",
    _JUDAS: "Jud",
    _OFFENBARUNG: "Offb",
  };

  BibleBook(String name) {
    if (!MAPPER.keys.contains(name)) {
      throw 'unknown bible chaper $name given';
    }

    _name = name;
  }

  String getAbbreviation() {
    return MAPPER[_name];
  }
}
