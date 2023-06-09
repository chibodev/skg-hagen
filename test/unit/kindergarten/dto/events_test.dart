import 'package:flutter_test/flutter_test.dart';
import 'package:skg_hagen/src/kindergarten/dto/events.dart';

void main() {
  late Events subject;

  group('Occurrence', () {
    test('Events dto successfully gets formatted occurrence', () {
      subject = Events(
          title: 'New Event',
          occurrence: DateTime.parse('2019-11-22'),
          time: '07:00:00',
          comment: '',
          placeName: '');

      expect(subject.title, 'New Event');
      expect(subject.getFormattedOccurrence(), 'FR. 22.11.19 | 07:00');
    });

    test('Events dto successfully gets formatted occurrence with no time', () {
      subject = Events(
          title: 'New No Time Event',
          occurrence: DateTime.parse('2019-09-26'),
          time: '00:00:00',
          comment: '',
          placeName: '');

      expect(subject.title, 'New No Time Event');
      expect(subject.getFormattedOccurrence(), 'DO. 26.9.19');
    });
  });
}
