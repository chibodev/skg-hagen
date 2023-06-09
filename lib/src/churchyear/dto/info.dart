class Info {
  String title;
  String description;
  String url;

  Info({required this.description, required this.title, required this.url});

  factory Info.fromJson(Map<String, dynamic> json) => Info(
        title: json["title"],
        url: json["url"],
        description: json["description"],
      );
}
