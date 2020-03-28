class Notification {
  String body;
  String title;

  Notification({
    this.body,
    this.title,
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
