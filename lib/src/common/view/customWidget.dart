import 'package:add_2_calendar/add_2_calendar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:share/share.dart';
import 'package:skg_hagen/src/common/library/globals.dart';
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
        fontSize: SizeConfig.getSafeBlockVerticalBy(appFont.primarySize),
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
          fontSize: SizeConfig.getSafeBlockVerticalBy(appFont.primarySize),
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
          fontSize: SizeConfig.getSafeBlockVerticalBy(appFont.primarySize),
        ),
      ),
    );
  }

  static Container getAddressWithAction(Address address, {String room}) {
    return Container(
      width: SizeConfig.screenHeight,
      height: SizeConfig.getSafeBlockHorizontalBy(appFont.boxSize),
      decoration: BoxDecoration(color: Color(Default.COLOR_GREEN)),
      child: InkWell(
        splashColor: Color(Default.COLOR_GREEN),
        onTap: () => TapAction().openMap(address.latLong, address.name),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            room != null
                ? Flexible(
                    child: Text(
                      Default.capitalize(room),
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: SizeConfig.getSafeBlockVerticalBy(
                            appFont.primarySize),
                      ),
                    ),
                  )
                : Container(),
            address.name != null
                ? Flexible(
                    child: Text(
                      Default.capitalize(address.name),
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: SizeConfig.getSafeBlockVerticalBy(
                            appFont.primarySize),
                      ),
                    ),
                  )
                : Container(),
            address.street != null
                ? Flexible(
                    child: Text(
                      address.getStreetAndNumber(),
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: SizeConfig.getSafeBlockVerticalBy(
                            appFont.primarySize),
                      ),
                    ),
                  )
                : Container(),
            address.zip != null
                ? Flexible(
                    child: Text(
                      address.getZipAndCity(),
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: SizeConfig.getSafeBlockVerticalBy(
                            appFont.primarySize),
                      ),
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
          fontSize: SizeConfig.getSafeBlockVerticalBy(appFont.primarySize),
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
                          appFont.primarySize),
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
                  size: SizeConfig.getSafeBlockVerticalBy(appFont.iconSize),
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
            size: SizeConfig.getSafeBlockVerticalBy(appFont.iconSize),
          ),
          title: Text(
            Network.NO_INTERNET,
            style: TextStyle(
              color: Colors.white,
              fontSize: SizeConfig.getSafeBlockVerticalBy(appFont.primarySize),
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
          fontSize: SizeConfig.getSafeBlockVerticalBy(appFont.primarySize),
        ),
        textAlign: TextAlign.center,
      ),
    );
  }

  static Widget getAccordionTitle(String name) {
    return Text(
      name,
      style: TextStyle(
        fontSize: SizeConfig.getSafeBlockVerticalBy(appFont.primarySize),
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
          fontSize: SizeConfig.getSafeBlockVerticalBy(appFont.primarySize),
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
          fontSize: SizeConfig.getSafeBlockVerticalBy(appFont.primarySize),
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
          fontSize: SizeConfig.getSafeBlockVerticalBy(appFont.primarySize),
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
            size: SizeConfig.getSafeBlockVerticalBy(appFont.iconSize),
            semanticLabel: 'Email',
          ),
        ),
      ),
    );
  }

  static Padding getSinglePagePhone(
      double thirty, String phone, BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: thirty, bottom: thirty),
      child: InkWell(
        splashColor: Color(Default.COLOR_GREEN),
        onTap: () => TapAction().callMe(phone),
        onLongPress: () =>
            ClipboardService.copyAndNotify(context: context, text: phone),
        child: Padding(
          padding: EdgeInsets.only(
            left: SizeConfig.getSafeBlockVerticalBy(1),
          ),
          child: Icon(
            Icons.phone,
            color: Colors.grey,
            size: SizeConfig.getSafeBlockVerticalBy(appFont.iconSize),
            semanticLabel: 'Phone',
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
      child: Text(
        Default.NO_CONTENT,
        style: TextStyle(
          fontSize: SizeConfig.getSafeBlockVerticalBy(appFont.imageIconSize),
        ),
      ),
    );
  }

  static Center centeredNoEntry() {
    return Center(
      heightFactor: SizeConfig.getSafeBlockHorizontalBy(1),
      child: Text(
        Default.NO_CONTENT,
        style: TextStyle(
          fontSize: SizeConfig.getSafeBlockVerticalBy(appFont.imageIconSize),
        ),
      ),
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
        size: SizeConfig.getSafeBlockVerticalBy(appFont.iconSize),
        color: Colors.white,
      ),
      onTap: () => Add2Calendar.addEvent2Cal(event),
    );
  }

  static Widget getSlidableShare(String subject, String text) {
    return IconSlideAction(
      caption: Default.SHARE,
      color: Colors.black45,
      foregroundColor: Colors.white,
      iconWidget: Icon(
        Icons.share,
        size: SizeConfig.getSafeBlockVerticalBy(appFont.iconSize),
        color: Colors.white,
      ),
      onTap: () => Share.share(text, subject: subject),
    );
  }

  static ScaffoldFeatureController<SnackBar, SnackBarClosedReason>
      showNotification(BuildContext context, String text, IconData icon,
          Color backgroundColor) {
    return Scaffold.of(context).showSnackBar(
      SnackBar(
        backgroundColor: backgroundColor,
        content: ListTile(
          leading: Icon(
            icon,
            color: Colors.white,
            size: SizeConfig.getSafeBlockVerticalBy(appFont.iconSize),
          ),
          title: Text(
            text,
            style: TextStyle(
              color: Colors.white,
              fontSize: SizeConfig.getSafeBlockVerticalBy(appFont.primarySize),
            ),
          ),
        ),
      ),
    );
  }

  static FlatButton getSendButton(
      BuildContext context, Function onSendPressed) {
    return FlatButton(
      color: Color(Default.COLOR_GREEN),
      textColor: Colors.white,
      padding: EdgeInsets.only(
        left: SizeConfig.getSafeBlockVerticalBy(7),
        right: SizeConfig.getSafeBlockVerticalBy(7),
        top: SizeConfig.getSafeBlockVerticalBy(2),
        bottom: SizeConfig.getSafeBlockVerticalBy(2),
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30.0),
      ),
      onPressed: () => onSendPressed(context),
      child: Text(
        (Default.SEND).toUpperCase(),
        style: TextStyle(
          fontSize: SizeConfig.getSafeBlockVerticalBy(appFont.secondarySize),
        ),
      ),
    );
  }
}
