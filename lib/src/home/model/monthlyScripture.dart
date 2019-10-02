import 'package:json_annotation/json_annotation.dart';
import 'package:skg_hagen/src/common/model/bibleBook.dart';

part 'monthlyScripture.g.dart';

@JsonSerializable()
class MonthlyScripture {
  String text;
  String book;
  int chapter;
  int verse;

  MonthlyScripture(this.text, this.book, this.chapter, this.verse);

  factory MonthlyScripture.fromJson(Map<String, dynamic> json) =>
      _$MonthlyScriptureFromJson(json);

  Map<String, dynamic> toJson() => _$MonthlyScriptureToJson(this);

  String getFormatted() {
    BibleBook bibleChapter = BibleBook(this.book);
    String bookShort = bibleChapter.getAbbreviation();
    return "$text  $bookShort $chapter, $verse";
  }
}
