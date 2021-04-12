import 'package:json_annotation/json_annotation.dart';


import 'package:retrofit/retrofit.dart';

part 'Task.g.dart';

@JsonSerializable()
class Task extends JsonData {
      Task();

  num? id;
  String? name;
  String? avatar;
  String? createdAt;
  String? test;
  TaskData? data;
  
  @override
  convertData(Map<String, dynamic> json) => Task.fromJson(json);

  factory Task.fromJson(Map<String,dynamic> json) => _$TaskFromJson(json);
  Map<String, dynamic> toJson() => _$TaskToJson(this);
}

@JsonSerializable()
class TaskData extends JsonData {
      TaskData();

  num? id;
  String? name;
  
  @override
  convertData(Map<String, dynamic> json) => TaskData.fromJson(json);

  factory TaskData.fromJson(Map<String,dynamic> json) => _$TaskDataFromJson(json);
  Map<String, dynamic> toJson() => _$TaskDataToJson(this);
}
