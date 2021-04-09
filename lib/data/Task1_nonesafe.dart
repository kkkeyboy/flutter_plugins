import 'package:json_annotation/json_annotation.dart';



import 'package:retrofit/retrofit.dart';

part 'Task1_nonesafe.g.dart';

@JsonSerializable()
class Task1Nonesafe extends JsonData {
      Task1Nonesafe();

  num id;
  String name;
  String avatar;
  String createdAt;
  String test;
  Task1NonesafeData data;
  List<Task1NonesafeList> list;
  
  @override
  convertData(Map<String, dynamic> json) => Task1Nonesafe.fromJson(json);

  factory Task1Nonesafe.fromJson(Map<String,dynamic> json) => _$Task1NonesafeFromJson(json);
  Map<String, dynamic> toJson() => _$Task1NonesafeToJson(this);
}

@JsonSerializable()
class Task1Nonesafe extends JsonData {
      Task1Nonesafe();

  num id;
  String name;
  
  @override
  convertData(Map<String, dynamic> json) => Task1Nonesafe.fromJson(json);

  factory Task1Nonesafe.fromJson(Map<String,dynamic> json) => _$Task1NonesafeFromJson(json);
  Map<String, dynamic> toJson() => _$Task1NonesafeToJson(this);
}

@JsonSerializable()
class Task1Nonesafe extends JsonData {
      Task1Nonesafe();

  num id;
  String name;
  
  @override
  convertData(Map<String, dynamic> json) => Task1Nonesafe.fromJson(json);

  factory Task1Nonesafe.fromJson(Map<String,dynamic> json) => _$Task1NonesafeFromJson(json);
  Map<String, dynamic> toJson() => _$Task1NonesafeToJson(this);
}
