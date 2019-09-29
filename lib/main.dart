import 'package:flutter/material.dart';
import 'package:skg_hagen/src/appointment/controller/appointment.dart';
import 'package:skg_hagen/src/common/routes/routes.dart';
import 'package:skg_hagen/src/home/controller/home.dart';
import 'package:skg_hagen/src/offer/controller/offer.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'skg-hagen',
      routes: {
        Routes.home : (BuildContext context) => Home(),
        Routes.appointment : (BuildContext context) => Appointment(),
        Routes.offer : (BuildContext context) => Offer(),
      },
      theme: ThemeData(
        primaryColor: Colors.white, fontFamily: 'Optima'
      ),
      home: Home(),
    );
  }
}
