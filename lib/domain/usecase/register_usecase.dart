import 'package:not_so_secret/app/functions.dart';
import 'package:not_so_secret/data/network/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:not_so_secret/data/request/request.dart';
import 'package:not_so_secret/domain/model/model.dart';
import 'package:not_so_secret/domain/repository/repository.dart';
import 'package:not_so_secret/domain/usecase/base_usecase.dart';

class RegisterUseCase implements BaseUseCase<RegisterUseCaseInput, Authentication> {
  Repository _repository;
  RegisterUseCase(this._repository);
  @override
  Future<Either<Failure, Authentication>> execute(
      RegisterUseCaseInput input) async {
    
    return await _repository.register(RegisterRequest(input.sign, input.password));
  }
}

class RegisterUseCaseInput {
  String sign;
  String password;
  RegisterUseCaseInput(this.sign, this.password);
}
