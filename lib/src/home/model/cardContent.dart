import 'package:flutter/material.dart';

class CardContent {
  final String _title;
  final List<String> _subtitle;
  final String _custom;
  final String _routeName;
  final String _name;

  CardContent(this._title, this._subtitle, this._routeName, this._name, [this._custom]);

  String get custom => _custom;

  List<String> get subtitle => _subtitle;

  String get joinedSubtitle => _subtitle.join(" | ");

  String get title => _title;

  List<String> get subtitleList => _subtitle;

  String get routeName => _routeName;

  String get name => _name;

  Image getImageAsset() {
    return (custom != null) ? Image.asset(custom, fit: BoxFit.fitWidth,) : null;
  }
}
