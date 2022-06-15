import 'package:not_so_secret/data/network/app_api.dart';
import 'package:not_so_secret/data/request/request.dart';
import 'package:not_so_secret/data/responses/responses.dart';

abstract class RemoteDataSource {
  Future<AuthenticationResponse> login(LoginRequest loginRequest);
  Future<AuthenticationResponse> register(RegisterRequest registerRequest);
  Future<HomeDataResponse> getHome(String language, int page);
  Future<PostResponse> sendSecret(PostRequest postRequest);
  Future<HomeDataResponse> getProfile(int page);
  Future<CommentResponse> addComment(AddCommentRequest addCommentRequest);
  Future<ProfileResponse> deleteSecret(int id);
  Future<CommentDataResponse> getComments(CommentRequest commentRequest);
  Future<CommentResponse> deleteComment(int secretId, int commentId);
  Future<ProfileUserInfoResponse> getUserInfo();
}

class RemoteDataSourceImplementer implements RemoteDataSource {
  AppServiceClient _appServiceClient;

  RemoteDataSourceImplementer(this._appServiceClient);

  @override
  Future<AuthenticationResponse> login(LoginRequest loginRequest) async {
    return await _appServiceClient.login(loginRequest.sign,
        loginRequest.password, loginRequest.imei, loginRequest.deviceType);
  }

  @override
  Future<AuthenticationResponse> register(
      RegisterRequest registerRequest) async {
    return await _appServiceClient.register(
        registerRequest.sign, registerRequest.password);
  }

  @override
  Future<HomeDataResponse> getHome(String language, int page) async {
    return await _appServiceClient.getHome(language, page);
  }

  @override
  Future<PostResponse> sendSecret(PostRequest postRequest) async {
    return await _appServiceClient.sendSecret(
        postRequest.title, postRequest.content, postRequest.language);
  }

  @override
  Future<HomeDataResponse> getProfile(int page) async {
    return await _appServiceClient.getProfile(page);
  }

  @override
  Future<ProfileResponse> deleteSecret(int id) async {
    return await _appServiceClient.deleteSecret(id);
  }

  @override
  Future<CommentResponse> addComment(
      AddCommentRequest addCommentRequest) async {
    return await _appServiceClient.addComment(
        addCommentRequest.secretId, addCommentRequest.data);
  }

  @override
  Future<CommentDataResponse> getComments(CommentRequest commentRequest) async {
    return await _appServiceClient.getComments(
        commentRequest.secretId, commentRequest.language, commentRequest.page);
  }

  @override
  Future<CommentResponse> deleteComment(int secretId, int commentId) async {
    return await _appServiceClient.deleteComment(secretId, commentId);
  }

  @override
  Future<ProfileUserInfoResponse> getUserInfo() async {
    return await _appServiceClient.getUserInfo();
  }
}
