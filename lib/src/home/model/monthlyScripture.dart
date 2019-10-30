import 'package:skg_hagen/src/common/valueObject/bibleBook.dart';

class MonthlyScripture {
  String text;
  String book;
  String chapter;
  String verse;

  MonthlyScripture({this.text, this.book, this.chapter, this.verse});

  factory MonthlyScripture.fromJson(Map<String, dynamic> json) =>
      MonthlyScripture(
          text: json['text'] == null ? null : json['text'],
          book: json['book'] == null ? null : json['book'],
          chapter: json['chapter'] == null ? null : json['chapter'],
          verse: json['verse'] == null ? null : json['verse']);

  Map<String, dynamic> toJson() => <String, dynamic>{
        'text': this.text == null ? null : text,
        'book': this.book == null ? null : book,
        'chapter': this.chapter == null ? null : chapter,
        'verse': this.verse == null ? null : verse,
      };

  String getFormatted() {
    String formattedText = '';
    try {
      final BibleBook bibleChapter = BibleBook(this.book);
      formattedText = " ${bibleChapter.getAbbreviation()} $chapter, $verse";
    } catch (e) {
      //do nothing and return empty formatted text
    }
    return formattedText;
  }
}
