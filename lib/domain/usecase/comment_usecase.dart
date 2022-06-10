import 'package:not_so_secret/data/network/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:not_so_secret/data/request/request.dart';
import 'package:not_so_secret/domain/model/model.dart';
import 'package:not_so_secret/domain/repository/repository.dart';
import 'package:not_so_secret/domain/usecase/base_usecase.dart';
import 'package:not_so_secret/domain/usecase/home_usecase.dart';

class CommentUseCase implements BaseUseCase<CommentUseCaseInput, void> {
  Repository _repository;
  CommentUseCase(this._repository);

  Future<Either<Failure, Comment>> addComment(
      AddCommentUseCaseInput input) async {
    return await _repository
        .sendComment(AddCommentRequest(input.id, input.data));
  }

  Future<Either<Failure, Comment>> deleteComment(
     int secretId,int commentId) async {
    return await _repository.deleteComment(secretId,commentId);
  }

  @override
  Future<Either<Failure, CommentObject>> execute(
      CommentUseCaseInput commentUseCaseInput) async {
    return await _repository.getComments(commentUseCaseInput.secretId,
        commentUseCaseInput.language, commentUseCaseInput.page);
  }
}

class AddCommentUseCaseInput {
  int id;
  String data;
  AddCommentUseCaseInput(this.id, this.data);
}

class CommentUseCaseInput {
  int secretId;
  String language;
  int page;
  CommentUseCaseInput(this.secretId, this.language, this.page);
}

class DeleteCommentUseCaseInput {
  int secretId;
  int commentId;
  DeleteCommentUseCaseInput(this.secretId, this.commentId);
}
