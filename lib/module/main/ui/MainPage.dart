import 'package:codes/common/http/DataRepo.dart';
import 'package:codes/common/http/DioFactory.dart';
import 'package:codes/common/themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_base/flutter_base.dart';

class MainPage extends BasePage {
  @override
  _PageState createState() => _PageState();
}

class _PageState extends BasePageState<MainPage> {
  @override
  Widget buildBody(BuildContext context) {
    return ListView(
      padding: EdgeInsets.symmetric(horizontal: ThemeDimens.pageLRMargin, vertical: ThemeDimens.pageVerticalMargin),
      children: [
        ElevatedButton(
            onPressed: () {
              DataRepo.sendEmail();
            },
            child: Text("SendEmail")),
        ElevatedButton(
            onPressed: () {
              DataRepo.login();
            },
            child: Text("Login")),
        ElevatedButton(
            onPressed: () async {
              await DataRepo.regist();
            },
            child: Text("Register")),
        ElevatedButton(
            onPressed: () async {
              var dio = Dio();
              // final response = await dio.get('http://139.159.183.240:9092/');
              final resp2 = await dio.fetch(RequestOptions(path: "/tags", baseUrl: "http://139.159.183.240:9092"));

              final resp3 = await DioFactory().getDio().fetch(RequestOptions(path: "/tags", baseUrl: "http://139.159.183.240:9092"));
              final dd = await DataRepo.test();
              final ss = 1 + 2;
            },
            child: Text("Test")),
      ],
    );
  }

  RequestOptions newRequestOptions(Options? options) {
    if (options is RequestOptions) {
      return options as RequestOptions;
    }
    if (options == null) {
      return RequestOptions(path: '');
    }
    return RequestOptions(
      method: options.method,
      sendTimeout: options.sendTimeout,
      receiveTimeout: options.receiveTimeout,
      extra: options.extra,
      headers: options.headers,
      responseType: options.responseType,
      contentType: options.contentType.toString(),
      validateStatus: options.validateStatus,
      receiveDataWhenStatusError: options.receiveDataWhenStatusError,
      followRedirects: options.followRedirects,
      maxRedirects: options.maxRedirects,
      requestEncoder: options.requestEncoder,
      responseDecoder: options.responseDecoder,
      path: '',
    );
  }

  RequestOptions _setStreamType<T>(RequestOptions requestOptions) {
    if (T != dynamic && !(requestOptions.responseType == ResponseType.bytes || requestOptions.responseType == ResponseType.stream)) {
      if (T == String) {
        requestOptions.responseType = ResponseType.plain;
      } else {
        requestOptions.responseType = ResponseType.json;
      }
    }
    return requestOptions;
  }
}
