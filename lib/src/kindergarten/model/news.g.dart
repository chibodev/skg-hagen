// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'news.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

News _$NewsFromJson(Map<String, dynamic> json) {
  return News(
    json['title'] as String,
    json['date'] == null ? null : DateTime.parse(json['date'] as String),
    json['content'] as String,
  );
}

Map<String, dynamic> _$NewsToJson(News instance) => <String, dynamic>{
      'title': instance.title,
      'date': instance.date?.toIso8601String(),
      'content': instance.content,
    };
