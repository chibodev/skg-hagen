class Quote {
  String text;
  String book;
  String chapter;
  String verse;
  static const String NAME = 'Auswahl an Konfirmationssprüchen';
  static const String PAGE_NAME = 'Konfi-Sprüchen';

  Quote({this.text, this.book, this.chapter, this.verse});

  factory Quote.fromJson(Map<String, dynamic> json) => Quote(
        text: json['text'],
        book: json['book'],
        chapter: json['chapter'],
        verse: json['verse'],
      );

  Map<String, dynamic> toJson() => <String, dynamic>{
        'text': this.text,
        'book': this.book,
        'chapter': this.chapter,
        'verse': this.verse,
      };

  String getText() => text.length > 2 ? "$text\n${this.getBook()}" : "";

  String getBook() => "$book $chapter, $verse";

  String getName() => NAME;
}
