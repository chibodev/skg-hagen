import 'package:flutter/material.dart';
import 'package:skg_hagen/src/appointment/controller/appointment.dart'
    as Controller;
import 'package:skg_hagen/src/appointment/model/appointment.dart' as Model;
import 'package:skg_hagen/src/appointment/model/appointments.dart';
import 'package:skg_hagen/src/appointment/repository/appointmentClient.dart';
import 'package:skg_hagen/src/common/model/default.dart';
import 'package:skg_hagen/src/common/model/dioHttpClient.dart';
import 'package:skg_hagen/src/common/model/sizeConfig.dart';
import 'package:skg_hagen/src/common/service/network.dart';
import 'package:skg_hagen/src/common/service/tapAction.dart';
import 'package:skg_hagen/src/menu/controller/menu.dart';

class Cards extends State<Controller.Appointment> {
  int _indexCounter = 0;
  Appointments appointments;
  final ScrollController _scrollController = ScrollController();
  bool _isPerformingRequest = false;

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
      drawer: Menu(),
      body: RefreshIndicator(
        onRefresh: () async {
          _getInitialAppointments();
        },
        child: _buildCards(context, appointments),
      ),
    );
  }

  Future<void> _getInitialAppointments() async {
    if (!_isPerformingRequest) {
      setState(() => _isPerformingRequest = true);

      appointments = await AppointmentClient()
          .getAppointments(DioHTTPClient(), Network()); //returns empty list

      if (appointments.appointments.isEmpty) {
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

      final Appointments newAppointments = await AppointmentClient()
          .getAppointments(DioHTTPClient(), Network(),
              index: _indexCounter); //returns empty list

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

  Widget _buildProgressIndicator() {
    return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Opacity(
            opacity: _isPerformingRequest ? 1.0 : 0.0,
            child: CircularProgressIndicator(
              valueColor:
                  AlwaysStoppedAnimation<Color>(Color(Default.COLOR_GREEN)),
            ),
          ),
        ));
  }

  Widget _buildCards(
      BuildContext context, Appointments appointments) {
    return CustomScrollView(
      controller: _scrollController,
      slivers: <Widget>[
        SliverAppBar(
          iconTheme: IconThemeData(color: Colors.white),
          pinned: true,
          expandedHeight: SizeConfig.getSafeBlockVerticalBy(20),
          backgroundColor: Color(Default.COLOR_GREEN),
          flexibleSpace: FlexibleSpaceBar(
            title:
                Text(Appointments.NAME, style: TextStyle(color: Colors.white, fontSize: SizeConfig.getSafeBlockVerticalBy(2.5))),
            background: Image.asset(
              Appointments.IMAGE,
              fit: BoxFit.cover,
            ),
          ),
        ),
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (BuildContext context, int index) {
              return appointments == null ? _buildProgressIndicator() : _buildRows(appointments.appointments[index]);
            },
            childCount: appointments?.appointments?.length ?? 0,
          ),
        ),
        SliverToBoxAdapter(
          child: _buildProgressIndicator(),
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
                  Padding(
                    padding: EdgeInsets.only(left: SizeConfig.getSafeBlockVerticalBy(1), top: SizeConfig.getSafeBlockVerticalBy(2)),
                    child: Text(card.title, style: TextStyle(fontSize: SizeConfig.getSafeBlockVerticalBy(2)),),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: SizeConfig.getSafeBlockVerticalBy(1), top: SizeConfig.getSafeBlockVerticalBy(1)),
                    child: Text(
                      card.getFormattedTime(),
                      style: TextStyle(
                          color: Colors.grey, fontWeight: FontWeight.bold, fontSize: SizeConfig.getSafeBlockVerticalBy(2)),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: SizeConfig.getSafeBlockVerticalBy(1), top: SizeConfig.getSafeBlockVerticalBy(1), bottom: SizeConfig.getSafeBlockVerticalBy(2)),
                    child: Text(card.getFormattedOrganiser(),
                        style: TextStyle(color: Colors.grey, fontSize: SizeConfig.getSafeBlockVerticalBy(1.7))),
                  ),
                ],
              ),
            ),
            Container(
              color: Color(Default.COLOR_GREEN),
              width: SizeConfig.getSafeBlockVerticalBy(15),
              height: SizeConfig.getSafeBlockHorizontalBy(22.5),
              child: InkWell(
                splashColor: Color(Default.COLOR_GREEN),
                onTap: () => TapAction().openMap(card.address.name),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(Default.capitalize(card.address.name),
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold, fontSize: SizeConfig.getSafeBlockVerticalBy(1.7))),
                    Text(card.address.street,
                        style: TextStyle(color: Colors.white, fontSize: SizeConfig.getSafeBlockVerticalBy(1.7))),
                    Text(card.address.getZipAndCity(),
                        style: TextStyle(color: Colors.white, fontSize: SizeConfig.getSafeBlockVerticalBy(1.7))),
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
