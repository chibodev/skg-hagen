import 'package:flutter/material.dart';
import 'package:skg_hagen/src/common/model/dioHttpClient.dart';
import 'package:skg_hagen/src/common/model/sizeConfig.dart';
import 'package:skg_hagen/src/common/service/network.dart';
import 'package:skg_hagen/src/menu/controller/menu.dart';
import 'package:skg_hagen/src/offer/controller/offer.dart' as Controller;
import 'package:skg_hagen/src/offer/model/offers.dart';
import 'package:skg_hagen/src/offer/repository/offerClient.dart';
import 'package:skg_hagen/src/offer/view/cards.dart';

class Accordions extends State<Controller.Offer> {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
        drawer: Menu(),
        appBar: AppBar(
          title: Text('Angebote'),
        ),
        bottomNavigationBar: Padding(
            padding: EdgeInsets.only(bottom: 30),
            child: Text(
              Offers.FOOTER,
              style: TextStyle(color: Colors.grey, fontSize: SizeConfig.getSafeBlockVerticalBy(1.4)),
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
              children: <Widget>[Image.asset('assets/images/gruppen.jpg')],
            );
          }
          index -= 1;

          return Cards().buildRows(options[index]);
        });
  }

  Future<Offers> getOffers() async {
    return await OfferClient().getOffers(DioHTTPClient(), Network());
  }
}
