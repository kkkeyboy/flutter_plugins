// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Task.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Task _$TaskFromJson(Map<String, dynamic> json) {
  return Task()
    ..id = json['id'] as num?
    ..name = json['name'] as String?
    ..avatar = json['avatar'] as String?
    ..createdAt = json['createdAt'] as String?
    ..test = json['test'] as String?
    ..data = json['data'] == null
        ? null
        : TaskData.fromJson(json['data'] as Map<String, dynamic>);
}

Map<String, dynamic> _$TaskToJson(Task instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'avatar': instance.avatar,
      'createdAt': instance.createdAt,
      'test': instance.test,
      'data': instance.data,
    };

TaskData _$TaskDataFromJson(Map<String, dynamic> json) {
  return TaskData()
    ..id = json['id'] as num?
    ..name = json['name'] as String?;
}

Map<String, dynamic> _$TaskDataToJson(TaskData instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
    };
