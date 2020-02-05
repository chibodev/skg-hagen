class History {
  String description;

  History({
    this.description,
  });

  factory History.fromJson(Map<String, dynamic> json) => History(
    description: json["description"],
  );

  String getName() => "Geschichte";
}
