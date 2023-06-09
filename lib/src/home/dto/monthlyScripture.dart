class MonthlyScripture {
  static const int TEXT_LIMIT = 56;
  static const String TITLE = 'Losung und Lehrtext';
  static const String SOURCE = 'https://www.losungen.de/die-losungen/';

  String? oldTestamentText;
  String? newTestamentText;

  MonthlyScripture({this.oldTestamentText, this.newTestamentText});

  String getModifiedText() {
    final String? modifiedText = oldTestamentText != null && oldTestamentText!.length > TEXT_LIMIT
        ? "${oldTestamentText!.substring(0, TEXT_LIMIT)}..."
        : oldTestamentText != null && oldTestamentText!.length > 2
            ? oldTestamentText
            : '';

    return modifiedText ?? '';
  }

  String getSharableContent() {
    return "$TITLE\n"
        "$oldTestamentText\n"
        "$newTestamentText\n\n"
        "Quelle: $SOURCE";
  }
}
