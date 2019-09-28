import 'package:skg_hagen/src/appointment/model/appointment.dart';
import 'package:skg_hagen/src/common/model/address.dart';

class AppointmentClient {
  List<Appointment> getAppointments() {
    List appointments = new List<Appointment>();

    //TODO read from json to emulate live behaviour

    Address markusChurch = new Address(
        'Markuskirche', 'Rheinstraße', '26', '58097', 'Hagen', 'DE');
    Address johannisChurch = new Address(
        'Johanniskirche', 'Johanniskirchplatz', '10', '58095', 'Hagen', 'DE');

    appointments.add(_createAppointment(
        'Lesung mit Chor',
        new DateTime(2019, 10, 1, 18, 30),
        johannisChurch,
        'Buchhandlung Lesen u. Hören,...'));

    appointments.add(_createAppointment('Kindergartengottesdienst',
        new DateTime(2019, 10, 2, 14, 15), markusChurch));

    appointments.add(_createAppointment('Frauenhilfe',
        new DateTime(2019, 10, 2, 15, 00), markusChurch, 'Infos bei den Pfarrerinnen'));

    appointments.add(_createAppointment('Kantorei - Proben',
        new DateTime(2019, 10, 2, 19, 00), johannisChurch));

    appointments.add(_createAppointment('Offener Meditationsabend.',
        new DateTime(2019, 10, 2, 19, 30), johannisChurch, 'Frau Klahr und Team'));

    appointments.add(_createAppointment('(persischer) Bibelkreis',
        new DateTime(2019, 10, 3, 15, 30), johannisChurch));

    appointments.add(_createAppointment('Café Willkommen',
        new DateTime(2019, 10, 4, 13, 30), johannisChurch));

    appointments.add(_createAppointment('Andacht zur Marktzeit',
        new DateTime(2019, 10, 5, 12, 00), johannisChurch, 'Pfarrerin Eßer'));

    appointments.add(_createAppointment('Familiengottesdienst zum Erntedank',
        new DateTime(2019, 10, 6, 11, 00), markusChurch, 'Pfrin. Eßer + Team'));

    return appointments;
  }

  Appointment _createAppointment(
      String title, DateTime dateAndTime, Address address,
      [String organizer]) {
    return new Appointment(title, dateAndTime, address, organizer);
  }
}
