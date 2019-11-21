import 'package:skg_hagen/src/offer/model/group.dart';
import 'package:skg_hagen/src/offer/model/music.dart';
import 'package:skg_hagen/src/offer/model/offer.dart';

class Offers {
  final List<Offer> offers;
  final List<Group> groups;
  final List<Music> music;
  static const String NAME = 'Angebote';
  static const String IMAGE = 'assets/images/angebote.jpg';
  static const String FOOTER =
      'Ob Angebote, Gruppe oder Kreise stattfinden bitte bei den Gruppenleitungen erfragen!';

  Offers({this.offers, this.groups, this.music});

  factory Offers.fromJson(Map<String, dynamic> json) {
    return Offers(
      offers: json["offers"] == null ? null : List<Offer>.from(
        json["offers"].map(
          (dynamic x) => Offer.fromJson(x),
        ),
      ),
      groups: json["groups"] == null ? null : List<Group>.from(
        json["groups"].map(
          (dynamic x) => Group.fromJson(x),
        ),
      ),
      music: json["music"] == null ? null : List<Music>.from(
        json["music"].map(
          (dynamic x) => Music.fromJson(x),
        ),
      ),
    );
  }
}
