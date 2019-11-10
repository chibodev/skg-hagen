import 'package:skg_hagen/src/aboutus/controller/aboutus.dart';
import 'package:skg_hagen/src/appointment/controller/appointment.dart';
import 'package:skg_hagen/src/contacts/controller/contacts.dart';
import 'package:skg_hagen/src/home/controller/home.dart';
import 'package:skg_hagen/src/kindergarten/controller/kindergarten.dart';
import 'package:skg_hagen/src/legal/controller/imprint.dart';
import 'package:skg_hagen/src/legal/controller/privacy.dart';
import 'package:skg_hagen/src/offer/controller/offer.dart';

class Routes {
  static const String home = Home.route;
  static const String appointment = Appointment.route;
  static const String offer = Offer.route;
  static const String kindergarten = Kindergarten.route;
  static const String contacts = Contacts.route;
  static const String aboutUs = AboutUs.route;
  static const String imprint = Imprint.route;
  static const String privacy = Privacy.route;
}
