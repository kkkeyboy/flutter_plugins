import 'package:flutter_base/flutter_base.dart';
import 'package:codes/common/http/ApiControls.dart';
import 'package:retrofit/retrofit.dart';

class DataRepo {
  static Future<ResultData> sendEmail() {
    return ApiControls.api.sendEmail("${DateTime.now().millisecond}@qq.com");
  }

  static Future<ResultData> login() {
    return ApiControls.api.login(Map()
      ..["email"] = "1121888540@qq.com"
      ..["pwd"] = "e10adc3949ba59abbe56e057f20f883e");
  }

  static Future<ResultData> regist() {
    return ApiControls.api.regist(Map()
      ..["email"] = "email"
      ..["pwd"] = "pwd");
  }

   static Future test() {
    return ApiControls.apiTest.getTags();
  }
}
