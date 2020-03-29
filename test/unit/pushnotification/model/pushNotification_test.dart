import 'package:flutter_test/flutter_test.dart';
import 'package:skg_hagen/src/pushnotification/model/pushNotification.dart';

void main() {
  PushNotification subject;

  test('PushNotification model successfully gets formatted time', () {
    subject = PushNotification(
        title: 'Formatted date time',
        body: 'content of info',
        screen: '/appointment',
        validUntil: DateTime.parse('2020-03-03'));

    expect(subject.title, 'Formatted date time');
    expect(subject.getFormattedValidUntil(), 'Gültig bis DI. 3.3.20');
    expect(subject.getCategory(), 'Termine');
  });

  test('PushNotification model withouth routing page', () {
    subject = PushNotification(
        title: 'Formatted date time',
        body: 'content of info',
        screen: '/unknown',
        validUntil: DateTime.parse('2020-03-05'));

    expect(subject.title, 'Formatted date time');
    expect(subject.body, 'content of info');
    expect(subject.getFormattedValidUntil(), 'Gültig bis DO. 5.3.20');
    expect(subject.getCategory(), isNull);
  });
}
