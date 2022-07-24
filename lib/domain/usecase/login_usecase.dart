import 'package:not_so_secret/app/app_prefs.dart';
import 'package:not_so_secret/app/di.dart';
import 'package:not_so_secret/app/functions.dart';
import 'package:not_so_secret/data/network/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:not_so_secret/data/request/request.dart';
import 'package:not_so_secret/domain/model/model.dart';
import 'package:not_so_secret/domain/repository/repository.dart';
import 'package:not_so_secret/domain/usecase/base_usecase.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginUseCase implements BaseUseCase<LoginUseCaseInput, Authentication> {
  Repository _repository;
  AppPreferences appPreferences = instance<AppPreferences>();
  LoginUseCase(this._repository);
  @override
  Future<Either<Failure, Authentication>> execute(
      LoginUseCaseInput input) async {
    DeviceInfo deviceInfo = await getDeviceDetails();
    String deviceToken = await appPreferences.getDeviceToken();
    return await _repository.login(LoginRequest(
        input.sign, input.password, deviceInfo.name, deviceInfo.identifier,deviceToken));
  }
}

class LoginUseCaseInput {
  String sign;
  String password;
  LoginUseCaseInput(this.sign, this.password);
}
