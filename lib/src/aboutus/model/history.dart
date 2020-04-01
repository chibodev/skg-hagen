class History {
  String description;
  final String url;
  final String urlFormat;
  static const String NAME = 'Geschichte';

  History({this.description, this.url, this.urlFormat});

  factory History.fromJson(Map<String, dynamic> json) => History(
        description: json["description"],
        url: json["url"] == "" ? null : json["url"],
        urlFormat: json["format"] == "" ? null : json["format"],
      );
}
