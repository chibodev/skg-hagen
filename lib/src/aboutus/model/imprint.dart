class Imprint {
  String url;

  Imprint({
    this.url,
  });

  factory Imprint.fromJson(Map<String, dynamic> json) => Imprint(
    url: json["url"],
  );

  String getName() => "Impressum";
}