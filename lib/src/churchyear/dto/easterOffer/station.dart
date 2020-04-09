class Station {
  String id;
  String title;
  String description;
  dynamic url;
  dynamic format;

  Station({
    this.id,
    this.title,
    this.description,
    this.url,
    this.format,
  });

  factory Station.fromJson(Map<String, dynamic> json) => Station(
        id: json["id"],
        title: json["title"],
        description: json["description"],
        url: json["url"],
        format: json["format"],
      );
}
