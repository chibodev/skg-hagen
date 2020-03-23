import 'package:flutter/material.dart';
import 'package:skg_hagen/src/offer/model/aidOffer.dart' as Model;
import 'package:skg_hagen/src/offer/model/aidOfferQuestion.dart';
import 'package:skg_hagen/src/offer/view/aidOffer.dart';

class Aid extends StatefulWidget {
  final Model.AidOffer aidOffer;
  final List<AidOfferQuestion> aidOfferQuestion;
  final bool dataAvailable;
  final BuildContext context;

  const Aid(
      {Key key,
      this.context,
      @required this.aidOffer,
      this.aidOfferQuestion,
      this.dataAvailable = true})
      : super(key: key);

  @override
  AidOffer createState() => AidOffer();
}
