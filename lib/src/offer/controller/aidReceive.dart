import 'package:flutter/material.dart';
import 'package:skg_hagen/src/offer/dto/aidReceive.dart' as DTO;
import 'package:skg_hagen/src/offer/view/aidReceive.dart' as View;

class AidReceive extends StatefulWidget {
  final DTO.AidReceive aidReceive;
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
