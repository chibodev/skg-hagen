import 'package:flutter_test/flutter_test.dart';
import 'package:skg_hagen/src/home/model/monthlyScripture.dart';

void main() {
  MonthlyScripture subject;
  String text;
  String book;
  String chapter;
  String verse;

  setUpAll(() {
    text = 'This is a text';
    book = 'Psalmen';
    chapter = '1';
    verse = '6';
    subject = MonthlyScripture(
        text: text, book: book, chapter: chapter, verse: verse
    );
  });

  test('MonthlyScripture model creates and gets properties successfully', (){
    expect(subject.text, text);
    expect(subject.book, book);
    expect(subject.chapter, chapter);
    expect(subject.verse, verse);
  });

  test('MonthlyScripture gets correct formatted property', (){
    expect(subject.getFormatted(), ' Ps. $chapter, $verse');
  });

  test('MonthlyScripture throws exception due to unknown book name', (){
    subject.book = 'Unknown';

    expect(subject.getFormatted(), '');
  });
}
