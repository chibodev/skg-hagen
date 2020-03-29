import 'package:skg_hagen/src/aboutus/controller/aboutus.dart';
import 'package:skg_hagen/src/aboutus/model/aboutus.dart' as Model;
import 'package:skg_hagen/src/appointment/controller/appointmentController.dart';
import 'package:skg_hagen/src/appointment/model/appointments.dart';
import 'package:skg_hagen/src/contacts/controller/contacts.dart';
import 'package:skg_hagen/src/contacts/model/contact.dart';
import 'package:skg_hagen/src/home/controller/home.dart';
import 'package:skg_hagen/src/intercession/controller/intercession.dart';
import 'package:skg_hagen/src/intercession/model/intercession.dart' as Model;
import 'package:skg_hagen/src/kindergarten/controller/kindergarten.dart';
import 'package:skg_hagen/src/kindergarten/model/kindergarten.dart' as Model;
import 'package:skg_hagen/src/legal/controller/imprint.dart';
import 'package:skg_hagen/src/legal/controller/privacy.dart';
import 'package:skg_hagen/src/legal/model/imprint.dart' as Model;
import 'package:skg_hagen/src/legal/model/privacy.dart' as Model;
import 'package:skg_hagen/src/offer/controller/offer.dart';
import 'package:skg_hagen/src/offer/model/offers.dart';
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
  static const String privacy = Privacy.route;
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
    privacy,
  ];

  static const Map<String, String> MAPPING = <String, String>{
    appointment: Appointments.NAME,
    offer: Offers.NAME,
    intercession: Model.Intercession.NAME,
    kindergarten: Model.Kindergarten.NAME,
    contacts: Contact.NAME,
    aboutUs: Model.AboutUs.NAME,
    imprint: Model.Imprint.NAME,
    privacy: Model.Privacy.NAME
  };

  static bool isValid(String route) {
    return VALID_ROUTES.contains(route);
  }
}
