import 'package:flutter/material.dart';
import 'package:skg_hagen/src/offer/dto/concept.dart' as DTO;
import 'package:skg_hagen/src/offer/view/concept.dart' as View;

class ConceptController extends StatefulWidget {
  final List<DTO.Concept> concept;
  final bool dataAvailable;
  final BuildContext context;

  const ConceptController(
      {Key key,
      this.context,
      @required this.concept,
      this.dataAvailable = true})
      : super(key: key);

  @override
  View.Concept createState() => View.Concept();
}
