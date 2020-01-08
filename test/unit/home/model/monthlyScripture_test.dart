import 'package:flutter_test/flutter_test.dart';
import 'package:skg_hagen/src/home/model/monthlyScripture.dart';

void main() {
  MonthlyScripture subject;
  String oldTestamentText;
  String newTestamentText;

  setUpAll(() {
    oldTestamentText = 'This is a text';
    newTestamentText = 'Psalmen';
    subject = MonthlyScripture(
        oldTestamentText: oldTestamentText, newTestamentText: newTestamentText
    );
  });

  test('MonthlyScripture model creates and gets properties successfully', (){
    expect(subject.oldTestamentText, oldTestamentText);
    expect(subject.newTestamentText, newTestamentText);
  });

  test('MonthlyScripture gets correct modified text', (){
    subject.newTestamentText = 'Psalmen Psalmen Psalmen Psalmen Psalmen Psalmen Psalmen Psalmen';
    expect(subject.getModifiedText(), 'Psalmen Psalmen Psalmen Psalmen Psalmen Psalmen Psalmen ...');
  });
}
