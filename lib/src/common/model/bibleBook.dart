class BibleBook {
  String _name;

  static const String _PSALM = 'Psalm';

  static const Map<String, String> MAPPER = <String, String>{
    _PSALM: 'Ps.',
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
