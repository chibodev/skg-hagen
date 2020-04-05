import 'package:skg_hagen/src/aboutus/controller/aboutus.dart';
import 'package:skg_hagen/src/aboutus/dto/aboutus.dart' as DTO;
import 'package:skg_hagen/src/appointment/controller/appointmentController.dart';
import 'package:skg_hagen/src/appointment/dto/appointments.dart';
import 'package:skg_hagen/src/contacts/controller/contacts.dart';
import 'package:skg_hagen/src/contacts/dto/contact.dart';
import 'package:skg_hagen/src/home/controller/home.dart';
import 'package:skg_hagen/src/intercession/controller/intercession.dart';
import 'package:skg_hagen/src/intercession/dto/intercession.dart' as DTO;
import 'package:skg_hagen/src/kindergarten/controller/kindergarten.dart';
import 'package:skg_hagen/src/kindergarten/dto/kindergarten.dart' as DTO;
import 'package:skg_hagen/src/legal/controller/imprint.dart';
import 'package:skg_hagen/src/legal/dto/imprint.dart' as DTO;
import 'package:skg_hagen/src/legal/dto/privacy.dart' as DTO;
import 'package:skg_hagen/src/offer/controller/offer.dart';
import 'package:skg_hagen/src/offer/dto/offers.dart';
import 'package:skg_hagen/src/pushnotification/controller/appointmentController.dart';

class Routes {
  static const String home = Home.route;
  static const String appointment = AppointmentController.route;
  static const String offer = Offer.route;
  static const String intercession = Intercession.route;
  static const String kindergarten = Kindergarten.route;
  static const String contacts = Contacts.route;
  static const String aboutUs = AboutUs.route;
  static const String imprint = Imprint.route;
  static const String pushNotification = PushNotificationController.route;

  static const List<String> VALID_ROUTES = <String>[
    home,
    appointment,
    offer,
    intercession,
    kindergarten,
    contacts,
    aboutUs,
    imprint,
  ];

  static const Map<String, String> MAPPING = <String, String>{
    appointment: Appointments.NAME,
    offer: Offers.NAME,
    intercession: DTO.Intercession.NAME,
    kindergarten: DTO.Kindergarten.NAME,
    contacts: Contact.NAME,
    aboutUs: DTO.AboutUs.NAME,
    imprint: DTO.Imprint.NAME,
  };

  static bool isValid(String route) {
    return VALID_ROUTES.contains(route);
  }
}
