class Data {
  String clickAction;
  String status;
  String screen;

  Data({
    this.clickAction,
    this.status,
    this.screen,
  });

  factory Data.fromJson(Map<dynamic, dynamic> json) => Data(
        clickAction: json["click_action"],
        status: json["status"],
        screen: json["screen"] == "" || json["screen"] == null
            ? null
            : json["screen"],
      );
}
