// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Task1_nonesafe.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Task1Nonesafe _$Task1NonesafeFromJson(Map<String, dynamic> json) {
  return Task1Nonesafe()
    ..id = json['id'] as num
    ..name = json['name'] as String
    ..avatar = json['avatar'] as String
    ..createdAt = json['createdAt'] as String
    ..test = json['test'] as String
    ..data = json['data']
    ..list = json['list'] as List<dynamic>;
}

Map<String, dynamic> _$Task1NonesafeToJson(Task1Nonesafe instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'avatar': instance.avatar,
      'createdAt': instance.createdAt,
      'test': instance.test,
      'data': instance.data,
      'list': instance.list,
    };

Task1Nonesafe _$Task1NonesafeFromJson(Map<String, dynamic> json) {
  return Task1Nonesafe()
    ..id = json['id'] as num
    ..name = json['name'] as String;
}

Map<String, dynamic> _$Task1NonesafeToJson(Task1Nonesafe instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
    };
