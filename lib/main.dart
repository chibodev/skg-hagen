import 'package:flutter/material.dart';
import 'package:skg_hagen/src/appointment/controller/appointment.dart';
import 'package:skg_hagen/src/common/routes/routes.dart';
import 'package:skg_hagen/src/home/controller/home.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'skg-hagen',
      routes: {
        Routes.home : (context) => Home(),
        Routes.appointment : (context) => Appointment(),
      },
      theme: ThemeData(
        primaryColor: Colors.white, fontFamily: 'Optima'
      ),
      home: Home(),
    );
  }
}
