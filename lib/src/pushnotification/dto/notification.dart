class Notification {
  String body;
  String title;

  Notification({
    required this.body,
    required this.title,
  });

  factory Notification.fromJson(Map<dynamic, dynamic> json) => Notification(
        body: json["body"],
        title: json["title"],
      );

  Map<dynamic, dynamic> toJson() => <dynamic, dynamic>{
        "title": title,
        "body": body,
      };
}
