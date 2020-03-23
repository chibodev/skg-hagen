import 'dart:convert';

class AidOfferQuestion {
  String question;
  String type;
  List<String> option;

  AidOfferQuestion({
    this.question,
    this.type,
    this.option,
  });

  factory AidOfferQuestion.fromJson(dynamic json) => AidOfferQuestion(
        question: json["question"] == "" || json["question"] == null
            ? null
            : json["question"],
        type: json["type"] == "" || json["type"] == null ? null : json["type"],
        option: json["option"] == "" || json["option"] == null
            ? null
            : List<String>.from(json["option"]),
      );
}
