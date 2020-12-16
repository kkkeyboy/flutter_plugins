
import 'package:flutter_base/flutter_base.dart';


class ResponseInterceptors extends InterceptorsWrapper {
  @override
  onResponse(Response response) async {
    // RequestOptions option = response.request;
    // try {

    //   if (option.contentType != null && option.contentType.contains("text")) {
    //     return new ResultData(response.data, 200);
    //   }
    //   // HttpStatus.ok
    //   ///一般只需要处理200的情况，300、400、500保留错误信息，外层为http协议定义的响应码
    //   if (response.statusCode == HttpStatus.ok || response.statusCode == HttpStatus.created) {
    //     return new ResultData(response.data, 200,
    //           headers: response.headers);
    //     ///内层需要根据实际项目返回结构解析，一般会有code，data，msg字段  改到ResultData里面初始化时判断
    //     // int code = response.data["code"];
    //     // if (code == 0) {
    //     //   return new ResultData(response.data, true, 200,
    //     //       headers: response.headers);
    //     // } else {
    //     //   return new ResultData(response.data, false, 200,
    //     //       headers: response.headers);
    //     // }
    //   }
    // } catch (e) {
    //   (e.toString() + option.path).log();

    //   return new ResultData(response.data, response.statusCode,
    //       headers: response.headers);
    // }

    // return new ResultData(response.data, response.statusCode,
    //     headers: response.headers);
  }
}