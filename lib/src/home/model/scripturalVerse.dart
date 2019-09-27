class ScripturalVerse {

  String _text;
  String _book;
  int _chapter;
  int _verse;

  ScripturalVerse(this._text, this._book, this._chapter, this._verse);

  int get verse => _verse;

  int get chapter => _chapter;

  String get book => _book;

  String get text => _text;
}