// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'MainApi.dart';

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

class _MainApi implements MainApi {
  _MainApi(this._dio, {this.baseUrl}) {
    ArgumentError.checkNotNull(_dio, '_dio');
  }

  final Dio _dio;

  String? baseUrl;

  @override
  Future<ResultData<dynamic>> sendEmail(email) async {
    ArgumentError.checkNotNull(email, 'email');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    Response response;
    try {
      response = await _dio.request('/center/api/v1/email/verifycode/$email',
          queryParameters: queryParameters,
          options: Options(
              method: 'GET',
              headers: <String, dynamic>{},
              extra: _extra,),
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

  @override
  Future<ResultData<dynamic>> login(map) async {
    ArgumentError.checkNotNull(map, 'map');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(map );
    _data.removeWhere((k, v) => v == null);
    Response response;
    try {
      response = await _dio.request('/center/api/v1/user',
          queryParameters: queryParameters,
          options: Options(
              method: 'PUT',
              headers: <String, dynamic>{},
              extra: _extra,),
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

  @override
  Future<ResultData<dynamic>> regist(map) async {
    ArgumentError.checkNotNull(map, 'map');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(map );
    _data.removeWhere((k, v) => v == null);
    Response response;
    try {
      response = await _dio.request('/center/api/v1/user',
          queryParameters: queryParameters,
          options: Options(
              method: 'POST',
              headers: <String, dynamic>{},
              extra: _extra,),
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
