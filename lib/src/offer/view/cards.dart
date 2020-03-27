import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:skg_hagen/src/common/library/globals.dart';
import 'package:skg_hagen/src/common/model/default.dart';
import 'package:skg_hagen/src/common/model/sizeConfig.dart';
import 'package:skg_hagen/src/common/view/customWidget.dart';
import 'package:skg_hagen/src/offer/controller/aid.dart' as Controller;
import 'package:skg_hagen/src/offer/controller/aidReceive.dart';
import 'package:skg_hagen/src/offer/controller/conceptController.dart';
import 'package:skg_hagen/src/offer/controller/confirmationAppointmentController.dart';
import 'package:skg_hagen/src/offer/controller/musicController.dart';
import 'package:skg_hagen/src/offer/controller/projectsController.dart';
import 'package:skg_hagen/src/offer/controller/quoteController.dart';
import 'package:skg_hagen/src/offer/model/aid.dart';
import 'package:skg_hagen/src/offer/model/aidOffer.dart' as ModelAidOffer;
import 'package:skg_hagen/src/offer/model/aidReceive.dart' as ModelAidReceive;
import 'package:skg_hagen/src/offer/model/appointment.dart';
import 'package:skg_hagen/src/offer/model/concept.dart';
import 'package:skg_hagen/src/offer/model/confirmation.dart';
import 'package:skg_hagen/src/offer/model/music.dart';
import 'package:skg_hagen/src/offer/model/offer.dart';
import 'package:skg_hagen/src/offer/model/project.dart';
import 'package:skg_hagen/src/offer/model/quote.dart';

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
    } else if (card is Aid) {
      subjectName = Aid.NAME;
      list.add(_buildTileForAid(context, card));
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
                child: Container(
                  width: SizeConfig.screenHeight,
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
                    ],
                  ),
                ),
              ),
              (card.address.street == null || card.address.name == null)
                  ? CustomWidget.getNoLocation()
                  : CustomWidget.getAddressWithAction(card.address,
                      room: card.room),
            ],
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
                builder: (BuildContext _context) => ProjectsController(
                  project: card,
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
                          size: SizeConfig.getSafeBlockVerticalBy(
                              appFont.iconSize),
                        ),
                        title: CustomWidget.getCardTitle(card.title),
                      ),
                    ),
                  ),
                ),
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
          child: InkWell(
            splashColor: Color(Default.COLOR_GREEN),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute<dynamic>(
                builder: (BuildContext _context) => MusicController(
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
                      leading: Icon(Icons.info,
                          color: Color(Default.COLOR_GREEN),
                          size: SizeConfig.getSafeBlockVerticalBy(
                              appFont.iconSize)),
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
                      child: InkWell(
                        splashColor: Color(Default.COLOR_GREEN),
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute<dynamic>(
                            builder: (BuildContext _context) =>
                                ConceptController(
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
                                size: SizeConfig.getSafeBlockVerticalBy(
                                    appFont.iconSize),
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
                      child: InkWell(
                        splashColor: Color(Default.COLOR_GREEN),
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute<dynamic>(
                            builder: (BuildContext _context) => QuoteController(
                              quotes: card.quote,
                              context: context,
                              dataAvailable: this._dataAvailable,
                            ),
                          ),
                        ),
                        child: Container(
                          child: Padding(
                            padding: const EdgeInsets.all(1.0),
                            child: ListTile(
                              leading: Icon(Icons.message,
                                  color: Color(Default.COLOR_GREEN),
                                  size: SizeConfig.getSafeBlockVerticalBy(
                                      appFont.iconSize)),
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
                      child: InkWell(
                        splashColor: Color(Default.COLOR_GREEN),
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute<dynamic>(
                            builder: (BuildContext _context) =>
                                ConfirmationAppointmentController(
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

  Widget _buildTileForAid(BuildContext context, Aid card) {
    final Controller.Aid aidOffer = Controller.Aid(
      aidOffer: card?.offer,
      context: context,
      dataAvailable: this._dataAvailable,
      aidOfferQuestion: card?.offerQuestion,
    );

    final AidReceive aidReceive = AidReceive(
      aidReceive: card?.receive,
      buildContext: context,
      dataAvailable: this._dataAvailable,
    );

    return Material(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          card.offer != null
              ? getAidContent(context, card, aidOffer,
                  ModelAidOffer.AidOffer.VOLUNTEER, ModelAidOffer.AidOffer.NAME)
              : Container(),
          card.receive != null
              ? getAidContent(
                  context,
                  card,
                  aidReceive,
                  ModelAidReceive.AidReceive.HELP,
                  ModelAidReceive.AidReceive.NAME)
              : Container(),
        ],
      ),
    );
  }

  Flexible getAidContent(BuildContext context, dynamic card,
      dynamic offerWidget, String iconImage, String cardTitle) {
    return Flexible(
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
                builder: (BuildContext _context) => offerWidget,
              ),
            ),
            child: Container(
              child: Padding(
                padding: const EdgeInsets.all(1.0),
                child: ListTile(
                  leading: ImageIcon(
                    AssetImage(iconImage),
                    color: Color(Default.COLOR_GREEN),
                    size: SizeConfig.getSafeBlockVerticalBy(appFont.iconSize),
                  ),
                  title: CustomWidget.getCardTitle(cardTitle),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
