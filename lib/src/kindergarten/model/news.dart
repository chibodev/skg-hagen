class News {
  final String title;
  final String description;
  final String imageUrl;
  static const int URL_MIN = 7;

  News({this.title, this.imageUrl, this.description});

  factory News.fromJson(Map<String, dynamic> json) => News(
        title: json['title'],
        description: json['description'],
        imageUrl: json['imageUrl'].toString().length > URL_MIN
            ? json['imageUrl']
            : null,
      );

  String getName() => "Aktionen";
}
