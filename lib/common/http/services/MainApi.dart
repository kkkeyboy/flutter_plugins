import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart' hide Headers;

part 'MainApi.g.dart';

@RestApi()
abstract class MainApi {
  factory MainApi(Dio dio, {String? baseUrl}) = _MainApi;

  @GET('/center/api/v1/email/verifycode/{email}')
  Future<ResultData> sendEmail(@Path("email") String email);

  @PUT("/center/api/v1/user")
  Future<ResultData> login(@Body() Map<String, dynamic> map);

  @POST("/center/api/v1/user")
  Future<ResultData> regist(@Body() Map<String, dynamic> map);

}
