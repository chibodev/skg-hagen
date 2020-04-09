class News {
  final String title;
  final String description;
  final String url;
  final String urlFormat;
  final String imageUrl;
  final String fileUrl;
  final String filename;
  final String format;
  static const int URL_MIN = 7;
  static const String NAME = 'Aktionen';

  News(
      {this.title,
      this.imageUrl,
      this.description,
      this.url,
      this.urlFormat,
      this.fileUrl,
      this.format,
      this.filename});

  factory News.fromJson(Map<String, dynamic> json) => News(
        title: json['title'],
        description: json['description'],
        url: json["url"] == "" ? null : json["url"],
        urlFormat: json["urlFormat"] == "" ? null : json["urlFormat"],
        imageUrl: json['imageUrl'].toString().length > URL_MIN
            ? json['imageUrl']
            : null,
        fileUrl: (json['fileUrl'] != '' || json['format'] != null)
            ? json['fileUrl']
            : null,
        format: (json['format'] != null) ? json['format'] : null,
        filename: (json['filename'] != null) ? json['filename'] : null,
      );
}
