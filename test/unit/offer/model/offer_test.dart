import 'package:flutter_test/flutter_test.dart';
import 'package:skg_hagen/src/offer/model/group.dart';
import 'package:skg_hagen/src/offer/model/offer.dart';

void main() {
  Offer subject;

  group('Occurrence', () {
    test('Offer model successfully gets occurrence text', () {
      subject =
          Offer(title: 'Kinderchor', occurrence: 'Montags', time: "19:15:00");

      expect(subject.title, 'Kinderchor');
      expect(subject.getFormattedOccurrence(), 'Montags | 19:15 ');
    });

    test('Group model successfully gets occurrence text', () {
      final Group subject = Group(
          title: 'Kinderchor',
          occurrence: 'Jede 1. Montag im Monat',
          time: "17:30:05");

      expect(subject.title, 'Kinderchor');
      expect(
          subject.getFormattedOccurrence(), 'Jede 1. Montag im Monat | 17:30 ');
    });
  });

  test('Offer model successfully gets formatted organiser', () {
    subject = Offer(title: 'New Offer', organizer: 'Allison Gray');

    expect(subject.title, 'New Offer');
    expect(subject.getFormattedOrganiser(), 'Infos: Allison Gray');
  });

  test('Offer model does not have organiser', () {
    subject = Offer(title: 'No organiser', organizer: '');

    expect(subject.title, 'No organiser');
    expect(subject.getFormattedOrganiser(), '');
  });

  test('Offer model successfully gets school year text', () {
    subject = Offer(
        title: 'Member Meeting',
        occurrence: 'Montags',
        time: "19:15:00",
        schoolYear: '12');

    expect(subject.title, 'Member Meeting');
    expect(subject.getFormattedSchoolYear(), '12. Schuljahr');
  });
}
