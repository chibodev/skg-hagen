import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:skg_hagen/src/common/model/default.dart';
import 'package:skg_hagen/src/common/model/sizeConfig.dart';
import 'package:skg_hagen/src/common/view/customWidget.dart';
import 'package:skg_hagen/src/offer/model/appointment.dart';
import 'package:skg_hagen/src/offer/model/offers.dart';

class ConfirmationAppointment extends StatelessWidget {
  final List<Appointment> appointment;
  final BuildContext context;
  final bool dataAvailable;

  const ConfirmationAppointment(
      {Key key,
      this.context,
      @required this.appointment,
      this.dataAvailable = true})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      body: Container(
        child: CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              iconTheme: IconThemeData(color: Colors.white),
              pinned: true,
              expandedHeight: SizeConfig.getSafeBlockVerticalBy(20),
              backgroundColor: Color(Default.COLOR_GREEN),
              flexibleSpace: FlexibleSpaceBar(
                title: CustomWidget.getTitle(Appointment.PAGE_NAME),
                background: Image.asset(
                  Offers.IMAGE,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (BuildContext context, int index) => dataAvailable
                    ? _buildRows(this.appointment[index], context)
                    : CustomWidget.buildSliverSpinner(),
                childCount: appointment?.length ?? 0,
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          !dataAvailable ? CustomWidget.noInternet() : Container(),
        ],
      ),
    );
  }

  Widget _buildRows(Appointment appointment, BuildContext context) {
    return Material(
      child: Padding(
        padding: EdgeInsets.only(
          bottom: SizeConfig.getSafeBlockHorizontalBy(3),
        ),
        child: Card(
          elevation: 7,
          shape: Border(
            right: BorderSide(
              color: Color(Default.COLOR_GREEN),
              width: SizeConfig.getSafeBlockHorizontalBy(1),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              appointment.endOccurrence != null
                  ? CustomWidget.getAddToCalender(
                      appointment.title,
                      appointment.getFormattedOrganiser(),
                      appointment.address,
                      appointment.getFormattedTime(),
                      appointment.getFormattedClosingTime(),
                      context,
                    )
                  : Text(''),
              CustomWidget.getCardTitle(appointment.title),
              CustomWidget.getOccurrence(
                appointment.getFormattedTimeAsString(),
              ),
              CustomWidget.getCardOrganizer(
                  appointment.getFormattedOrganiser(), context),
              CustomWidget.getCardEmail(
                  appointment.email, appointment.title, context),
              CustomWidget.getAddressWithAction(appointment.address)
            ],
          ),
        ),
      ),
    );
  }
}
