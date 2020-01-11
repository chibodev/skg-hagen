class MonthlyScripture {
  static const int TEXT_LIMIT = 56;
  static const String TITLE = 'Losung und Lehrtext';

  String oldTestamentText;
  String newTestamentText;

  MonthlyScripture({this.oldTestamentText, this.newTestamentText});

  String getModifiedText() {
    return oldTestamentText.length > TEXT_LIMIT
        ? "${oldTestamentText.substring(0, TEXT_LIMIT)}..."
        : oldTestamentText.length > 2 ? oldTestamentText : '';
  }
}
