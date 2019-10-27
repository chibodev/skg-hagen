class CardContent {
  String _title;
  List _subtitle;
  String _custom;
  String _routeName;

  CardContent(this._title, this._subtitle, this._routeName, [this._custom]);

  String get custom => _custom;

  List get subtitle => _subtitle;

  String get joinedSubtitle => _subtitle.join(" | ");

  String get title => _title;

  List get subtitleList => _subtitle;

  String get routeName => _routeName;
}
