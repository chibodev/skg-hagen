class Data {
  String clickAction;
  String status;
  String? screen;

  Data({
    required this.clickAction,
    required this.status,
    this.screen,
  });

  factory Data.fromJson(Map<dynamic, dynamic> json) => Data(
        clickAction: json["click_action"],
        status: json["status"],
        screen: json["screen"] == "" || json["screen"] == null
            ? null
            : json["screen"],
      );

  Map<dynamic, dynamic> toJson() => <dynamic, dynamic>{
        "screen": screen,
        "status": status,
        "click_action": clickAction,
      };
}
