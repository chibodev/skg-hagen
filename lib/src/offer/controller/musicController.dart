import 'package:flutter/material.dart';
import 'package:skg_hagen/src/offer/dto/music.dart' as DTO;
import 'package:skg_hagen/src/offer/view/music.dart' as View;

class MusicController extends StatefulWidget {
  final DTO.Music? music;
  final bool dataAvailable;
  final BuildContext context;

  const MusicController(
      {Key? key,
      required this.context,
      required this.music,
      this.dataAvailable = true})
      : super(key: key);

  @override
  View.Music createState() => View.Music();
}
