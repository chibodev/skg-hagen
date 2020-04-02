class AidOffer {
  String title;
  String description;
  String phone;
  String email;

  static const String NAME = 'Helfer';
  static const String VOLUNTEER = 'assets/images/icon/volunteer.png';
  static const String SUCCESS = 'Die Daten wurden erfolgreich übermittelt.';
  static const String ERROR =
      'Die Daten wurden nicht erfolgreich übermittelt. Versende diese bitte per E-Mail.';
  static const String INCOMPLETE = 'BITTE vollständig aussfüllen';
  static const String EMAIL_TEXT = 'Alternativ deine Daten per Mail versenden.';
  static const String EMAIL_BODY = 'Liebes Gemeindemanagement! \n\nWas ich übernehmen könnte\n'
      '- Einkäufe im Lebensmittelgeschäft, in der Drogerie oder Apotheke - Ja/Nein\n'
      '- andere kleine Besorgungen - Ja/Nein\n'
      '- mit dem Hund raus gehen - Ja/Nein\n\n'
      'Über mich\n'
      '- Name:  \n'
      '- Alter:  \n'
      '- Wohnort (Ortteil):  \n'
      '- Sie erreichen mich:  \n'
      '- Ich möchte gern helfen, weil:  \n\n'
      'Mit freundlichen Grüßen';

  AidOffer({
    this.title,
    this.phone,
    this.email,
    this.description,
  });

  factory AidOffer.fromJson(dynamic json) =>
      AidOffer(
        title:
        json["title"] == "" || json["title"] == null ? null : json["title"],
        description: json["description"] == "" || json["description"] == null
            ? null
            : json["description"],
        phone:
        json["phone"] == "" || json["phone"] == null ? null : json["phone"].toString().trim(),
        email:
        json["email"] == "" || json["email"] == null ? null : json["email"].toString().trim(),
      );
}
