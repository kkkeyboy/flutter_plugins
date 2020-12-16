import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';

import 'CommonData.dart';

class ResultData<T> {
  var response;
  bool isSuccess;
  var headers;
  var stateCode;
  CommonData<T> data;

  T get subData => data.data;

  String get msg => isSuccess == true ? "成功" : data?.msg ?? _getMapResponse()[CommonData.FIELD_MSG] ?? "服務器錯誤，請稍後再試";

  Map<String, dynamic> _getMapResponse() {
    try {
      return response is Map<String, dynamic> ? response : jsonDecode(response[CommonData.FIELD_CONTENT]);
    } catch (e) {
      // LogUtil.e(e);
      return {};
    }
  }

  ResultData(this.response, int code, {this.headers, T subData}) {
    if (response != null) {
      try {
        this.data = CommonData.convertData(_getMapResponse(), data: subData);
      } catch (e) {
        // LogUtil.e(e);
      }
    }
    this.isSuccess = (code == HttpStatus.ok) && (this.data?.isSuccess() ?? false);
  }
}

class HanldeResultError{
   static ResultData resultError(DioError e) {
    Response errorResponse;
    if (e.response != null) {
      errorResponse = e.response;
    } else {
      errorResponse = new Response(statusCode: 666,statusMessage:e.message);
    }
    if (e.type == DioErrorType.CONNECT_TIMEOUT || e.type == DioErrorType.RECEIVE_TIMEOUT) {
      errorResponse.statusCode = -1;
    }
    return new ResultData(errorResponse.statusMessage, errorResponse.statusCode);
  }
}
