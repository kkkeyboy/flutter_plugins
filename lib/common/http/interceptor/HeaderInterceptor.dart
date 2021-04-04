import 'package:flutter_base/flutter_base.dart';
import 'package:codes/common/base/vm/GlobalUserModel.dart';

class HeaderInterceptor extends Interceptor {
  @override
  Future onRequest(RequestOptions options,RequestInterceptorHandler handler) async {
    options.headers.addAll({
      // "token": GlobalUserModel().userInfo?.token??options.headers['token']??"",
      "accept": "application/json",
      "Content-Type": "application/json"
    });
  }
}
