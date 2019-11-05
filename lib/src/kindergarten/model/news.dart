class News {
  final String title;
  final String description;

  News({this.title, this.description});

  factory News.fromJson(Map<String, dynamic> json) => News(
        title: json['title'],
        description: json['description'],
      );

  String getName() => "Mitteilungen";
}
