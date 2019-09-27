import 'package:flutter/material.dart';
import 'package:skg_hagen/src/appointment/controller/appointment.dart';
import 'package:skg_hagen/src/menu/controller/menu.dart';

class Cards extends State<Appointment> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Appointment'),
      ),
      drawer: Menu(),
      body: Center(
        child: Text('Appointment'),
      ),
    );
  }
}
