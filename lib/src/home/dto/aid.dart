class Aid {
  String? title;
  String? description;
  String? phone;
  String? email;

  Aid({
    this.title,
    this.phone,
    this.email,
    this.description,
  });

  factory Aid.fromJson(Map<String, dynamic> json) => Aid(
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
