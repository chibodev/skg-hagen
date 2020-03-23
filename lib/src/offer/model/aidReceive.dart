class AidReceive {
  String title;
  String description;
  String phone;
  String email;

  static const String NAME = 'Hilfe-Suchende';
  static const String HELP = 'assets/images/icon/help.png';

  AidReceive({
    this.title,
    this.phone,
    this.email,
    this.description,
  });

  factory AidReceive.fromJson(dynamic json) => AidReceive(
        title:
            json["title"] == "" || json["title"] == null ? null : json["title"],
        description: json["description"] == "" || json["description"] == null
            ? null
            : json["description"],
        phone:
            json["phone"] == "" || json["phone"] == null ? null : json["phone"],
        email:
            json["email"] == "" || json["email"] == null ? null : json["email"],
      );
}
