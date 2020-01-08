class MonthlyScripture {
  static const int TEXT_LIMIT = 56;
  static const String TITLE = 'Losung und Lehrtext';

  String oldTestamentText;
  String newTestamentText;

  MonthlyScripture({this.oldTestamentText, this.newTestamentText});

  String getModifiedText() {
    return newTestamentText.length > TEXT_LIMIT
        ? "${newTestamentText.substring(0, TEXT_LIMIT)}..."
        : newTestamentText.length > 2 ? newTestamentText : '';
  }
}
