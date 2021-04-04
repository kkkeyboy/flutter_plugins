import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';

import 'CommonData.dart';

class ResultData<T> {
  var response;
  bool isSuccess = false;
  var headers;
  late int stateCode;
  CommonData<T>? data;

  ResultData(this.response, int? code, {this.headers, T? subData}) {
    this.stateCode = code??-1;
    if (response != null) {
      try {
        this.data = CommonData.convertData(_getMapResponse(), data: subData);
      } catch (e) {
        // LogUtil.e(e);
      }
    }
    this.isSuccess = (code == HttpStatus.ok) && (this.data?.isSuccess() ?? false);
    ResultDataConfig.config.onResult?.call(this);
  }

  T? get subData => data?.data;

  String get msg =>
      data?.msg ??
      _getMapResponse()[ResultDataConfig.config.FIELD_MSG] ??
      ResultDataConfig.config.getMsg?.call(this) ??
      (isSuccess ? "成功" : "服务器错误，请稍后再试");

  Map<String, dynamic> _getMapResponse() {
    try {
      return response is Map<String, dynamic> ? response : jsonDecode(response[ResultDataConfig.config.FIELD_CONTENT]);
    } catch (e) {
      // LogUtil.e(e);
      return {};
    }
  }
}

class ResultDataConfig {
  static ResultDataConfig config = ResultDataConfig();

  static const String _SUCCESS_CODE = '200';
  static const String _FIELD_CODE = 'status';
  static const String _FIELD_MSG = 'message';
  static const String _FIELD_CONTENT = 'data';

  final String SUCCESS_CODE;
  final String FIELD_CODE;
  final String FIELD_MSG;
  final String FIELD_CONTENT;

  final Function(ResultData value)? onResult;

  final String Function(ResultData value)? getMsg;

  const ResultDataConfig(
      {this.SUCCESS_CODE = _SUCCESS_CODE,
      this.FIELD_CODE = _FIELD_CODE,
      this.FIELD_MSG = _FIELD_MSG,
      this.FIELD_CONTENT = _FIELD_CONTENT,
      this.onResult,
      this.getMsg});
}

class HanldeResultError {
  static ResultData<T> resultError<T>(dynamic e) {
    Response? errorResponse;
    if (e is DioError) {
      final e1 = e;
      if (e1.response != null) {
        errorResponse = e1.response;
      } else {
        errorResponse = new Response(requestOptions:e1.requestOptions, statusCode: 666, statusMessage: e1.message);
      }
      if (e1.type == DioErrorType.connectTimeout || e1.type == DioErrorType.receiveTimeout) {
        errorResponse?.statusCode = -1;
      }
    } else if (e is Error) {
      errorResponse = new Response(requestOptions:RequestOptions(path:""),statusCode: 666, statusMessage: e.stackTrace?.toString());
    } else if (e is Exception) {
      errorResponse = new Response(requestOptions:RequestOptions(path:""),statusCode: 666, statusMessage: e.toString());
    }
    return new ResultData<T>(errorResponse?.statusMessage, errorResponse?.statusCode??0);
  }
}
