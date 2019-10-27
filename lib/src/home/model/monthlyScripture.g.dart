// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'monthlyScripture.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MonthlyScripture _$MonthlyScriptureFromJson(Map<String, dynamic> json) {
  return MonthlyScripture(
    json['text'] as String,
    json['book'] as String,
    json['chapter'] as int,
    json['verse'] as int,
  );
}

Map<String, dynamic> _$MonthlyScriptureToJson(MonthlyScripture instance) =>
    <String, dynamic>{
      'text': instance.text,
      'book': instance.book,
      'chapter': instance.chapter,
      'verse': instance.verse,
    };
