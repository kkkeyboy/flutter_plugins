// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Api.dart';

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

class _RestClient implements RestClient {
  _RestClient(this._dio, {this.baseUrl}) {
    ArgumentError.checkNotNull(_dio, '_dio');
    baseUrl ??= 'https://5d42a6e2bc64f90014a56ca0.mockapi.io/api/v1/';
  }

  final Dio _dio;

  String baseUrl;

  @override
  Future<List<Task>> getTasks() async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.request<List<dynamic>>('/tasks',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = _result.data
        .map((dynamic i) => Task.fromJson(i as Map<String, dynamic>))
        .toList();
    return value;
  }

  @override
  Future<ResultData<List<Task>>> getTasks1() async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    Response response;
    try {
      response = await _dio.request('/tasks1',
          queryParameters: queryParameters,
          options: RequestOptions(
              method: 'GET',
              headers: <String, dynamic>{},
              extra: _extra,
              baseUrl: baseUrl),
          data: _data);
    } on DioError catch (e) {
      return HanldeResultError.resultError(e);
    }
    if (response.data is DioError) {
      return HanldeResultError.resultError(response.data);
    }

    final subDataResult = response.data[CommonData.FIELD_CONTENT];

    final subData = subDataResult
        .map((dynamic i) => Task.fromJson(i as Map<String, dynamic>))
        .toList();
    return new ResultData(response.data, response.statusCode,
        headers: response.headers, subData: subData);
  }

  @override
  Future<ResultData<Task>> getTasks2() async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    Response response;
    try {
      response = await _dio.request('/tasks2',
          queryParameters: queryParameters,
          options: RequestOptions(
              method: 'GET',
              headers: <String, dynamic>{},
              extra: _extra,
              baseUrl: baseUrl),
          data: _data);
    } on DioError catch (e) {
      return HanldeResultError.resultError(e);
    }
    if (response.data is DioError) {
      return HanldeResultError.resultError(response.data);
    }

    final subDataResult = response.data[CommonData.FIELD_CONTENT];

    final subData = Task.fromJson(subDataResult);
    return new ResultData(response.data, response.statusCode,
        headers: response.headers, subData: subData);
  }

  @override
  Future<ResultData<Task>> createTask(task) async {
    ArgumentError.checkNotNull(task, 'task');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(task?.toJson() ?? <String, dynamic>{});
    _data.removeWhere((k, v) => v == null);
    Response response;
    try {
      response = await _dio.request('/tasks',
          queryParameters: queryParameters,
          options: RequestOptions(
              method: 'POST',
              headers: <String, dynamic>{},
              extra: _extra,
              baseUrl: baseUrl),
          data: _data);
    } on DioError catch (e) {
      return HanldeResultError.resultError(e);
    }
    if (response.data is DioError) {
      return HanldeResultError.resultError(response.data);
    }

    final subDataResult = response.data[CommonData.FIELD_CONTENT];

    final subData = Task.fromJson(subDataResult);
    return new ResultData(response.data, response.statusCode,
        headers: response.headers, subData: subData);
  }

  @override
  Future<ResultData<Task>> createTask2(map) async {
    ArgumentError.checkNotNull(map, 'map');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(map ?? <String, dynamic>{});
    _data.removeWhere((k, v) => v == null);
    Response response;
    try {
      response = await _dio.request('/tasks',
          queryParameters: queryParameters,
          options: RequestOptions(
              method: 'POST',
              headers: <String, dynamic>{},
              extra: _extra,
              baseUrl: baseUrl),
          data: _data);
    } on DioError catch (e) {
      return HanldeResultError.resultError(e);
    }
    if (response.data is DioError) {
      return HanldeResultError.resultError(response.data);
    }

    final subDataResult = response.data[CommonData.FIELD_CONTENT];

    final subData = Task.fromJson(subDataResult);
    return new ResultData(response.data, response.statusCode,
        headers: response.headers, subData: subData);
  }

  @override
  Future<ResultData<String>> postUrlEncodedFormData(queries, hello,
      {gg}) async {
    ArgumentError.checkNotNull(queries, 'queries');
    ArgumentError.checkNotNull(hello, 'hello');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    queryParameters.removeWhere((k, v) => v == null);
    final _data = {'hello': hello, 'gg': gg};
    _data.removeWhere((k, v) => v == null);
    Response response;
    try {
      response = await _dio.request('http://httpbin.org/post',
          queryParameters: queryParameters,
          options: RequestOptions(
              method: 'POST',
              headers: <String, dynamic>{},
              extra: _extra,
              contentType: 'application/x-www-form-urlencoded',
              baseUrl: baseUrl),
          data: _data);
    } on DioError catch (e) {
      return HanldeResultError.resultError(e);
    }
    if (response.data is DioError) {
      return HanldeResultError.resultError(response.data);
    }

    final subDataResult = response.data[CommonData.FIELD_CONTENT];

    final subData = subDataResult;
    return new ResultData(response.data, response.statusCode,
        headers: response.headers, subData: subData);
  }
}
