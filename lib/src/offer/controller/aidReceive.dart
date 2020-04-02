import 'package:flutter/material.dart';
import 'package:skg_hagen/src/offer/model/aidReceive.dart' as Model;
import 'package:skg_hagen/src/offer/view/aidReceive.dart' as View;

class AidReceive extends StatefulWidget {
  final Model.AidReceive aidReceive;
  final bool dataAvailable;
  final BuildContext buildContext;

  const AidReceive(
      {Key key,
      this.buildContext,
      @required this.aidReceive,
      this.dataAvailable = true})
      : super(key: key);

  @override
  View.AidReceive createState() => View.AidReceive();
}
