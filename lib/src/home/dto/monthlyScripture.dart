class MonthlyScripture {
  static const int TEXT_LIMIT = 56;
  static const String TITLE = 'Losung und Lehrtext';
  static const String SOURCE = 'https://www.losungen.de/die-losungen/';
  static const String _DEFAULT_OLD = 'Viele sagen: "Wer wird uns Gutes sehen lassen?" HERR, lass leuchten über uns das Licht deines Antlitzes! Psalm 4,7';
  static const String _DEFAULT_NEW =
      'Jesus spricht: Ich bin das Licht der Welt. Wer mir nachfolgt, der wird nicht wandeln in der Finsternis, sondern wird das Licht des Lebens haben. Johannes 8,12';

  String? oldTestamentText;
  String? newTestamentText;

  MonthlyScripture() {
    this.oldTestamentText = _DEFAULT_OLD;
    this.newTestamentText = _DEFAULT_NEW;
  }

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
