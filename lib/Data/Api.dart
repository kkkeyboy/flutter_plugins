import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';

import 'index.dart';

part 'Api.g.dart';

@RestApi(baseUrl: "https://5d42a6e2bc64f90014a56ca0.mockapi.io/api/v1/")
abstract class RestClient {
  factory RestClient(Dio dio, {String baseUrl}) = _RestClient;

  @GET("/tasks")
  Future<List<Task>> getTasks();

  @GET("/tasks1")
  Future<ResultData<List<Task>>> getTasks1();

  @GET("/tasks2")
  Future<ResultData<Task>> getTasks2();

  @POST("/tasks")
  Future<ResultData<Task>> createTask(@Body() Task task);

    @POST("/tasks")
  Future<ResultData<Task>> createTask2(@Body() Map<String, dynamic> map);

  @POST("http://httpbin.org/post")
  @FormUrlEncoded()
  Future<ResultData<String>> postUrlEncodedFormData(
    @Fields() Map<String, dynamic> queries,
    @Field() String hello, {
    @Field() String gg,
  });
}
