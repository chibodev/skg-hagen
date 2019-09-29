import 'package:json_annotation/json_annotation.dart';
import 'package:skg_hagen/src/offer/model/group.dart';
import 'package:skg_hagen/src/offer/model/offer.dart';

part 'offers.g.dart';

@JsonSerializable(explicitToJson: true)
class Offers {
  final List<Offer> offers;
  final List<Group> groups;

  Offers(this.offers, this.groups);

  factory Offers.fromJson(Map<String, dynamic> json) =>
      _$OffersFromJson(json);

  Map<String, dynamic> toJson() => _$OffersToJson(this);
}
