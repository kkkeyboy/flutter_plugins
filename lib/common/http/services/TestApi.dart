import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart' hide Headers;

part 'TestApi.g.dart';

@RestApi()
abstract class TestApi {
  factory TestApi(Dio dio, {String? baseUrl}) = _TestApi;

   @GET('/tags')
  Future getTags({@DioOptions() Options? options});
}
