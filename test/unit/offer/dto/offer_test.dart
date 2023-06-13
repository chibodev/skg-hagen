import 'package:flutter_test/flutter_test.dart';
import 'package:skg_hagen/src/offer/dto/offer.dart';
import 'package:skg_hagen/src/offer/dto/project.dart';

void main() {
  Offer subject;

  group('Occurrence', () {
    test('Offer dto successfully gets occurrence text', () {
      subject = Offer(
          title: 'Kinderchor',
          occurrence: 'Montags',
          time: "19:15:00",
          placeName: '',
          schoolYear: '');

      expect(subject.title, 'Kinderchor');
      expect(subject.getFormattedOccurrence(), 'Montags | 19:15 ');
    });

    test('Group dto successfully gets occurrence text', () {
      final Project subject = Project(
          title: 'New project',
          description: 'a brief description',
          imageUrl: "");

      expect(Project.NAME, 'Projekte');
      expect(subject.title, 'New project');
      expect(subject.description, 'a brief description');
    });
  });

  test('Offer dto successfully gets formatted organiser', () {
    subject = Offer(
        title: 'New Offer',
        organizer: 'Allison Gray',
        infoTitle: 'Leitung',
        occurrence: '',
        placeName: '',
        schoolYear: '');

    expect(subject.title, 'New Offer');
    expect(subject.getFormattedOrganiser(), 'Leitung: Allison Gray');
  });

  test('Offer dto does not have organiser', () {
    subject = Offer(
        title: 'No organiser',
        organizer: null,
        occurrence: '',
        placeName: '',
        schoolYear: '');

    expect(subject.title, 'No organiser');
    expect(subject.getFormattedOrganiser(), isNull);
  });

  test('Offer dto successfully gets school year text', () {
    subject = Offer(
        title: 'Member Meeting',
        occurrence: 'Montags',
        time: "19:15:00",
        schoolYear: '12',
        timeUntil: '',
        placeName: '');

    expect(subject.title, 'Member Meeting');
    expect(subject.getFormattedSchoolYear(), '12. Schuljahr');
  });
}
