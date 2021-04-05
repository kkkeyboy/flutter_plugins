import 'package:json_annotation/json_annotation.dart';


import 'package:retrofit/retrofit.dart';

part 'Task.g.dart';

@JsonSerializable()
class Task extends JsonData {
      Task();

  String? id;
  String? name;
  String? avatar;
  String? createdAt;
  
  @override
  convertData(Map<String, dynamic> json) => Task.fromJson(json);

  factory Task.fromJson(Map<String,dynamic> json) => _$TaskFromJson(json);
  Map<String, dynamic> toJson() => _$TaskToJson(this);
}
