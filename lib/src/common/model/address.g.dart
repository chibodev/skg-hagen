// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'address.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Address _$AddressFromJson(Map<String, dynamic> json) {
  return Address(
    json['church_name'] as String,
    json['address1'] as String,
    json['house_number'] as String,
    json['zip'] as String,
    json['city'] as String,
    json['country'] as String,
    json['room'] as String,
  );
}

Map<String, dynamic> _$AddressToJson(Address instance) => <String, dynamic>{
      'church_name': instance.churchName,
      'address1': instance.address1,
      'house_number': instance.houseNumber,
      'zip': instance.zip,
      'city': instance.city,
      'country': instance.country,
      'room': instance.room,
    };
