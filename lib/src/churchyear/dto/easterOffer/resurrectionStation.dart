import 'package:skg_hagen/src/churchyear/dto/easterOffer/station.dart';
import 'package:skg_hagen/src/churchyear/dto/info.dart';

class ResurrectionStation {
  Info info;
  List<Station> station;

  ResurrectionStation({
    required this.info,
    required this.station,
  });

  factory ResurrectionStation.fromJson(Map<String, dynamic> json) =>
      ResurrectionStation(
        info: Info.fromJson(json["info"]),
        station: List<Station>.from(
          json["station"].map(
            (dynamic x) => Station.fromJson(x),
          ),
        ),
      );
}
