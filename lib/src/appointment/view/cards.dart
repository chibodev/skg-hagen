import 'package:flutter/material.dart';
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
                  : _buildRows(appointments.appointments[index]);
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

  Widget _buildRows(Model.Appointment card) {
    return Material(
      child: Card(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  CustomWidget.getCardTitle(card.title),
                  CustomWidget.getOccurrence(card.getFormattedTime()),
                  CustomWidget.getCardOrganizerWithEmail(
                      card.getFormattedOrganiser(), card.email, card.title),
                  CustomWidget.getAddressWithAction(card.address)
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
