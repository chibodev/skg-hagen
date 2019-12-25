import 'package:flutter_test/flutter_test.dart';
import 'package:skg_hagen/src/home/model/cardContent.dart';

void main() {
  CardContent subject;
  String title;
  List<String> subtitle;
  String routeName;
  String custom;

  setUpAll(() {
    title = 'title';
    subtitle = <String>['first', 'second'];
    routeName = '/route';
    custom = 'custom';
    subject = CardContent(title, subtitle, routeName, custom);
  });

  test('CardContent model creates and gets properties successfully', () {
    expect(subject.title, title);
    expect(subject.subtitle, subtitle);
    expect(subject.routeName, routeName);
    expect(subject.custom, custom);
  });

  test('CardContent gets correct formatted property', () {
    expect(subject.joinedSubtitle, 'first | second');
  });
}
