import 'dart:async';

import 'package:not_so_secret/domain/usecase/register_usecase.dart';
import 'package:not_so_secret/presentation/base/baseviewmodel.dart';
import 'package:not_so_secret/presentation/common/freezed_data_classes.dart';
import 'package:not_so_secret/presentation/common/state_renderer/state_render_impl.dart';
import 'package:not_so_secret/presentation/common/state_renderer/state_renderer.dart';
import 'package:not_so_secret/presentation/resources/strings_manager.dart';
import 'package:easy_localization/easy_localization.dart';

class RegisterViewModel extends BaseViewModel
    with RegisterViewModelInput, RegisterViewModelOutput {
  StreamController _userNameStreamController =
      StreamController<String>.broadcast();
  StreamController _passwordStreamController =
      StreamController<String>.broadcast();
  StreamController _isAllInputsValidStreamController =
      StreamController<void>.broadcast();
  StreamController isUserRegisterInSuccessfullyStreamController =
      StreamController<bool>();
  StreamController _isAgreeStreamController =
      StreamController<bool>.broadcast();
  RegisterUseCase _registerUseCase;

  var registerViewObject = RegisterObject("", "", false);

  RegisterViewModel(this._registerUseCase);

  @override
  void start() {
    inputState.add(ContentState());
  }

  @override
  void dispose() {
    _userNameStreamController.close();
    _passwordStreamController.close();
    _isAllInputsValidStreamController.close();
    isUserRegisterInSuccessfullyStreamController.close();
    _isAgreeStreamController.close();
    super.dispose();
  }

// -- inputs
  @override
  Sink get inputPassword => _passwordStreamController.sink;

  @override
  Sink get inputUserName => _userNameStreamController.sink;

  @override
  Sink get inputAllInputsValid => _isAllInputsValidStreamController.sink;

  @override
  Sink get inputCheckBox => _isAgreeStreamController.sink;
// -- outputs

  @override
  Stream<String?> get outputErrorPassword =>
      outputIsPasswordValid.map((isPasswordValid) =>
          isPasswordValid ? null : AppStrings.invalidPassword.tr());

  @override
  Stream<String?> get outputErrorUserName =>
      outputIsUserNameValid.map((isUserNameValid) =>
          isUserNameValid ? null : AppStrings.invalidUserName.tr());

  @override
  Stream<bool> get outputIsPasswordValid => _passwordStreamController.stream
      .map((password) => _isPasswordValid(password));

  @override
  Stream<bool> get outputIsUserNameValid => _userNameStreamController.stream
      .map((userName) => _isUserNameValid(userName));

  @override
  Stream<bool> get outputIsAllValid =>
      _isAllInputsValidStreamController.stream.map((_) => _validateAllInputs());
  @override
  register() async {
    inputState.add(LoadingState(
        stateRendererType: StateRendererType.FULL_SCREEN_LOADING_STATE));
    (await _registerUseCase.execute(RegisterUseCaseInput(
            registerViewObject.userName, registerViewObject.password)))
        .fold(
            (failure) => {
                  //left -> failure
                  inputState.add(ErrorState(StateRendererType.POPUP_ERROR_STATE,
                      AppStrings.alreadyHaveUser.tr()))
                }, (data) {
      inputState.add(ContentState()); // navigate to main screen after the login
      //succes
      isUserRegisterInSuccessfullyStreamController.add(true);
    });
  }

  // -- private methods
  _isUserNameValid(String userName) {
    return userName.length >= 6;
  }

  _isPasswordValid(String password) {
    return password.length >= 8;
  }

  _isCheckBoxValid(bool value) {
    if (value) {
      return value;
    }
  }

  bool _validateAllInputs() {
    return registerViewObject.userName.isNotEmpty &&
        registerViewObject.password.isNotEmpty &&
        registerViewObject.value;
  }

  _validate() {
    inputAllInputsValid.add(null);
  }

  @override
  setPassword(String password) {
    inputPassword.add(password);
    if (_isPasswordValid(password)) {
      //update register view object with password
      registerViewObject = registerViewObject.copyWith(password: password);
    } else {
      //reset password value in register view object
      registerViewObject = registerViewObject.copyWith(password: "");
    }
    _validate();
  }

  @override
  setCheckBox(bool value) {
    inputCheckBox.add(value);
   
    registerViewObject = registerViewObject.copyWith(value: value);
   
    _validate();
  }

  @override
  setUserName(String userName) {
    inputUserName.add(userName);
    if (_isUserNameValid(userName)) {
      //update register view object with username
      registerViewObject = registerViewObject.copyWith(userName: userName);
    } else {
      //reset username value in register view object
      registerViewObject = registerViewObject.copyWith(userName: "");
    }
    _validate();
  }

  @override
  // TODO: implement _chechBoxStream
  Stream<bool> get checkBoxStream =>
      _isAgreeStreamController.stream.map((value) => value);
}

abstract class RegisterViewModelInput {
  register();
  setCheckBox(bool value);
  setUserName(String userName);
  setPassword(String password);

  Sink get inputUserName;
  Sink get inputPassword;
  Sink get inputAllInputsValid;
  Sink get inputCheckBox;
}

abstract class RegisterViewModelOutput {
  Stream<bool> get outputIsUserNameValid;
  Stream<String?> get outputErrorUserName;
  Stream<bool> get outputIsPasswordValid;
  Stream<String?> get outputErrorPassword;
  Stream<bool> get checkBoxStream;

  Stream<bool> get outputIsAllValid;
}
