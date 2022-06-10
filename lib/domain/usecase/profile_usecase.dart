import 'package:not_so_secret/data/network/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:not_so_secret/domain/model/model.dart';
import 'package:not_so_secret/domain/repository/repository.dart';
import 'package:not_so_secret/domain/usecase/base_usecase.dart';
import 'package:not_so_secret/domain/usecase/home_usecase.dart';

class ProfileUseCase extends BaseUseCase<ProfilePostsUseCaseInputs, HomeObject> {
  Repository _repository;
  ProfileUseCase(this._repository);

  @override
  Future<Either<Failure, HomeObject>> execute(
      ProfilePostsUseCaseInputs postsUseCaseInputs) async {
    return await _repository.getProfile(postsUseCaseInputs.page);
  }

  Future<Either<Failure, ProfileObject>> delete(
      ProfileUseCaseInputs input) async {
    return await _repository.deleteSecret(input.secretId);
  }
}

class ProfileUseCaseInputs {
  int secretId;
  ProfileUseCaseInputs(this.secretId);
}

class ProfilePostsUseCaseInputs {
  int page;
  ProfilePostsUseCaseInputs(this.page);
}
