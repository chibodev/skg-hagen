import 'package:flutter_test/flutter_test.dart';
import 'package:skg_hagen/src/appointment/model/appointment.dart';

void main() {
  Appointment subject;

  test('Appointment model successfully gets formatted time', () {
    subject = Appointment(
        title: 'Formatted time',
        occurrence: DateTime.parse('2019-11-01'),
        time: "17:00");

    expect(subject.title, 'Formatted time');
    expect(subject.getFormattedTimeAsString(), 'FR. 1.11.19 | 17:00');
  });

  test('Appointment model successfully gets formatted organiser', () {
    subject = Appointment(
        title: 'New appointment', organizer: 'Billing Gray', infoTitle: 'Info');

    expect(subject.title, 'New appointment');
    expect(subject.getFormattedOrganiser(), 'Info: Billing Gray');
  });

  test('Appointment model does not have organiser', () {
    subject = Appointment(title: 'No organiser', organizer: '');

    expect(subject.title, 'No organiser');
    expect(subject.getFormattedOrganiser(), '');
  });
}
