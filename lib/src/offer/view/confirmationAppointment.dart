import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:skg_hagen/src/common/dto/default.dart';
import 'package:skg_hagen/src/common/dto/sizeConfig.dart';
import 'package:skg_hagen/src/common/routes/routes.dart';
import 'package:skg_hagen/src/common/service/analyticsManager.dart';
import 'package:skg_hagen/src/common/view/customWidget.dart';
import 'package:skg_hagen/src/offer/controller/confirmationAppointmentController.dart';
import 'package:skg_hagen/src/offer/dto/appointment.dart';
import 'package:skg_hagen/src/offer/dto/offers.dart';
import 'package:skg_hagen/src/settings/view/settingsMenu.dart';

class ConfirmationAppointment extends State<ConfirmationAppointmentController> {
  SettingsMenu settingsMenu;

  @override
  void initState() {
    super.initState();
    settingsMenu = SettingsMenu(pageView: this);
    AnalyticsManager().setScreen(
        Appointment.PAGE_NAME, Default.classNameFromRoute(Routes.offer));
  }

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
                titlePadding: const EdgeInsetsDirectional.only(
                    start: 72, bottom: 16, end: 102),
                title: CustomWidget.getTitle(Appointment.PAGE_NAME),
                background: Image.asset(
                  Offers.IMAGE,
                  fit: BoxFit.cover,
                ),
              ),
              actions: <Widget>[settingsMenu.getMenu()],
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (BuildContext context, int index) => widget.dataAvailable
                    ? _buildRows(widget.appointment[index], context)
                    : CustomWidget.buildSliverSpinner(),
                childCount: widget?.appointment?.length ?? 0,
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          !widget.dataAvailable ? CustomWidget.noInternet() : Container(),
        ],
      ),
    );
  }

  Widget _buildRows(Appointment card, BuildContext context) {
    return Material(
      child: Padding(
        padding: EdgeInsets.only(
          bottom: SizeConfig.getSafeBlockHorizontalBy(3),
        ),
        child: Card(
          elevation: 7,
          shape: Border(
            left: BorderSide(
              color: Color(Default.COLOR_GREEN),
              width: SizeConfig.getSafeBlockHorizontalBy(1),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Slidable(
                actionPane: SlidableDrawerActionPane(),
                actionExtentRatio: Default.SLIDE_RATIO,
                actions: card.endOccurrence != null
                    ? _getSlidableWithCalendar(card)
                    : <Widget>[
                        CustomWidget.getSlidableShare(
                          card.title,
                          Default.getSharableContent(
                            card.title,
                            card.getFormattedTimeAsString(),
                            card.getFormattedOrganiser(),
                            card.address,
                          ),
                        )
                      ],
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    CustomWidget.getCardTitle(card.title),
                    CustomWidget.getOccurrence(
                      card.getFormattedTimeAsString(),
                    ),
                    CustomWidget.getCardOrganizer(
                        card.getFormattedOrganiser(), context),
                    CustomWidget.getCardEmail(card.email, card.title, context),
                  ],
                ),
              ),
              CustomWidget.getAddressWithAction(card.address)
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> _getSlidableWithCalendar(Appointment card) {
    return <Widget>[
      CustomWidget.getSlidableShare(
        card.title,
        Default.getSharableContent(
          card.title,
          card.getFormattedTimeAsString(),
          card.getFormattedOrganiser(),
          card?.address,
        ),
      ),
      CustomWidget.getSlidableCalender(
          card.title,
          card.getFormattedOrganiser(),
          card.address,
          card.getFormattedTime(),
          card.getFormattedClosingTime()),
    ];
  }
}
