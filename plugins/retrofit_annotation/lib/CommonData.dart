import 'dart:convert';

import 'ResultData.dart';

// import 'package:flutter_base/common/helper/log_helper.dart';

class CommonData<T> {
  static const String SUCCESS_CODE = '200';
  static const String FIELD_CODE = 'status';
  static const String FIELD_MSG = 'message';
  static const String FIELD_CONTENT = 'data';

  CommonData();

  String code;
  var content;
  String msg;
  T data;

  CommonData.convertData(Map<String, dynamic> json, {this.data})
      : this.code = json[ResultDataConfig.config.FIELD_CODE]?.toString() ?? "",
        this.msg = json[ResultDataConfig.config.FIELD_MSG],
        this.content = json[ResultDataConfig.config.FIELD_CONTENT];

  T getData(T instance) {
    if (data != null) {
      return data;
    }
    if (content != null && instance is JsonData) {
      try {
        var jsonData = content;
        if (content is String) {
          jsonData = jsonDecode(content);
        }
        data = jsonData is List ? jsonData.map((i) => instance.convertData(i)).toList() : instance.convertData(content);
        return data;
      } catch (e) {
        // LogUtil.e(e);
      }
    }
    return null;
  }

  bool isSuccess() => ResultDataConfig.config.SUCCESS_CODE == code;
}

abstract class JsonData {
  convertData(Map<String, dynamic> json);
}
