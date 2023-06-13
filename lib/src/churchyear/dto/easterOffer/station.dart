class Station {
  String id;
  String title;
  String description;
  dynamic url;
  dynamic format;

  Station({
    required this.id,
    required this.title,
    required this.description,
    this.url,
    this.format,
  });

  factory Station.fromJson(Map<String, dynamic> json) => Station(
        id: json["id"],
        title: json["title"],
        description: json["description"],
        url: json["url"] ?? null,
        format: json["format"] ?? null,
      );
}
