// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Task1_nonenull.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Task1Nonenull _$Task1NonenullFromJson(Map<String, dynamic> json) {
  return Task1Nonenull()
    ..id = json['id'] as num
    ..name = json['name'] as String
    ..avatar = json['avatar'] as String
    ..createdAt = json['createdAt'] as String
    ..test = json['test'] as String
    ..data = Task1NonenullData.fromJson(json['data'] as Map<String, dynamic>);
}

Map<String, dynamic> _$Task1NonenullToJson(Task1Nonenull instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'avatar': instance.avatar,
      'createdAt': instance.createdAt,
      'test': instance.test,
      'data': instance.data,
    };

Task1NonenullData _$Task1NonenullDataFromJson(Map<String, dynamic> json) {
  return Task1NonenullData()
    ..id = json['id'] as num
    ..name = json['name'] as String;
}

Map<String, dynamic> _$Task1NonenullDataToJson(Task1NonenullData instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
    };
