import 'package:skg_hagen/src/churchyear/dto/easterOffer/resurrectionStation.dart';

class EasterOffer {
  static const String NAME = 'Ostern';
  ResurrectionStation resurrectionStation;

  EasterOffer({
    this.resurrectionStation,
  });

  factory EasterOffer.fromJson(Map<String, dynamic> json) => EasterOffer(
        resurrectionStation:
            ResurrectionStation.fromJson(json["resurrection_station"]),
      );
}
