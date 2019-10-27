// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'offers.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Offers _$OffersFromJson(Map<String, dynamic> json) {
  return Offers(
    (json['offers'] as List)
        ?.map(
            (e) => e == null ? null : Offer.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    (json['groups'] as List)
        ?.map(
            (e) => e == null ? null : Group.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$OffersToJson(Offers instance) => <String, dynamic>{
      'offers': instance.offers?.map((e) => e?.toJson())?.toList(),
      'groups': instance.groups?.map((e) => e?.toJson())?.toList(),
    };
