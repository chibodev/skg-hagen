import 'dart:async';

import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:skg_hagen/src/aboutus/controller/aboutus.dart';
import 'package:skg_hagen/src/common/library/globals.dart';
import 'package:skg_hagen/src/common/model/default.dart';
import 'package:skg_hagen/src/common/routes/routes.dart';
import 'package:skg_hagen/src/common/service/environment.dart';
import 'package:skg_hagen/src/contacts/controller/contacts.dart';
import 'package:skg_hagen/src/home/controller/home.dart';
import 'package:skg_hagen/src/appointment/controller/appointment.dart';
import 'package:skg_hagen/src/intercession/controller/intercession.dart';
import 'package:skg_hagen/src/legal/controller/imprint.dart';
import 'package:skg_hagen/src/legal/controller/privacy.dart';
import 'package:skg_hagen/src/offer/controller/offer.dart';
import 'package:skg_hagen/src/kindergarten/controller/kindergarten.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  FlutterError.onError = (FlutterErrorDetails details) {
    if (!Environment.isProduction()) {
      FlutterError.dumpErrorToConsole(details);
    } else {
      FlutterError.onError = Crashlytics.instance.recordFlutterError;
    }
  };

  runZoned<Future<void>>(() async {
    SharedPreferences.getInstance().then(
      (SharedPreferences sp) {
        sharedPreferences = sp;
        SystemChrome.setPreferredOrientations(
            <DeviceOrientation>[DeviceOrientation.portraitUp]).then(
          (_) {
            DotEnv().load('.env').then((_) => runApp(MyApp()));
          },
        );
      },
    );
  }, onError: Crashlytics.instance.recordError);
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: <String, Widget Function(BuildContext)>{
        Routes.home: (BuildContext context) => Home(),
        Routes.appointment: (BuildContext context) => Appointment(),
        Routes.offer: (BuildContext context) => Offer(),
        Routes.intercession: (BuildContext context) => Intercession(),
        Routes.kindergarten: (BuildContext context) => Kindergarten(),
        Routes.contacts: (BuildContext context) => Contacts(),
        Routes.aboutUs: (BuildContext context) => AboutUs(),
        Routes.imprint: (BuildContext context) => Imprint(),
        Routes.privacy: (BuildContext context) => Privacy(),
      },
      theme: ThemeData(primaryColor: Colors.white, fontFamily: Default.FONT),
      home: Home(),
    );
  }
}
