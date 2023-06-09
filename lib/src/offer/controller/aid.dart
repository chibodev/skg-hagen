import 'package:flutter/material.dart';
import 'package:skg_hagen/src/offer/dto/aidOffer.dart' as DTO;
import 'package:skg_hagen/src/offer/dto/aidOfferQuestion.dart';
import 'package:skg_hagen/src/offer/view/aidOffer.dart';

class Aid extends StatefulWidget {
  final DTO.AidOffer? aidOffer;
  final List<AidOfferQuestion>? aidOfferQuestion;
  final bool dataAvailable;
  final BuildContext context;

  const Aid(
      {Key? key,
      required this.context,
      required this.aidOffer,
      required this.aidOfferQuestion,
      this.dataAvailable = true})
      : super(key: key);

  @override
  AidOffer createState() => AidOffer();
}
