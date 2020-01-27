import 'package:flutter_test/flutter_test.dart';
import 'package:skg_hagen/src/offer/model/offer.dart';
import 'package:skg_hagen/src/offer/model/project.dart';

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
      final Project subject = Project(
          title: 'New project',
          description: 'a brief description',
          imageUrl: "");

      expect(Project.NAME, 'Projekte');
      expect(subject.title, 'New project');
      expect(subject.description, 'a brief description');
    });
  });

  test('Offer model successfully gets formatted organiser', () {
    subject = Offer(
        title: 'New Offer', organizer: 'Allison Gray', infoTitle: 'Leitung');

    expect(subject.title, 'New Offer');
    expect(subject.getFormattedOrganiser(), 'Leitung: Allison Gray');
  });

  test('Offer model does not have organiser', () {
    subject = Offer(title: 'No organiser', organizer: null);

    expect(subject.title, 'No organiser');
    expect(subject.getFormattedOrganiser(), isNull);
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
