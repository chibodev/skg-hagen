import 'package:skg_hagen/src/aboutus/controller/aboutus.dart';
import 'package:skg_hagen/src/appointment/controller/appointmentController.dart';
import 'package:skg_hagen/src/contacts/controller/contacts.dart';
import 'package:skg_hagen/src/home/controller/home.dart';
import 'package:skg_hagen/src/intercession/controller/intercession.dart';
import 'package:skg_hagen/src/kindergarten/controller/kindergarten.dart';
import 'package:skg_hagen/src/legal/controller/imprint.dart';
import 'package:skg_hagen/src/legal/controller/privacy.dart';
import 'package:skg_hagen/src/offer/controller/offer.dart';

class Routes {
  static const String home = Home.route;
  static const String appointment = AppointmentController.route;
  static const String offer = Offer.route;
  static const String intercession = Intercession.route;
  static const String kindergarten = Kindergarten.route;
  static const String contacts = Contacts.route;
  static const String aboutUs = AboutUs.route;
  static const String imprint = Imprint.route;
  static const String privacy = Privacy.route;

  static const List<String> VALID_ROUTES = <String>[
    home,
    appointment,
    offer,
    intercession,
    kindergarten,
    contacts,
    aboutUs,
    imprint,
    privacy,
  ];

  static bool isValid(String route) {
    return VALID_ROUTES.contains(route);
  }
}
