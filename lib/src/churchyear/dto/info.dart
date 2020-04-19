class Info {
  String title;
  String description;
  String url;

  Info({this.description, this.title, this.url});

  factory Info.fromJson(Map<String, dynamic> json) => Info(
        title: json["title"],
        url: json["url"],
        description: json["description"],
      );
}
