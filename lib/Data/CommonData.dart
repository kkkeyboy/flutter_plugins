import 'dart:convert';

import 'package:flutter_base/common/helper/log_helper.dart';

class CommonData {
  CommonData();

  int code;
  var data;
  String msg;

  CommonData.fromJson(Map<String, dynamic> json)
      : code = json['code'],
        msg = json['msg'],
        data = json['data'];

  Map<String, dynamic> toJson() => <String, dynamic>{
        'code': code,
        'msg': msg,
        'content': data,
      };

  // T getData<T>(Function(Map<String, dynamic> json) call) {
  //   return call.call(content) as T;
  // }
  getData<T>(T instance) {
    if (data != null && instance is JsonData) {
      try {
        var jsonData = data;
        if (data is String) {
          jsonData = jsonDecode(data);
        }
        return jsonData is List ? jsonData.map((i) => instance.convertData(i)).toList() : instance.convertData(data);
      } catch (e) {
        LogUtil.e(e);
      }
    }
    return null;
  }

  bool isSuccess() => 200 == code;
}

abstract class JsonData {
  convertData(Map<String, dynamic> json);
}
