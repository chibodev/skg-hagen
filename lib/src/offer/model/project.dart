class Project {
  final String title;
  final String description;
  final String imageUrl;
  static const int URL_MIN = 7;

  Project({this.title, this.imageUrl, this.description});

  factory Project.fromJson(Map<String, dynamic> json) => Project(
        title: json['title'],
        description: json['description'],
        imageUrl: json['imageUrl'].toString().length > URL_MIN
            ? json['imageUrl']
            : null,
      );

  String getName() => "Projekte";
}
