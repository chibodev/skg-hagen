import 'package:skg_hagen/src/offer/dto/music.dart';
import 'package:skg_hagen/src/offer/dto/offer.dart';
import 'package:skg_hagen/src/offer/dto/project.dart';

class Offers {
  final List<Offer> offers;
  final List<Project> projects;
  final List<Music> music;
  static const String NAME = 'Angebote';
  static const String IMAGE = 'assets/images/angebote.jpg';
  static const String FOOTER =
      'Ob Angebote, Gruppen oder Kreise stattfinden, erfragen Sie bitte per E-Mail.';

  Offers({this.offers, this.projects, this.music});

  factory Offers.fromJson(Map<String, dynamic> json) {
    return Offers(
      offers: json["offers"] == null
          ? null
          : List<Offer>.from(
              json["offers"].map(
                (dynamic x) => Offer.fromJson(x),
              ),
            ),
      projects: json["projects"] == null
          ? null
          : List<Project>.from(
              json["projects"].map(
                (dynamic x) => Project.fromJson(x),
              ),
            ),
      music: json["music"] == null
          ? null
          : List<Music>.from(
              json["music"].map(
                (dynamic x) => Music.fromJson(x),
              ),
            ),
    );
  }
}
