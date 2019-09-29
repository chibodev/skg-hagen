// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'offer.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Offer _$OfferFromJson(Map<String, dynamic> json) {
  return Offer(
    json['title'] as String,
    json['date'] as String,
    json['time'] as String,
    json['address'] == null
        ? null
        : Address.fromJson(json['address'] as Map<String, dynamic>),
    json['organizer'] as String,
    json['email'] as String,
    json['age'] == null
        ? null
        : AgeRange.fromJson(json['age'] as Map<String, dynamic>),
    json['school_year'] as int,
  );
}

Map<String, dynamic> _$OfferToJson(Offer instance) => <String, dynamic>{
      'title': instance.title,
      'date': instance.date,
      'time': instance.time,
      'address': instance.address?.toJson(),
      'organizer': instance.organizer,
      'email': instance.email,
      'age': instance.ageRange?.toJson(),
      'school_year': instance.schoolYear,
    };
