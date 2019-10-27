// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'group.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Group _$GroupFromJson(Map<String, dynamic> json) {
  return Group(
    json['title'] as String,
    json['date'] as String,
    json['time'] as String,
    json['address'] == null
        ? null
        : Address.fromJson(json['address'] as Map<String, dynamic>),
    json['organizer'] as String,
  );
}

Map<String, dynamic> _$GroupToJson(Group instance) => <String, dynamic>{
      'title': instance.title,
      'date': instance.date,
      'time': instance.time,
      'address': instance.address?.toJson(),
      'organizer': instance.organizer,
    };
