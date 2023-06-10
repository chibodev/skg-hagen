import 'package:flutter_test/flutter_test.dart';
import 'package:skg_hagen/src/home/dto/monthlyScripture.dart';

void main() {
  late MonthlyScripture subject;
  late String oldTestamentText;
  late String newTestamentText;

  setUpAll(() {
    oldTestamentText = 'This is a text';
    newTestamentText = 'Psalmen';
    subject = MonthlyScripture();
    subject.oldTestamentText = oldTestamentText;
    subject.newTestamentText = newTestamentText;

  });

  test('MonthlyScripture dto creates and gets properties successfully', (){
    expect(subject.oldTestamentText, oldTestamentText);
    expect(subject.newTestamentText, newTestamentText);
  });

  test('MonthlyScripture gets correct modified text', (){
    subject.oldTestamentText = 'Psalmen Psalmen Psalmen Psalmen Psalmen Psalmen Psalmen Psalmen';
    expect(subject.getModifiedText(), 'Psalmen Psalmen Psalmen Psalmen Psalmen Psalmen Psalmen ...');
  });
}
