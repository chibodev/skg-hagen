import 'package:flutter_test/flutter_test.dart';
import 'package:skg_hagen/src/appointment/dto/appointment.dart';

void main() {
  Appointment subject;

  test('Appointment dto successfully gets formatted time', () {
    subject = Appointment(
        title: 'Formatted time without end time',
        occurrence: DateTime.parse('2019-11-01'),
        time: "17:00");

    expect(subject.title, 'Formatted time without end time');
    expect(subject.getFormattedTimeAsString(), 'FR. 1.11.19 | 17:00');
  });

  test('Appointment dto successfully gets formatted time with end time', () {
    subject = Appointment(
        title: 'Formatted time with end time',
        occurrence: DateTime.parse('2019-11-01'),
        endOccurrence: DateTime.parse('2019-11-02'),
        time: "17:00",
        endTime: "18:30"
    );

    expect(subject.title, 'Formatted time with end time');
    expect(subject.getFormattedTimeAsString(), 'FR. 1.11.19 | 17:00 - SA. 2.11.19 | 18:30');
  });

  test('Appointment dto successfully gets formatted organiser', () {
    subject = Appointment(
        title: 'New appointment', organizer: 'Billing Gray', infoTitle: 'Info');

    expect(subject.title, 'New appointment');
    expect(subject.getFormattedOrganiser(), 'Info: Billing Gray');
  });

  test('Appointment dto does not have organiser', () {
    subject = Appointment(title: 'No organiser', organizer: '');

    expect(subject.title, 'No organiser');
    expect(subject.getFormattedOrganiser(), '');
  });
}
