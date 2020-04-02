import 'package:flutter/material.dart';
import 'package:skg_hagen/src/offer/model/music.dart' as Model;
import 'package:skg_hagen/src/offer/view/music.dart' as View;

class MusicController extends StatefulWidget {
  final Model.Music music;
  final bool dataAvailable;
  final BuildContext context;

  const MusicController(
      {Key key, this.context, @required this.music, this.dataAvailable = true})
      : super(key: key);

  @override
  View.Music createState() => View.Music();
}
