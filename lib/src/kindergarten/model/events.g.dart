// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'events.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Events _$EventsFromJson(Map<String, dynamic> json) {
  return Events(
    json['title'] as String,
    json['date'] == null ? null : DateTime.parse(json['date'] as String),
    json['comment'] as String,
    json['link'] as String,
  );
}

Map<String, dynamic> _$EventsToJson(Events instance) => <String, dynamic>{
      'title': instance.title,
      'date': instance.date?.toIso8601String(),
      'comment': instance.comment,
      'link': instance.link,
    };
