import 'package:skg_hagen/src/offer/model/aidOffer.dart';
import 'package:skg_hagen/src/offer/model/aidOfferQuestion.dart';
import 'package:skg_hagen/src/offer/model/aidReceive.dart';

class Aid {
  final AidOffer offer;
  final AidReceive receive;
  final List<AidOfferQuestion> offerQuestion;

  static const String NAME = 'Corona-Hinweis / Nachbarschafts-Hilfe';

  Aid({this.offer, this.receive, this.offerQuestion});

  factory Aid.fromJson(dynamic json) {
    return Aid(
      offer: json["offer"] == null ? null : AidOffer.fromJson(json["offer"]),
      receive:
          json["receive"] == null ? null : AidReceive.fromJson(json["receive"]),
      offerQuestion: json["offer_question"] == null
          ? null
          : List<AidOfferQuestion>.from(
              json["offer_question"].map(
                (dynamic x) => AidOfferQuestion.fromJson(x),
              ),
            ),
    );
  }
}
