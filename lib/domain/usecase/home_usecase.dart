import 'package:not_so_secret/data/network/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:not_so_secret/data/request/request.dart';
import 'package:not_so_secret/domain/model/model.dart';
import 'package:not_so_secret/domain/repository/repository.dart';
import 'package:not_so_secret/domain/usecase/base_usecase.dart';

class HomeUseCase extends BaseUseCase<HomeUseCaseInputs, HomeObject> {
  Repository _repository;
  HomeUseCase(this._repository);
  @override
  Future<Either<Failure, HomeObject>> execute(
      HomeUseCaseInputs homeUseCasePostInputs) async {
    return await _repository.getHome(
        homeUseCasePostInputs.language, homeUseCasePostInputs.page);
  }


  

}

class HomeUseCaseInputs {
 
  String language;
  int page;
  HomeUseCaseInputs( this.language, this.page);
}

