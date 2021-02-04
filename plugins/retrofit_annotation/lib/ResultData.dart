import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';

import 'CommonData.dart';

class ResultData<T> {
  var response;
  bool isSuccess;
  var headers;
  int stateCode;
  CommonData<T> data;

  ResultData(this.response, int code, {this.headers, T subData}) {
    this.stateCode = code;
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

  T get subData => data.data;

  String get msg => isSuccess == true ? "成功" : data?.msg ?? _getMapResponse()[ResultDataConfig.config.FIELD_MSG] ?? "服務器錯誤，請稍後再試";

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

  final Function(ResultData value) onResult;

  const ResultDataConfig(
      {this.SUCCESS_CODE = _SUCCESS_CODE,
      this.FIELD_CODE = _FIELD_CODE,
      this.FIELD_MSG = _FIELD_MSG,
      this.FIELD_CONTENT = _FIELD_CONTENT,
      this.onResult});
}

class HanldeResultError {
  static ResultData<T> resultError<T>(Error e) {
    Response errorResponse;
    if (e is DioError) {
      final e1 = e as DioError;
      if (e1.response != null) {
        errorResponse = e1.response;
      } else {
        errorResponse = new Response(statusCode: 666, statusMessage: e1.message);
      }
      if (e1.type == DioErrorType.CONNECT_TIMEOUT || e1.type == DioErrorType.RECEIVE_TIMEOUT) {
        errorResponse.statusCode = -1;
      }
    } else {
      errorResponse = new Response(statusCode: 666, statusMessage: e.stackTrace?.toString());
    }
    return new ResultData<T>(errorResponse.statusMessage, errorResponse.statusCode);
  }
}
