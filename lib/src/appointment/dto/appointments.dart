import 'package:skg_hagen/src/appointment/dto/appointment.dart';

class Appointments {
  List<Appointment>? appointments;
  static const String NAME = 'Termine';
  static const String IMAGE = 'assets/images/termine.jpg';

  Appointments({
    this.appointments,
  });

  factory Appointments.fromJson(Map<String, dynamic> json) => Appointments(
      appointments: List<Appointment>.from(
          json["appointments"].map((dynamic x) => Appointment.fromJson(x))));
}
