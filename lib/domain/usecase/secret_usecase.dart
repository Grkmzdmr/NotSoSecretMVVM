import 'package:not_so_secret/data/network/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:not_so_secret/data/request/request.dart';
import 'package:not_so_secret/domain/repository/repository.dart';
import 'package:not_so_secret/domain/usecase/base_usecase.dart';

class SecretUseCase implements BaseUseCase<SecretUseCaseInput, void> {
  Repository _repository;
  SecretUseCase(this._repository);

  @override
  Future<Either<Failure, void>> execute(SecretUseCaseInput input) async {
    return await _repository
        .sendSecret(PostRequest(input.title, input.content, input.language));
  }
}

class SecretUseCaseInput {
  String title;
  String content;
  String language;
  SecretUseCaseInput(this.title, this.content,this.language);
}
