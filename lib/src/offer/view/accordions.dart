import 'package:flutter/material.dart';
import 'package:skg_hagen/src/menu/controller/menu.dart';
import 'package:skg_hagen/src/offer/controller/offer.dart' as Controller;
import 'package:skg_hagen/src/offer/model/offers.dart';
import 'package:skg_hagen/src/offer/repository/offerClient.dart';
import 'package:skg_hagen/src/offer/view/cards.dart';

class Accordions extends State<Controller.Offer> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: Menu(),
        appBar: AppBar(
          title: Text('Angebote'),
        ),
        bottomNavigationBar: Padding(
            padding: EdgeInsets.only(bottom: 30),
            child: Text(
              'Ob Gruppen oder Kreise stattfinden bitte bei den Gruppenleitungen erfragen!',
              style: TextStyle(color: Colors.grey, fontSize: 10),
              textAlign: TextAlign.center,
            )),
        body: FutureBuilder(
            future: getOffers(),
            builder: (BuildContext context, AsyncSnapshot<Offers> response) {
              if (response.connectionState == ConnectionState.none &&
                  response.hasData == null) {
                print('project snapshot data is: ${response.data}');
                return Container();
              }
              if (response.data != null) {
                final List<dynamic> options = List<dynamic>();
                options.add(response.data.offers);
                options.add(response.data.groups);
                return _buildCards(options);
              }
              return Container();
            }));
  }

  Widget _buildCards(List<dynamic> options) {
    return ListView.builder(
        padding: EdgeInsets.zero,
        itemCount: options.length + 1,
        itemBuilder: (BuildContext context, int index) {
          if (index == 0) {
            // return the header
            return Column(
              children: <Widget>[Image.asset('assets/images/angebote.jpg')],
            );
          }
          index -= 1;

          return Cards().buildRows(options[index]);
        });
  }

  Future<Offers> getOffers() async {
    return await OfferClient().getOffers();
  }
}
