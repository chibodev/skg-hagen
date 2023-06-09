import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:skg_hagen/src/aboutus/controller/aboutus.dart';
import 'package:skg_hagen/src/appointment/controller/appointmentController.dart';
import 'package:skg_hagen/src/churchyear/controller/churchyearController.dart';
import 'package:skg_hagen/src/common/dto/font.dart';
import 'package:skg_hagen/src/common/library/globals.dart';
import 'package:skg_hagen/src/common/routes/routes.dart';
import 'package:skg_hagen/src/common/service/environment.dart';
import 'package:skg_hagen/src/contacts/controller/contacts.dart';
import 'package:skg_hagen/src/home/controller/home.dart';
import 'package:skg_hagen/src/intercession/controller/intercession.dart';
import 'package:skg_hagen/src/kindergarten/controller/kindergarten.dart';
import 'package:skg_hagen/src/legal/controller/imprint.dart';
import 'package:skg_hagen/src/offer/controller/offer.dart';
import 'package:skg_hagen/src/pushnotification/controller/appointmentController.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FlutterError.onError = (FlutterErrorDetails details) {
    if (!Environment.isProduction()) {
      FlutterError.dumpErrorToConsole(details);
    } else {
      FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;
    }
  };

  runZonedGuarded<Future<void>>(() async {
    final FirebaseRemoteConfig firebaseRemoteConfig =
        FirebaseRemoteConfig.instance;
    SharedPreferences.getInstance().then(
      (SharedPreferences sp) {
        sharedPreferences = sp;
        appFont = Font();
        remoteConfig = firebaseRemoteConfig;
        SystemChrome.setPreferredOrientations(
            <DeviceOrientation>[DeviceOrientation.portraitUp]).then(
          (_) {
            DotEnv().load(fileName: '.env').then((_) => runApp(MyApp()));
          },
        );
      },
    );
  }, FirebaseCrashlytics.instance.recordError);
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: <String, Widget Function(BuildContext)>{
        Routes.home: (BuildContext context) => Home(),
        Routes.appointment: (BuildContext context) => AppointmentController(),
        Routes.offer: (BuildContext context) => Offer(),
        Routes.intercession: (BuildContext context) => Intercession(),
        Routes.kindergarten: (BuildContext context) => Kindergarten(),
        Routes.contacts: (BuildContext context) => Contacts(),
        Routes.aboutUs: (BuildContext context) => AboutUs(),
        Routes.imprint: (BuildContext context) => Imprint(),
        Routes.pushNotification: (BuildContext context) =>
            PushNotificationController(),
        Routes.churchYear: (BuildContext context) => ChurchYearController(),
      },
      theme: ThemeData(primaryColor: Colors.white, fontFamily: Font.NAME),
      home: Home(),
    );
  }
}
