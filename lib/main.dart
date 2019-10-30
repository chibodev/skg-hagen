import 'package:flutter/material.dart';
import 'package:skg_hagen/src/common/routes/routes.dart';
import 'package:skg_hagen/src/home/controller/home.dart';
import 'package:skg_hagen/src/appointment/controller/appointment.dart';
import 'package:skg_hagen/src/offer/controller/offer.dart';
import 'package:skg_hagen/src/kindergarten/controller/kindergarten.dart';

void main() => runApp(MyApp());

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
      },
      theme: ThemeData(primaryColor: Colors.white, fontFamily: 'Optima'),
      home: Home(),
    );
  }
}
