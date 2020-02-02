import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:skg_hagen/src/common/model/default.dart';
import 'package:skg_hagen/src/common/model/sizeConfig.dart';
import 'package:skg_hagen/src/common/view/customWidget.dart';
import 'package:skg_hagen/src/offer/model/appointment.dart';
import 'package:skg_hagen/src/offer/model/concept.dart';
import 'package:skg_hagen/src/offer/model/confirmation.dart';
import 'package:skg_hagen/src/offer/model/music.dart';
import 'package:skg_hagen/src/offer/model/offer.dart';
import 'package:skg_hagen/src/offer/model/project.dart';
import 'package:skg_hagen/src/offer/model/quote.dart';
import 'package:skg_hagen/src/offer/view/concept.dart' as View;
import 'package:skg_hagen/src/offer/view/confirmationAppointment.dart';
import 'package:skg_hagen/src/offer/view/music.dart' as View;
import 'package:skg_hagen/src/offer/view/projects.dart';
import 'package:skg_hagen/src/offer/view/quote.dart' as View;

class Cards {
  BuildContext _buildContext;
  bool _dataAvailable;

  Widget buildRows(BuildContext context, dynamic card, bool dataAvailable) {
    this._buildContext = context;
    this._dataAvailable = dataAvailable;
    String subjectName = "";

    final List<Widget> list = List<Widget>();

    if (card is List<Offer>) {
      for (int i = 0; i < card.length; i++) {
        subjectName = Offer.NAME;
        list.add(_buildTileForOffers(card[i]));
      }
    } else if (card is List<Music>) {
      for (int i = 0; i < card.length; i++) {
        subjectName = Music.NAME;
        list.add(_buildTileForMusic(context, card[i]));
      }
    } else if (card is List<Project>) {
      for (int i = 0; i < card.length; i++) {
        subjectName = Project.NAME;
        list.add(_buildTileForProjects(context, card[i]));
      }
    } else if (card is Confirmation) {
      subjectName = Confirmation.NAME;
      list.add(_buildTileForConfirmation(context, card));
    }

    return card != null
        ? ExpansionTile(
            title: CustomWidget.getAccordionTitle(subjectName),
            children: list,
          )
        : Container();
  }

  Widget _buildTileForOffers(Offer card) {
    return Material(
      child: Padding(
        padding: EdgeInsets.only(
          bottom: SizeConfig.getSafeBlockHorizontalBy(3),
        ),
        child: Slidable(
          actionPane: SlidableDrawerActionPane(),
          actionExtentRatio: 0.25,
          actions: <Widget>[
            CustomWidget.getSlidableShare(
              card.title,
              Default.getSharableContent(
                card.title,
                card.getFormattedOccurrence(),
                card.getFormattedOrganiser(),
                card.address,
              ),
            )
          ],
          child: Card(
            elevation: 7,
            shape: Border(
              left: BorderSide(
                color: Color(Default.COLOR_GREEN),
                width: SizeConfig.getSafeBlockHorizontalBy(1),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      CustomWidget.getCardTitle(card.title),
                      CustomWidget.getOccurrence(
                        card.getFormattedOccurrence(),
                      ),
                      CustomWidget.getCardOrganizer(
                          card.getFormattedOrganiser(), this._buildContext),
                      CustomWidget.getCardEmail(
                          card.email, card.title, this._buildContext),
                      (card.address.street == null || card.address.name == null)
                          ? CustomWidget.getNoLocation()
                          : CustomWidget.getAddressWithAction(card.address,
                              room: card.room),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTileForProjects(BuildContext context, Project card) {
    return Material(
      child: Padding(
        padding: EdgeInsets.only(
          bottom: SizeConfig.getSafeBlockHorizontalBy(3),
        ),
        child: Card(
          elevation: 7,
          child: InkWell(
            splashColor: Color(Default.COLOR_GREEN),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute<dynamic>(
                builder: (BuildContext _context) => Projects(
                  projects: card,
                  context: context,
                ),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Flexible(
                    child: Container(
                  child: Padding(
                    padding: const EdgeInsets.all(1.0),
                    child: ListTile(
                      leading: Icon(
                        Icons.info,
                        color: Color(Default.COLOR_GREEN),
                      ),
                      title: CustomWidget.getCardTitle(card.title),
                    ),
                  ),
                )),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTileForMusic(BuildContext context, Music card) {
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
          child: InkWell(
            splashColor: Color(Default.COLOR_GREEN),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute<dynamic>(
                builder: (BuildContext _context) => View.Music(
                  music: card,
                  context: context,
                ),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Flexible(
                    child: Container(
                  child: Padding(
                    padding: const EdgeInsets.all(1.0),
                    child: ListTile(
                      leading: Icon(
                        Icons.info,
                        color: Color(Default.COLOR_GREEN),
                      ),
                      title: CustomWidget.getCardTitle(card.title),
                    ),
                  ),
                )),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTileForConfirmation(BuildContext context, Confirmation card) {
    return Material(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          card.concept != null
              ? Flexible(
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
                      child: InkWell(
                        splashColor: Color(Default.COLOR_GREEN),
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute<dynamic>(
                            builder: (BuildContext _context) => View.Concept(
                              concept: card.concept,
                              context: context,
                              dataAvailable: this._dataAvailable,
                            ),
                          ),
                        ),
                        child: Container(
                          child: Padding(
                            padding: const EdgeInsets.all(1.0),
                            child: ListTile(
                              leading: Icon(
                                Icons.lightbulb_outline,
                                color: Color(Default.COLOR_GREEN),
                              ),
                              title: CustomWidget.getCardTitle(Concept.NAME),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                )
              : Container(),
          card.quote != null
              ? Flexible(
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
                      child: InkWell(
                        splashColor: Color(Default.COLOR_GREEN),
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute<dynamic>(
                            builder: (BuildContext _context) => View.Quote(
                              quote: card.quote,
                              context: context,
                              dataAvailable: this._dataAvailable,
                            ),
                          ),
                        ),
                        child: Container(
                          child: Padding(
                            padding: const EdgeInsets.all(1.0),
                            child: ListTile(
                              leading: Icon(
                                Icons.message,
                                color: Color(Default.COLOR_GREEN),
                              ),
                              title: CustomWidget.getCardTitle(Quote.NAME),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                )
              : Container(),
          card.appointment != null
              ? Flexible(
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
                      child: InkWell(
                        splashColor: Color(Default.COLOR_GREEN),
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute<dynamic>(
                            builder: (BuildContext _context) =>
                                ConfirmationAppointment(
                              appointment: card.appointment,
                              context: context,
                              dataAvailable: this._dataAvailable,
                            ),
                          ),
                        ),
                        child: Container(
                          child: Padding(
                            padding: const EdgeInsets.all(1.0),
                            child: ListTile(
                              leading: Icon(
                                Icons.list,
                                color: Color(Default.COLOR_GREEN),
                              ),
                              title:
                                  CustomWidget.getCardTitle(Appointment.NAME),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                )
              : Container(),
        ],
      ),
    );
  }
}
