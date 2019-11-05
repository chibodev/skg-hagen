import 'package:skg_hagen/src/offer/model/group.dart';
import 'package:skg_hagen/src/offer/model/offer.dart';

class Offers {
  final List<Offer> offers;
  final List<Group> groups;
  static const String NAME = 'Angebote';
  static const String IMAGE = 'assets/images/gruppen.jpg';
  static const String FOOTER = 'Ob Angebote, Gruppen oder Kreise stattfinden bitte bei den Gruppenleitungen erfragen!';

  Offers({this.offers, this.groups});

  factory Offers.fromJson(Map<String, dynamic> json) {
    return Offers(
        offers: List<Offer>.from(
            json["offers"].map((dynamic x) => Offer.fromJson(x))),
        groups: List<Group>.from(
            json["groups"].map((dynamic x) => Group.fromJson(x))));
  }
}
