class Intercession {
  static const String NAME = 'Fürbitte';
  static const String IMAGE = 'assets/images/gebet.jpg';
  static const String HEADER = 'Lasst uns beten für ...';
  static const String EMAIL_NAME = 'Gebetswunsch';
  static const String EMAIL = 'gebetswunsch@app.skg-hagen.de';
  static const String PLACEHOLDER = 'Gebetswunsch hier eingeben';
  static const String FOOTER = 'Der Gebetswunsch wird an die Pastoren der Gemeinde weitergeleitet.';
  static const String SUCCESS = 'Gebetswunsch wurde erfolgreich übermittelt.';
  static const String ERROR = 'Gebetswunsch wurde nicht erfolgreich übermittelt. Versenden Sie bitte Ihren Gebetswunsch alternativ per Mail.';
  static const String EMAIL_TEXT = 'Alternativ versenden Sie Ihren Gebetswunsch bitte per Mail.';

  final String intercession;

  Intercession({this.intercession});

  Map<String, dynamic> toJson() => <String, dynamic>{
        "intercession": intercession,
      };
}
