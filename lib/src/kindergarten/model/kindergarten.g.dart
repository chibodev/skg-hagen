// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'kindergarten.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Kindergarten _$KindergartenFromJson(Map<String, dynamic> json) {
  return Kindergarten(
    (json['events'] as List)
        ?.map((e) =>
            e == null ? null : Events.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    (json['news'] as List)
        ?.map(
            (e) => e == null ? null : News.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$KindergartenToJson(Kindergarten instance) =>
    <String, dynamic>{
      'events': instance.events?.map((e) => e?.toJson())?.toList(),
      'news': instance.news?.map((e) => e?.toJson())?.toList(),
    };
