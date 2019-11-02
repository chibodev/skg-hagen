import 'package:flutter/material.dart';
import 'package:skg_hagen/src/appointment/controller/appointment.dart'
    as Controller;
import 'package:skg_hagen/src/appointment/model/appointment.dart' as Model;
import 'package:skg_hagen/src/appointment/model/appointments.dart';
import 'package:skg_hagen/src/appointment/repository/appointmentClient.dart';
import 'package:skg_hagen/src/common/model/default.dart';
import 'package:skg_hagen/src/common/model/dioHttpClient.dart';
import 'package:skg_hagen/src/common/service/network.dart';
import 'package:skg_hagen/src/common/service/tapAction.dart';
import 'package:skg_hagen/src/menu/controller/menu.dart';

class Cards extends State<Controller.Appointment> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(Appointments.NAME),
      ),
      drawer: Menu(),
      body: FutureBuilder(
        future: _getAppointments(),
        builder: (BuildContext context, AsyncSnapshot<Appointments> response) {
          if (response.connectionState == ConnectionState.done &&
              response.data != null) {
            return _buildCards(response.data.appointments);
          }
          return Center(
              child: CircularProgressIndicator(
            valueColor:
                AlwaysStoppedAnimation<Color>(Color(Default.COLOR_GREEN)),
          ));
        },
      ),
    );
  }

  Widget _buildCards(List<Model.Appointment> appointments) {
    return ListView.builder(
        padding: EdgeInsets.zero,
        itemCount: appointments.length + 1,
        itemBuilder: (BuildContext context, int index) {
          if (index == 0) {
            // return the header
            return Column(
              children: <Widget>[Image.asset(Appointments.IMAGE)],
            );
          }
          index -= 1;

          return _buildRows(appointments[index]);
        });
  }

  Future<Appointments> _getAppointments() async {
    return await AppointmentClient()
        .getAppointments(DioHTTPClient(), Network());
  }

  Widget _buildRows(Model.Appointment card) {
    String capitalize(String s) => s[0].toUpperCase() + s.substring(1);
    final String organizer =
        (card.organizer.length > 0) ? 'Infos: ' + card.organizer : '';
    return Material(
      child: Card(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(left: 10.0, top: 10.0),
                    child: Text(card.title),
                  ),
                  Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Text(
                      card.getFormattedTime(),
                      style: TextStyle(
                          color: Colors.grey, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 10.0, bottom: 10),
                    child:
                        Text(organizer, style: TextStyle(color: Colors.grey)),
                  ),
                ],
              ),
            ),
            Container(
              color: Color(Default.COLOR_GREEN),
              width: 125,
              height: 100,
              child: InkWell(
                splashColor: Color(Default.COLOR_GREEN),
                onTap: () => TapAction().openMap(card.address.name),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(capitalize(card.address.name),
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold)),
                    Text(card.address.street,
                        style: TextStyle(color: Colors.white)),
                    Text(card.address.getZipAndCity(),
                        style: TextStyle(color: Colors.white)),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
