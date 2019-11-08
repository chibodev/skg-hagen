import 'dart:async';

import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:skg_hagen/src/aboutus/controller/aboutus.dart';
import 'package:skg_hagen/src/common/routes/routes.dart';
import 'package:skg_hagen/src/contacts/controller/contacts.dart';
import 'package:skg_hagen/src/home/controller/home.dart';
import 'package:skg_hagen/src/appointment/controller/appointment.dart';
import 'package:skg_hagen/src/offer/controller/offer.dart';
import 'package:skg_hagen/src/kindergarten/controller/kindergarten.dart';

void main() async {
  final bool isInDebugMode = false;

  FlutterError.onError = (FlutterErrorDetails details) {
    if (isInDebugMode) {
      // In development mode simply print to console.
      FlutterError.dumpErrorToConsole(details);
    } else {
      // In production mode report to the application zone to report to Crashlytics.
      FlutterError.onError = Crashlytics.instance.recordFlutterError;
      Crashlytics.instance.setUserEmail('dev@chibo.org');
    }
  };

  runZoned<Future<void>>(() async {
    SystemChrome.setPreferredOrientations(
        <DeviceOrientation>[DeviceOrientation.portraitUp]).then((_) {
      runApp(MyApp());
    });
  }, onError: Crashlytics.instance.recordError);
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: <String, Widget Function(BuildContext)>{
        Routes.home: (BuildContext context) => Home(),
        Routes.appointment: (BuildContext context) => Appointment(),
        Routes.offer: (BuildContext context) => Offer(),
        Routes.kindergarten: (BuildContext context) => Kindergarten(),
        Routes.contacts: (BuildContext context) => Contacts(),
        Routes.aboutUs: (BuildContext context) => AboutUs(),
      },
      theme: ThemeData(primaryColor: Colors.white, fontFamily: 'Optima'),
      home: Home(),
    );
  }
}
