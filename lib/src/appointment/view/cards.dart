import 'package:flutter/material.dart';
import 'package:skg_hagen/src/appointment/controller/appointment.dart'
    as Controller;
import 'package:skg_hagen/src/appointment/model/appointment.dart' as DTO;
import 'package:skg_hagen/src/appointment/repository/appointmentClient.dart';
import 'package:skg_hagen/src/common/service/tapAction.dart';
import 'package:skg_hagen/src/menu/controller/menu.dart';

class Cards extends State<Controller.Appointment> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Termine'),
      ),
      drawer: Menu(),
      body: _buildCards(),
    );
  }

  Widget _buildCards() {
    final List<DTO.Appointment> appointments = AppointmentClient().getAppointments();

    return ListView.builder(
        padding: EdgeInsets.zero,
        itemCount: appointments.length+1,
        itemBuilder: (context, index) {
          if (index == 0) {
            // return the header
            return Column(
              children: <Widget>[Image.asset('assets/images/termine.jpg')],
            );
          }
          index -= 1;

          return _buildRows(appointments[index]);
        });
  }

  Widget _buildRows(DTO.Appointment card) {
    String organizer = (card.organizer != null) ? 'Infos: ' + card.organizer : '';
    return Material(
      child: Card(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(left: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.all(3.0),
                    child: Text(card.title),
                  ),
                  Padding(
                    padding: EdgeInsets.all(3.0),
                    child: Text(
                      card.getFormattedTime(),
                      style: TextStyle(
                          color: Colors.grey, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(3.0),
                    child: Text(organizer,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(color: Colors.grey)),
                  ),
                ],
              ),
            ),
            Container(
              color: Color(0xFF8EBC6B),
              width: 125,
              height: 100,
              child: InkWell(
                splashColor: Color(0xFF8EBC6B),
                onTap: () =>
                    TapAction().openMap(card.address.name),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(card.address.name,
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
