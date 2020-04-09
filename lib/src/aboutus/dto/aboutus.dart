import 'package:skg_hagen/src/aboutus/dto/history.dart';
import 'package:skg_hagen/src/aboutus/dto/presbytery.dart';

class AboutUs {
  List<History> history;
  List<Presbytery> presbytery;

  static const String NAME = 'Über uns';
  static const String IMAGE = 'assets/images/skg.jpg';

  AboutUs({
    this.history,
    this.presbytery,
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
      );
}
