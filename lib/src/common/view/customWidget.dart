import 'package:add_2_calendar/add_2_calendar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:share/share.dart';
import 'package:skg_hagen/src/common/model/address.dart';
import 'package:skg_hagen/src/common/model/default.dart';
import 'package:skg_hagen/src/common/model/sizeConfig.dart';
import 'package:skg_hagen/src/common/service/clipboard.dart';
import 'package:skg_hagen/src/common/service/network.dart';
import 'package:skg_hagen/src/common/service/tapAction.dart';

class CustomWidget {
  static Padding buildProgressIndicator(bool _isPerformingRequest) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Center(
        child: AnimatedOpacity(
          duration: Duration.zero,
          opacity: _isPerformingRequest ? 1.0 : 0.0,
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(
              Color(Default.COLOR_GREEN),
            ),
          ),
        ),
      ),
    );
  }

  static Widget buildSliverSpinner() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Center(
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(
            Color(Default.COLOR_GREEN),
          ),
        ),
      ),
    );
  }

  static Text getTitle(String name,
      {bool noShadow, Color color, Color shadowInner, Color shadowOuter}) {
    return Text(
      name,
      style: TextStyle(
        color: (color != null) ? color : Colors.white,
        fontSize: SizeConfig.getSafeBlockVerticalBy(Default.STANDARD_FONT_SIZE),
        shadows: noShadow == null
            ? <Shadow>[
                Shadow(
                  offset: Offset(SizeConfig.getSafeBlockVerticalBy(0.2),
                      SizeConfig.getSafeBlockVerticalBy(0.2)),
                  blurRadius: 3.0,
                  color: shadowInner != null ? shadowInner : Colors.black45,
                ),
                Shadow(
                  offset: Offset(SizeConfig.getSafeBlockVerticalBy(0.2),
                      SizeConfig.getSafeBlockVerticalBy(0.2)),
                  blurRadius: 8.0,
                  color: shadowOuter != null ? shadowOuter : Colors.black45,
                ),
              ]
            : <Shadow>[],
      ),
    );
  }

  static Padding getCardTitle(String title, {bool textColor}) {
    return Padding(
      padding: EdgeInsets.only(
        left: SizeConfig.getSafeBlockVerticalBy(2),
        top: SizeConfig.getSafeBlockVerticalBy(2),
      ),
      child: Text(
        title,
        style: TextStyle(
          fontSize:
              SizeConfig.getSafeBlockVerticalBy(Default.STANDARD_FONT_SIZE),
          color: textColor == true ? Colors.white : Colors.black,
        ),
      ),
    );
  }

  static Padding getOccurrence(String occurrence) {
    return Padding(
      padding: EdgeInsets.only(
        left: SizeConfig.getSafeBlockVerticalBy(2),
        top: SizeConfig.getSafeBlockVerticalBy(1),
        bottom: SizeConfig.getSafeBlockVerticalBy(1),
      ),
      child: Text(
        Default.capitalize(occurrence),
        style: TextStyle(
          color: Colors.grey,
          fontWeight: FontWeight.bold,
          fontSize:
              SizeConfig.getSafeBlockVerticalBy(Default.STANDARD_FONT_SIZE),
        ),
      ),
    );
  }

  static Container getAddressWithAction(Address address, {String room}) {
    return Container(
      width: SizeConfig.screenHeight,
      height: SizeConfig.getSafeBlockHorizontalBy(22.5),
      decoration: BoxDecoration(color: Color(Default.COLOR_GREEN)),
      child: InkWell(
        splashColor: Color(Default.COLOR_GREEN),
        onTap: () => TapAction().openMap(address.latLong, address.name),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            room != null
                ? Text(
                    Default.capitalize(room),
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: SizeConfig.getSafeBlockVerticalBy(
                          Default.SUBSTANDARD_FONT_SIZE),
                    ),
                  )
                : Container(),
            address.name != null
                ? Text(
                    Default.capitalize(address.name),
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: SizeConfig.getSafeBlockVerticalBy(
                          Default.SUBSTANDARD_FONT_SIZE),
                    ),
                  )
                : Container(),
            address.street != null
                ? Text(
                    address.getStreetAndNumber(),
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: SizeConfig.getSafeBlockVerticalBy(
                          Default.SUBSTANDARD_FONT_SIZE),
                    ),
                  )
                : Container(),
            address.zip != null
                ? Text(
                    address.getZipAndCity(),
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: SizeConfig.getSafeBlockVerticalBy(
                          Default.SUBSTANDARD_FONT_SIZE),
                    ),
                  )
                : Container(),
          ],
        ),
      ),
    );
  }

  static Container getNoLocation() {
    return Container(
      color: Color(Default.COLOR_GREEN),
      width: SizeConfig.screenHeight,
      height: SizeConfig.getSafeBlockHorizontalBy(22.5),
    );
  }

  static Padding getCardSubtitle(String text, {bool textColor}) {
    return Padding(
      padding: EdgeInsets.only(
        left: SizeConfig.getSafeBlockVerticalBy(2),
        right: SizeConfig.getSafeBlockVerticalBy(2),
        top: SizeConfig.getSafeBlockVerticalBy(1),
        bottom: SizeConfig.getSafeBlockVerticalBy(2),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: textColor == true ? Colors.white : Colors.grey,
          fontSize:
              SizeConfig.getSafeBlockVerticalBy(Default.SUBSTANDARD_FONT_SIZE),
        ),
      ),
    );
  }

  static Widget getCardOrganizer(String organizer, BuildContext context) {
    return (organizer != null)
        ? Padding(
            padding: EdgeInsets.only(
              left: SizeConfig.getSafeBlockVerticalBy(2),
              top: SizeConfig.getSafeBlockVerticalBy(1),
              bottom: SizeConfig.getSafeBlockVerticalBy(2),
            ),
            child: Row(
              children: <Widget>[
                Flexible(
                  child: Text(
                    organizer,
                    overflow: TextOverflow.visible,
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: SizeConfig.getSafeBlockVerticalBy(
                          Default.SUBSTANDARD_FONT_SIZE),
                    ),
                  ),
                ),
              ],
            ),
          )
        : Container();
  }

  static Widget getCardEmail(String email, String title, BuildContext context) {
    return (email != null)
        ? Padding(
            padding: EdgeInsets.only(
              bottom: SizeConfig.getSafeBlockVerticalBy(2),
              left: SizeConfig.getSafeBlockVerticalBy(1),
            ),
            child: InkWell(
              splashColor: Color(Default.COLOR_GREEN),
              onTap: () => TapAction().sendMail(email, title),
              onLongPress: () =>
                  ClipboardService.copyAndNotify(context: context, text: email),
              child: Padding(
                padding: EdgeInsets.only(
                  left: SizeConfig.getSafeBlockVerticalBy(1),
                ),
                child: Icon(
                  Icons.email,
                  color: Colors.grey,
                  size: SizeConfig.getSafeBlockVerticalBy(4),
                  semanticLabel: 'Email',
                ),
              ),
            ),
          )
        : Container();
  }

  static Widget noInternet() {
    return Container(
      color: Colors.red,
      child: Padding(
        padding: const EdgeInsets.all(1.0),
        child: ListTile(
          leading: Icon(
            Icons.info,
            color: Colors.white,
          ),
          title: Text(
            Network.NO_INTERNET,
            style: TextStyle(
              color: Colors.white,
              fontSize:
                  SizeConfig.getSafeBlockVerticalBy(Default.STANDARD_FONT_SIZE),
            ),
          ),
        ),
      ),
    );
  }

  static Padding getFooter(String text) {
    return Padding(
      padding: EdgeInsets.all(SizeConfig.getSafeBlockVerticalBy(1.5)),
      child: Text(
        text,
        style: TextStyle(
          color: Colors.grey,
          fontSize:
              SizeConfig.getSafeBlockVerticalBy(Default.SUBSTANDARD_FONT_SIZE),
        ),
        textAlign: TextAlign.center,
      ),
    );
  }

  static Widget getAccordionTitle(String name) {
    return Text(
      name,
      style: TextStyle(
        fontSize: SizeConfig.getSafeBlockVerticalBy(Default.STANDARD_FONT_SIZE),
      ),
    );
  }

  static Padding getSinglePageTitle(double thirty, String title) {
    return Padding(
      padding: EdgeInsets.only(left: thirty, right: thirty, top: thirty),
      child: Text(
        title,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize:
              SizeConfig.getSafeBlockVerticalBy(Default.STANDARD_FONT_SIZE),
        ),
      ),
    );
  }

  static Padding getSinglePageDescription(double thirty, String description) {
    return Padding(
      padding: EdgeInsets.all(thirty),
      child: SelectableText(
        description,
        style: TextStyle(
          fontSize:
              SizeConfig.getSafeBlockVerticalBy(Default.STANDARD_FONT_SIZE),
        ),
      ),
    );
  }

  static Padding getSinglePageOccurrence(double thirty, String occurrence) {
    return Padding(
      padding: EdgeInsets.only(
          left: thirty, bottom: SizeConfig.getSafeBlockVerticalBy(2)),
      child: Text(
        "Termin: $occurrence",
        style: TextStyle(
          color: Colors.grey,
          fontWeight: FontWeight.bold,
          fontSize:
              SizeConfig.getSafeBlockVerticalBy(Default.STANDARD_FONT_SIZE),
        ),
      ),
    );
  }

  static Padding getSinglePageEmail(
      double thirty, String email, String title, BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: thirty, bottom: thirty),
      child: InkWell(
        splashColor: Color(Default.COLOR_GREEN),
        onTap: () => TapAction().sendMail(email, title),
        onLongPress: () =>
            ClipboardService.copyAndNotify(context: context, text: email),
        child: Padding(
          padding: EdgeInsets.only(
            left: SizeConfig.getSafeBlockVerticalBy(1),
          ),
          child: Icon(
            Icons.email,
            color: Colors.grey,
            size: SizeConfig.getSafeBlockVerticalBy(4),
            semanticLabel: 'Email',
          ),
        ),
      ),
    );
  }

  static Padding getImageFromNetwork(double thirty, String imageUrl) {
    return Padding(
      padding: EdgeInsets.all(thirty),
      child: Image.network(
        imageUrl,
        fit: BoxFit.scaleDown,
      ),
    );
  }

  static Padding noEntry() {
    return Padding(
      padding: EdgeInsets.only(
        bottom: SizeConfig.getSafeBlockHorizontalBy(3),
      ),
      child: Text(Default.NO_CONTENT),
    );
  }

  static Center centeredNoEntry() {
    return Center(
      heightFactor: SizeConfig.getSafeBlockHorizontalBy(1),
      child: Text(Default.NO_CONTENT),
    );
  }

  static IconSlideAction getSlidableCalender(String title, String info,
      Address address, DateTime startDateTime, DateTime endDateTime) {
    final Event event = Event(
        title: title,
        description: info,
        location: "${address.getStreetAndNumber()}, ${address.getZipAndCity()}",
        startDate: startDateTime,
        endDate: endDateTime);

    return IconSlideAction(
      caption: Default.CALENDER,
      color: Color(Default.COLOR_DARKGREEN),
      foregroundColor: Colors.white,
      iconWidget: Icon(
        Icons.calendar_today,
        size: SizeConfig.getSafeBlockVerticalBy(7),
        color: Colors.white,
      ),
      onTap: () => Add2Calendar.addEvent2Cal(event),
    );
  }

  static Widget getSlidableShare(String subject, String text, [double size = 7]) {
    return IconSlideAction(
      caption: Default.SHARE,
      color: Colors.black45,
      foregroundColor: Colors.white,
      iconWidget: Icon(
        Icons.share,
        size: SizeConfig.getSafeBlockVerticalBy(size),
        color: Colors.white,
      ),
      onTap: () => Share.share(text, subject: subject),
    );
  }
}
