import 'package:dio/dio.dart';
import 'package:not_so_secret/app/constant.dart';
import 'package:not_so_secret/data/responses/responses.dart';
import 'package:not_so_secret/domain/model/model.dart';
import 'package:retrofit/retrofit.dart';
part 'app_api.g.dart';

@RestApi(baseUrl: Constant.baseUrl)
abstract class AppServiceClient {
  factory AppServiceClient(Dio dio, {String baseUrl}) = _AppServiceClient;

  @POST("/account/login")
  Future<AuthenticationResponse> login(
      @Field("sign") String sign,
      @Field("password") String password,
      @Field("imei") String imei,
      @Field("deviceType") String deviceType,
      @Field("deviceId") String deviceId);

  @POST("/account/register")
  Future<AuthenticationResponse> register(
      @Field("sign") String sign, @Field("password") String password);

  @GET("/secret/receive/{language}/{page}")
  Future<HomeDataResponse> getHome(
      @Path("language") String language, @Path("page") int page);
  @POST("/secret/send")
  Future<PostResponse> sendSecret(@Field("title") String title,
      @Field("content") String content, @Field("language") String language);

  @GET("/secret/mysecrets/{page}")
  Future<HomeDataResponse> getProfile(@Path("page") int page);

  @POST("/secret/remove/{secretId}")
  Future<ProfileResponse> deleteSecret(@Field("secretId") int secretId);

  @POST("/secret/comment/add")
  Future<CommentResponse> addComment(
      @Field("secretId") int secretId, @Field("data") String data);

  @GET("/secret/receive/comments/{secretId}/{language}/{page}")
  Future<CommentDataResponse> getComments(@Path("secretId") int secretId,
      @Path("language") String language, @Path("page") int page);

  @GET("/secret/comment/remove/{secretId}/{commentId}")
  Future<CommentResponse> deleteComment(@Path("secretId") int secretId,@Path("commentId") int commentId);

  @GET("/account/info/")
  Future<ProfileUserInfoResponse> getUserInfo();
}
