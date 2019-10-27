import 'package:flutter/material.dart';
import 'package:skg_hagen/src/common/routes/routes.dart';
import 'package:skg_hagen/src/home/controller/home.dart';
import 'package:skg_hagen/src/appointment/controller/appointment.dart';
import 'package:skg_hagen/src/offer/controller/offer.dart';
import 'package:skg_hagen/src/kindergarten/controller/kindergarten.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  //TODO add cache.
  // TODO If offline, load from cache (add date of loaded so as to add message if older that X days) otherwise show static offline page

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'skg-hagen',
      routes: {
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
