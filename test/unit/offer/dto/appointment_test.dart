import 'package:flutter_test/flutter_test.dart';
import 'package:skg_hagen/src/offer/dto/appointment.dart';

void main() {
  Appointment subject;

  test('Appointment dto successfully gets formatted time', () {
    subject = Appointment(
        title: 'Formatted time without end time',
        occurrence: DateTime.parse('2019-12-06'),
        time: "14:15",
        placeName: '',
        room: '');

    expect(subject.title, 'Formatted time without end time');
    expect(subject.getFormattedTimeAsString(), 'FR. 6.12.19 | 14:15');
  });

  test('Appointment dto successfully gets formatted time with end time', () {
    subject = Appointment(
        title: 'Formatted time with end time',
        occurrence: DateTime.parse('2020-01-07'),
        endOccurrence: DateTime.parse('2020-01-07'),
        time: "15:15",
        endTime: "19:00",
        placeName: '',
        room: '');

    expect(subject.title, 'Formatted time with end time');
    expect(subject.getFormattedTimeAsString(), 'DI. 7.1.20 | 15:15 - 19:00');
  });

  test('Appointment dto successfully gets formatted organiser', () {
    subject = Appointment(
        title: 'New appointment',
        organizer: 'Famous Dee',
        infoTitle: 'Info',
        occurrence: DateTime.parse('2023-06-07'),
        time: '',
        placeName: '',
        room: '');

    expect(subject.title, 'New appointment');
    expect(subject.getFormattedOrganiser(), 'Info: Famous Dee');
  });

  test('Appointment dto does not have organiser', () {
    subject = Appointment(
        title: 'No organiser',
        organizer: '',
        occurrence: DateTime.parse('2023-06-08'),
        time: '',
        placeName: '',
        room: '');

    expect(subject.title, 'No organiser');
    expect(subject.getFormattedOrganiser(), '');
  });
}
