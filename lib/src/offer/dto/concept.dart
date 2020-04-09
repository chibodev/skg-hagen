class Concept {
  String description;
  static const String NAME = 'Konzept';
  static const String PAGE_NAME = 'Konfi-Konzept';

  Concept({
    this.description,
  });

  factory Concept.fromJson(Map<String, dynamic> json) => Concept(
        description: json["description"],
      );

}
