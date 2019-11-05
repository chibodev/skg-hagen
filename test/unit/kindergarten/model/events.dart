import 'package:flutter_test/flutter_test.dart';
import 'package:skg_hagen/src/kindergarten/model/events.dart';
import 'package:skg_hagen/src/offer/model/group.dart';
import 'package:skg_hagen/src/offer/model/offer.dart';

void main() {
  Events subject;

  group('Occurrence', () {
    test('Events model successfully gets formatted occurrence', () {
      subject = Events(title: 'New Event', occurrence: DateTime.parse('2019-11-22'), time: '07:00:00');

      expect(subject.title, 'New Event');
      expect(subject.getFormattedOccurrence(), 'FR. 22.11.19 | 07:00');
    });

    test('Events model successfully gets formatted occurrence with no time', () {
      subject = Events(title: 'New No Time Event', occurrence: DateTime.parse('2019-09-26'), time: '00:00:00');

      expect(subject.title, 'New No Time Event');
      expect(subject.getFormattedOccurrence(), 'DO. 26.9.19');
    });
  });


}
