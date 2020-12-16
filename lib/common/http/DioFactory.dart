import 'package:connectivity/connectivity.dart';
import 'package:flutter_base/flutter_base.dart';

import 'interceptor/HeaderInterceptor.dart';
import 'interceptor/LoggerInterceptor.dart';
import 'DioConnectivityRequestRetrier.dart';
// import 'interceptor/ResponseInterceptor.dart';
import 'interceptor/RetryOnConnectionChangeInterceptor.dart';

class DioFactory {
  ///超时时间
  static const int CONNECT_TIMEOUT = 30000;
  static const int RECEIVE_TIMEOUT = 30000;

  static DioFactory _instance = DioFactory._internal();
  factory DioFactory() => _instance;

  Dio _dio;
  Dio getDio(String apiHost) {
    _dio.options = _dio.options.merge(baseUrl: apiHost);
    return _dio;
  }

//全局单例，第一次使用时初始化
  DioFactory._internal() {
    if (_dio == null) {
      // BaseOptions、Options、RequestOptions 都可以配置参数，优先级别依次递增，且可以根据优先级别覆盖参数
      BaseOptions options = new BaseOptions(
        connectTimeout: CONNECT_TIMEOUT,

        // 响应流上前后两次接受到数据的间隔，单位为毫秒。
        receiveTimeout: RECEIVE_TIMEOUT,

        // Http请求头.
        // headers: {"token": "ba2ca2e753cc779ff5f99e71d549cc9b"},
      );

      _dio = new Dio(options);

      //没网、有网后重试
      _dio.interceptors.add(
        RetryOnConnectionChangeInterceptor(
          requestRetrier: DioConnectivityRequestRetrier(
            dio: _dio,
            connectivity: Connectivity(),
          ),
        ),
      );

      //统一headder处理
      _dio.interceptors.add(HeaderInterceptor());

      // 添加log拦截器
      _dio.interceptors.add(LoggerInterceptor());

      //统一处理返回
      // _dio.interceptors.add(ResponseInterceptors());
    }
  }
}
