import 'package:json_annotation/json_annotation.dart';


import 'package:retrofit/retrofit.dart';

part 'Task1_nonenull.g.dart';

@JsonSerializable()
class Task1Nonenull extends JsonData {
      Task1Nonenull();

  late num id;
  late String name;
  late String avatar;
  late String createdAt;
  late String test;
  late Task1NonenullData data;
  
  @override
  convertData(Map<String, dynamic> json) => Task1Nonenull.fromJson(json);

  factory Task1Nonenull.fromJson(Map<String,dynamic> json) => _$Task1NonenullFromJson(json);
  Map<String, dynamic> toJson() => _$Task1NonenullToJson(this);
}

@JsonSerializable()
class Task1NonenullData extends JsonData {
      Task1NonenullData();

  late num id;
  late String name;
  
  @override
  convertData(Map<String, dynamic> json) => Task1NonenullData.fromJson(json);

  factory Task1NonenullData.fromJson(Map<String,dynamic> json) => _$Task1NonenullDataFromJson(json);
  Map<String, dynamic> toJson() => _$Task1NonenullDataToJson(this);
}
