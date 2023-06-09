import 'package:flutter/material.dart';

import 'package:flutter_test/flutter_test.dart';
import 'package:skg_hagen/src/home/dto/cardContent.dart';

void main() {
  late CardContent subject;
  late String title;
  late List<String> subtitle;
  late String routeName;
  late String name;
  late String custom;

  setUpAll(() {
    title = 'title';
    subtitle = <String>['first', 'second'];
    routeName = '/route';
    name = 'name';
    custom = 'custom';
    subject = CardContent(title, subtitle, routeName, name, custom);
  });

  test('CardContent dto creates and gets properties successfully', () {

    expect(subject.title, title);
    expect(subject.subtitle, subtitle);
    expect(subject.routeName, routeName);
    expect(subject.name, name);
    expect(subject.custom, custom);
    expect(subject.getImageAsset(), isA<Image>());
  });

  test('CardContent gets correct formatted property', () {
    expect(subject.joinedSubtitle, 'first | second');
  });

  test('CardContent custom property is not set', () {
    subject = CardContent(title, subtitle, routeName, name);
    
    expect(subject.custom, null);
    expect(subject.getImageAsset(), null);
  });
}
