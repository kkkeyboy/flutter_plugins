// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'MainApi.dart';

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

class _MainApi implements MainApi {
  _MainApi(this._dio, {this.baseUrl});

  final Dio _dio;

  String? baseUrl;

  @override
  Future<ResultData<dynamic>> sendEmail(email) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    try {
      Response response;

      response = await _dio.fetch(_setStreamType<ResultData<dynamic>>(
          Options(method: 'GET', headers: <String, dynamic>{}, extra: _extra)
              .compose(_dio.options, '/center/api/v1/email/verifycode/$email',
                  queryParameters: queryParameters, data: _data)
              .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
      if (response.data is DioError) {
        return HanldeResultError.resultError(response.data);
      }
      final subDataResult =
          response.data[ResultDataConfig.config.FIELD_CONTENT];
      final statusCode =
          "${response.data[ResultDataConfig.config.FIELD_CODE] ?? ''}";
      if (ResultDataConfig.config.SUCCESS_CODE == statusCode) {
        final subData = subDataResult;
        return new ResultData(response.data, response.statusCode,
            headers: response.headers, subData: subData);
      } else {
        return new ResultData(
          response.data,
          response.statusCode,
          headers: response.headers,
        );
      }
    } catch (e) {
      return HanldeResultError.resultError(e);
    }
  }

  @override
  Future<ResultData<dynamic>> login(map) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(map);
    try {
      Response response;

      response = await _dio.fetch(_setStreamType<ResultData<dynamic>>(
          Options(method: 'PUT', headers: <String, dynamic>{}, extra: _extra)
              .compose(_dio.options, '/center/api/v1/user',
                  queryParameters: queryParameters, data: _data)
              .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
      if (response.data is DioError) {
        return HanldeResultError.resultError(response.data);
      }
      final subDataResult =
          response.data[ResultDataConfig.config.FIELD_CONTENT];
      final statusCode =
          "${response.data[ResultDataConfig.config.FIELD_CODE] ?? ''}";
      if (ResultDataConfig.config.SUCCESS_CODE == statusCode) {
        final subData = subDataResult;
        return new ResultData(response.data, response.statusCode,
            headers: response.headers, subData: subData);
      } else {
        return new ResultData(
          response.data,
          response.statusCode,
          headers: response.headers,
        );
      }
    } catch (e) {
      return HanldeResultError.resultError(e);
    }
  }

  @override
  Future<ResultData<dynamic>> regist(map) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(map);
    try {
      Response response;

      response = await _dio.fetch(_setStreamType<ResultData<dynamic>>(
          Options(method: 'POST', headers: <String, dynamic>{}, extra: _extra)
              .compose(_dio.options, '/center/api/v1/user',
                  queryParameters: queryParameters, data: _data)
              .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
      if (response.data is DioError) {
        return HanldeResultError.resultError(response.data);
      }
      final subDataResult =
          response.data[ResultDataConfig.config.FIELD_CONTENT];
      final statusCode =
          "${response.data[ResultDataConfig.config.FIELD_CODE] ?? ''}";
      if (ResultDataConfig.config.SUCCESS_CODE == statusCode) {
        final subData = subDataResult;
        return new ResultData(response.data, response.statusCode,
            headers: response.headers, subData: subData);
      } else {
        return new ResultData(
          response.data,
          response.statusCode,
          headers: response.headers,
        );
      }
    } catch (e) {
      return HanldeResultError.resultError(e);
    }
  }

  RequestOptions _setStreamType<T>(RequestOptions requestOptions) {
    if (T != dynamic &&
        !(requestOptions.responseType == ResponseType.bytes ||
            requestOptions.responseType == ResponseType.stream)) {
      if (T == String) {
        requestOptions.responseType = ResponseType.plain;
      } else {
        requestOptions.responseType = ResponseType.json;
      }
    }
    return requestOptions;
  }
}
