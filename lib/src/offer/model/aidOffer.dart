class AidOffer {
  String title;
  String description;
  String phone;
  String email;

  static const String NAME = 'Helfer';
  static const String VOLUNTEER = 'assets/images/icon/volunteer.png';

  AidOffer({
    this.title,
    this.phone,
    this.email,
    this.description,
  });

  factory AidOffer.fromJson(dynamic json) => AidOffer(
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
