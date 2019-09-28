import 'package:flutter/material.dart';
import 'package:skg_hagen/src/menu/controller/menu.dart';
import 'package:skg_hagen/src/offer/controller/offer.dart';

class Accordions extends State<Offer> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Menu(),
      appBar: AppBar(
        title: Text('Angebote'),
      ),
      body: Center(
        child: Text('Angebote, Gruppen, Kreisen'),
      ),
    );
  }
}
