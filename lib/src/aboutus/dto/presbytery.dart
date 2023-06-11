class Presbytery {
  String? salutation;
  String? surname;
  String? firstname;
  String? description;
  static const String NAME = 'Das Presbyterium';

  Presbytery({
    this.salutation,
    this.surname,
    this.firstname,
    this.description,
  });

  factory Presbytery.fromJson(Map<String, dynamic> json) => Presbytery(
        salutation: json["salutation"],
        surname: json["surname"],
        firstname: json["firstname"],
        description: json["description"],
      );

  String getPresbyter() => "$salutation $firstname $surname";
}
