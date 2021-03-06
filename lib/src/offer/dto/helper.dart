class Helper {
  final bool shopping;
  final bool errands;
  final bool animalWalk;
  final String name;
  final String age;
  final String city;
  final String contact;
  final String reason;

  Helper(
      {this.shopping,
      this.errands,
      this.animalWalk,
      this.name,
      this.age,
      this.city,
      this.contact,
      this.reason});

  Map<String, dynamic> toJson() => <String, dynamic>{
        "shopping": shopping == true ? 1 : 0,
        "errands": errands == true ? 1 : 0,
        "animal_walk": animalWalk == true ? 1 : 0,
        "name": name,
        "age": age,
        "city": city,
        "contact": contact,
        "reason": reason,
      };
}
