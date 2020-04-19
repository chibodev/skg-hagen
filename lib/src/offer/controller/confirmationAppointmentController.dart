import 'package:flutter/material.dart';
import 'package:skg_hagen/src/offer/dto/appointment.dart';
import 'package:skg_hagen/src/offer/view/confirmationAppointment.dart';

class ConfirmationAppointmentController extends StatefulWidget {
  final List<Appointment> appointment;
  final bool dataAvailable;
  final BuildContext context;

  const ConfirmationAppointmentController(
      {Key key,
      this.context,
      @required this.appointment,
      this.dataAvailable = true})
      : super(key: key);

  @override
  ConfirmationAppointment createState() => ConfirmationAppointment();
}
