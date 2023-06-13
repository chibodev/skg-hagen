class Info {
  String title;
  String description;
  dynamic url;

  Info({required this.description, required this.title, this.url});

  factory Info.fromJson(Map<String, dynamic> json) => Info(
        title: json["title"],
        url: json["url"] ?? null,
        description: json["description"],
      );
}
