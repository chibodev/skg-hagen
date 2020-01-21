class History {
  String description;
  static const String NAME = 'Geschichte';

  History({
    this.description,
  });

  factory History.fromJson(Map<String, dynamic> json) => History(
    description: json["description"],
  );
}
