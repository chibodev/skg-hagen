import 'package:skg_hagen/src/aboutus/model/history.dart';
import 'package:skg_hagen/src/aboutus/model/imprint.dart';
import 'package:skg_hagen/src/aboutus/model/presbytery.dart';

class AboutUs {
  List<History> history;
  List<Presbytery> presbytery;
  List<Imprint> imprint;

  static const String NAME = 'Über uns';
  static const String IMAGE = 'assets/images/skg.jpg';

  AboutUs({
    this.history,
    this.presbytery,
    this.imprint,
  });

  factory AboutUs.fromJson(Map<String, dynamic> json) => AboutUs(
        history: List<History>.from(
          json["history"].map(
            (dynamic x) => History.fromJson(x),
          ),
        ),
        presbytery: List<Presbytery>.from(
          json["presbytery"].map(
            (dynamic x) => Presbytery.fromJson(x),
          ),
        ),
        imprint: List<Imprint>.from(
          json["imprint"].map(
            (dynamic x) => Imprint.fromJson(x),
          ),
        ),
      );
}
