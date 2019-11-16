import 'package:skg_hagen/src/home/valueObject/bibleBook.dart';

class MonthlyScripture {
  static const int TEXT_LIMIT = 56;
  static const String TITLE = 'Biblevers';

  String text;
  String book;
  String chapter;
  String verse;

  MonthlyScripture({this.text, this.book, this.chapter, this.verse});

  factory MonthlyScripture.fromJson(Map<String, dynamic> json) =>
      MonthlyScripture(
          text: json['text'],
          book: json['book'],
          chapter: json['chapter'],
          verse: json['verse']);

  Map<String, dynamic> toJson() => <String, dynamic>{
        'text': this.text,
        'book': this.book,
        'chapter': this.chapter,
        'verse': this.verse,
      };

  String getFormattedBook() {
    String formattedText = '';
    try {
      final BibleBook bibleChapter = BibleBook(this.book);
      formattedText = " ${bibleChapter.getAbbreviation()} $chapter, $verse";
    } catch (e) {
      //do nothing and return empty formatted text
    }
    return formattedText;
  }

  String getModifiedText() {
    return text.length > TEXT_LIMIT
        ? "${text.substring(0, TEXT_LIMIT)}..."
        : text.length > 2 ? text : '';
  }
}
