import 'package:not_so_secret/app/functions.dart';
import 'package:not_so_secret/data/network/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:not_so_secret/data/request/request.dart';
import 'package:not_so_secret/domain/model/model.dart';
import 'package:not_so_secret/domain/repository/repository.dart';
import 'package:not_so_secret/domain/usecase/base_usecase.dart';

class LoginUseCase implements BaseUseCase<LoginUseCaseInput, Authentication> {
  Repository _repository;
  LoginUseCase(this._repository);
  @override
  Future<Either<Failure, Authentication>> execute(
      LoginUseCaseInput input) async {
    DeviceInfo deviceInfo = await getDeviceDetails();
    return await _repository.login(LoginRequest(
        input.sign, input.password, deviceInfo.name, deviceInfo.identifier));
  }
}

class LoginUseCaseInput {
  String sign;
  String password;
  LoginUseCaseInput(this.sign, this.password);
}
