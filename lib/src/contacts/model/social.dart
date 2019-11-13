class Social {
  static const String FACEBOOK = 'assets/images/icon/facebook.png';

  String name;
  String url;

  Social({
    this.name,
    this.url,
  });

  factory Social.fromJson(Map<String, dynamic> json) => Social(
        name: json["name"],
        url: json["url"],
      );

  Map<String, dynamic> toJson() => <String, dynamic>{
        "name": name,
        "url": url,
      };

  String getName() => "Social";
}
