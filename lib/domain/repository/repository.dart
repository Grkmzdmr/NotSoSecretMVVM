import 'package:dartz/dartz.dart';
import 'package:not_so_secret/data/network/failure.dart';
import 'package:not_so_secret/data/request/request.dart';


import '../model/model.dart';

abstract class Repository {
  Future<Either<Failure, Authentication>> login(LoginRequest loginRequest);
  Future<Either<Failure, Authentication>> register(
      RegisterRequest registerRequest);
  Future<Either<Failure, HomeObject>> getHome(String language, int page);
  Future<Either<Failure, CommentObject>> getComments(int secretId,String language, int page);
  Future<Either<Failure, Post>> sendSecret(PostRequest postRequest);
  Future<Either<Failure, HomeObject>> getProfile(int page);
  Future<Either<Failure, ProfileObject>> deleteSecret(int id);
  Future<Either<Failure, Comment>> sendComment(AddCommentRequest addCommentRequest);
  Future<Either<Failure, Comment>> deleteComment(int secretId,int commentId);
 
}
