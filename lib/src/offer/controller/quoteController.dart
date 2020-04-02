import 'package:flutter/material.dart';
import 'package:skg_hagen/src/offer/model/quote.dart' as Model;
import 'package:skg_hagen/src/offer/view/quote.dart' as View;

class QuoteController extends StatefulWidget {
  final List<Model.Quote> quotes;
  final bool dataAvailable;
  final BuildContext context;

  const QuoteController(
      {Key key,
      this.context,
      @required this.quotes,
      this.dataAvailable = true})
      : super(key: key);

  @override
  View.Quote createState() => View.Quote();
}
