import 'package:flutter/material.dart';
import 'package:skg_hagen/src/menu/controller/menu.dart';
import 'package:skg_hagen/src/kindergarten/model/kindergarten.dart';
import 'package:skg_hagen/src/kindergarten/repository/kindergartenClient.dart';
import 'package:skg_hagen/src/kindergarten/controller/kindergarten.dart'
    as Controller;
import 'package:skg_hagen/src/kindergarten/view/cards.dart';

class Accordions extends State<Controller.Kindergarten> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: Menu(),
        appBar: AppBar(
          title: Text('Ev.Kindergarten'),
        ),
        bottomNavigationBar: Padding(
            padding: EdgeInsets.only(bottom: 30),
            child: Text(
              'Für weitere Infos bitte direkt an das Kindergarten wenden',
              style: TextStyle(color: Colors.grey, fontSize: 10),
              textAlign: TextAlign.center,
            )),
        body: FutureBuilder(
            future: getInfos(),
            builder:
                (BuildContext context, AsyncSnapshot<Kindergarten> response) {
              if (response.connectionState == ConnectionState.none &&
                  response.hasData == null) {
                print('project snapshot data is: ${response.data}');
                return Container();
              }
              if (response.data != null) {
                final List<dynamic> options = List<dynamic>();
                options.add(response.data.events);
                options.add(response.data.news);
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
              children: <Widget>[Image.asset('assets/images/kindergarten.jpg')],
            );
          }
          index -= 1;

          return Cards().buildRows(context, options[index]);
        });
  }

  Future<Kindergarten> getInfos() async {
    return await KindergartenClient().getInfos();
  }
}
