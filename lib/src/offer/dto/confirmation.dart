import 'package:skg_hagen/src/offer/dto/appointment.dart';
import 'package:skg_hagen/src/offer/dto/concept.dart';
import 'package:skg_hagen/src/offer/dto/quote.dart';

class Confirmation {
  final List<Appointment> appointment;
  final List<Concept> concept;
  final List<Quote> quote;
  static const String NAME = 'Konfirmanden';

  Confirmation({this.appointment, this.concept, this.quote});

  factory Confirmation.fromJson(Map<String, dynamic> json) {
    return Confirmation(
      appointment: json["appointments"] == null
          ? null
          : List<Appointment>.from(
              json["appointments"].map(
                (dynamic x) => Appointment.fromJson(x),
              ),
            ),
      concept: json["concept"] == null
          ? null
          : List<Concept>.from(
              json["concept"].map(
                (dynamic x) => Concept.fromJson(x),
              ),
            ),
      quote: json["quote"] == null
          ? null
          : List<Quote>.from(
              json["quote"].map(
                (dynamic x) => Quote.fromJson(x),
              ),
            ),
    );
  }
}
