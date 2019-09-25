class CustomCard {
  String _title;
  List _subtitle;
  String _custom;

  CustomCard(this._title, this._subtitle, [this._custom]);

  String get custom => _custom;

  String get subtitle => _subtitle.join(" | ");

  String get title => _title;

  List get subtitleList => _subtitle;
}
