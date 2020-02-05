import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:skg_hagen/src/appointment/controller/appointment.dart'
    as Controller;
import 'package:skg_hagen/src/appointment/model/appointment.dart' as Model;
import 'package:skg_hagen/src/appointment/model/appointments.dart';
import 'package:skg_hagen/src/appointment/repository/appointmentClient.dart';
import 'package:skg_hagen/src/common/model/default.dart';
import 'package:skg_hagen/src/common/model/sizeConfig.dart';
import 'package:skg_hagen/src/common/service/client/dioHttpClient.dart';
import 'package:skg_hagen/src/common/service/network.dart';
import 'package:skg_hagen/src/common/view/customWidget.dart';

class Cards extends State<Controller.Appointment> {
  int _indexCounter = 0;
  Appointments appointments;
  final ScrollController _scrollController = ScrollController();
  bool _isPerformingRequest = false;
  bool _hasInternet = true;

  @override
  void initState() {
    super.initState();
    _getInitialAppointments();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        _getMoreAppointments();
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () async {
          _getInitialAppointments();
        },
        child: _buildCards(context, appointments),
      ),
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          !_hasInternet ? CustomWidget.noInternet() : Container()
        ],
      ),
    );
  }

  Future<void> _getInitialAppointments() async {
    if (!_isPerformingRequest) {
      setState(() => _isPerformingRequest = true);
      _hasInternet = true;

      appointments = await AppointmentClient()
          .getAppointments(DioHTTPClient(), Network(), refresh: true);

      final bool status = appointments?.appointments != null;
      _hasInternet = await Network().hasInternet();

      if (status && appointments.appointments.isEmpty) {
        final double edge = 50.0;
        final double offsetFromBottom =
            _scrollController.position.maxScrollExtent -
                _scrollController.position.pixels;
        if (offsetFromBottom < edge) {
          _scrollController.animateTo(
              _scrollController.offset - (edge - offsetFromBottom),
              duration: Duration(milliseconds: 500),
              curve: Curves.easeOut);
        }
      }
      setState(() {
        _isPerformingRequest = false;
        _indexCounter = 1;
      });
    }
  }

  Future<void> _getMoreAppointments() async {
    if (!_isPerformingRequest) {
      setState(() => _isPerformingRequest = true);

      _hasInternet = await Network().hasInternet();
      if (!_hasInternet) {
        _isPerformingRequest = false;
      } else {
        final Appointments newAppointments = await AppointmentClient()
            .getAppointments(DioHTTPClient(), Network(),
                index: _indexCounter, refresh: true);

        final List<Model.Appointment> newEntries = newAppointments.appointments;
        final bool isResponseEmpty = newEntries.isEmpty;
        if (isResponseEmpty) {
          final double edge = 50.0;
          final double offsetFromBottom =
              _scrollController.position.maxScrollExtent -
                  _scrollController.position.pixels;
          if (offsetFromBottom < edge) {
            _scrollController.animateTo(
                _scrollController.offset - (edge - offsetFromBottom),
                duration: Duration(milliseconds: 500),
                curve: Curves.easeOut);
          }
        }
        setState(() {
          _isPerformingRequest = false;
          if (!isResponseEmpty) {
            appointments.appointments.addAll(newEntries);
            _indexCounter++;
          }
        });
      }
    }
  }

  Widget _buildCards(BuildContext context, Appointments appointments) {
    return CustomScrollView(
      controller: _scrollController,
      slivers: <Widget>[
        SliverAppBar(
          iconTheme: IconThemeData(color: Colors.white),
          pinned: true,
          expandedHeight: SizeConfig.getSafeBlockVerticalBy(20),
          backgroundColor: Color(Default.COLOR_GREEN),
          flexibleSpace: FlexibleSpaceBar(
            title: CustomWidget.getTitle(Appointments.NAME),
            background: Image.asset(
              Appointments.IMAGE,
              fit: BoxFit.cover,
            ),
          ),
        ),
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (BuildContext context, int index) {
              return appointments == null
                  ? CustomWidget.buildProgressIndicator(_isPerformingRequest)
                  : _buildRows(context, appointments.appointments[index]);
            },
            childCount: appointments?.appointments?.length ?? 0,
          ),
        ),
        SliverToBoxAdapter(
          child: (!_hasInternet)
              ? Container()
              : CustomWidget.buildProgressIndicator(_isPerformingRequest),
        )
      ],
    );
  }

  Widget _buildRows(BuildContext context, Model.Appointment card) {
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

  List<Widget> _getSlidableWithCalendar(Model.Appointment card) {
    return <Widget>[
      CustomWidget.getSlidableCalender(
        card.title,
        card.getFormattedOrganiser(),
        card.address,
        card.getFormattedTime(),
        card.getFormattedClosingTime(),
      ),
      CustomWidget.getSlidableShare(
        card.title,
        Default.getSharableContent(
          card.title,
          card.getFormattedTimeAsString(),
          card.getFormattedOrganiser(),
          card?.address,
        ),
      ),
    ];
  }
}
