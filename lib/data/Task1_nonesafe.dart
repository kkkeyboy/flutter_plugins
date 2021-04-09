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
class Task1NonesafeData extends JsonData {
      Task1NonesafeData();

  num id;
  String name;
  
  @override
  convertData(Map<String, dynamic> json) => Task1NonesafeData.fromJson(json);

  factory Task1NonesafeData.fromJson(Map<String,dynamic> json) => _$Task1NonesafeDataFromJson(json);
  Map<String, dynamic> toJson() => _$Task1NonesafeDataToJson(this);
}

@JsonSerializable()
class Task1NonesafeList extends JsonData {
      Task1NonesafeList();

  num id;
  String name;
  
  @override
  convertData(Map<String, dynamic> json) => Task1NonesafeList.fromJson(json);

  factory Task1NonesafeList.fromJson(Map<String,dynamic> json) => _$Task1NonesafeListFromJson(json);
  Map<String, dynamic> toJson() => _$Task1NonesafeListToJson(this);
}
