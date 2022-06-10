import 'dart:async';

import 'package:flutter/material.dart';
import 'package:not_so_secret/domain/usecase/secret_usecase.dart';
import 'package:not_so_secret/presentation/base/baseviewmodel.dart';
import 'package:not_so_secret/presentation/common/freezed_data_classes.dart';
import 'package:not_so_secret/presentation/common/state_renderer/state_render_impl.dart';
import 'package:not_so_secret/presentation/common/state_renderer/state_renderer.dart';
import 'package:not_so_secret/presentation/resources/routes_manager.dart';
import 'package:not_so_secret/presentation/resources/strings_manager.dart';
import 'package:easy_localization/easy_localization.dart';

class AddSecretViewModel extends BaseViewModel
    with AddSecretViewModelInput, AddSecretViewModelOutput {
  StreamController _secretTextStreamController =
      StreamController<String>.broadcast();
  StreamController _secretTitleStreamController =
      StreamController<String>.broadcast();
  StreamController _isAllInputsValidStreamController =
      StreamController<void>.broadcast();
  StreamController isSecretSharedSuccessfullyStreamController =
      StreamController<bool>();
  StreamController _secretLanguageStreamController =
      StreamController<String>.broadcast();

  SecretUseCase _secretUseCase;
  var secretViewObject = SecretObject("", "", "");
  AddSecretViewModel(this._secretUseCase);

  @override
  void dispose() {
    _secretTextStreamController.close();
    _secretTitleStreamController.close();
    _isAllInputsValidStreamController.close();
    isSecretSharedSuccessfullyStreamController.close();
    _secretLanguageStreamController.close();
  }

  @override
  void start() {
    inputState.add(ContentState());
  }

  @override
  // TODO: implement inputText
  Sink get inputText => _secretTextStreamController.sink;

  @override
  // TODO: implement outputIsTextValid
  Stream<bool> get outputIsTextValid =>
      _secretTextStreamController.stream.map((text) => _isTextValid(text));

  @override
  setSecretText(String text) {
    inputText.add(text);
    if (_isTextValid(text)) {
      secretViewObject = secretViewObject.copyWith(text: text);
    } else {
      secretViewObject = secretViewObject.copyWith(text: "");
    }
  }

  @override
  sendSecret() async {
    inputState.add(
        LoadingState(stateRendererType: StateRendererType.FULL_SCREEN_LOADING_STATE));
    (await _secretUseCase.execute(SecretUseCaseInput(secretViewObject.title,
            secretViewObject.text, secretViewObject.language)))
        .fold(
            (failure) => {
                  //left -> failure
                  inputState.add(ErrorState(StateRendererType.POPUP_ERROR_STATE,
                      AppStrings.secretcantsend.tr()))
                }, (data) {
      inputState.add(ContentState()); // navigate to main screen after the login
      //succes
      isSecretSharedSuccessfullyStreamController.add(true);
    });
  }

  @override
  // TODO: implement inputIsAllInputValid
  Sink get inputIsAllInputValid => _isAllInputsValidStreamController.sink;

  @override
  // TODO: implement inputPassword
  Sink get inputTitle => _secretTitleStreamController.sink;

  @override
  // TODO: implement inputLanguage
  Sink get inputLanguage => _secretLanguageStreamController.sink;

  @override
  // TODO: implement outputIsAllInputsValid
  Stream<bool> get outputIsAllInputsValid =>
      _isAllInputsValidStreamController.stream.map((_) => _isAllInputsValid());

  @override
  // TODO: implement outputIsTitleValid
  Stream<bool> get outputIsTitleValid =>
      _secretTitleStreamController.stream.map((title) => _isTitleValid(title));

  @override
  setSecretTitle(String title) {
    inputTitle.add(title);
    if (_isTitleValid(title)) {
      secretViewObject = secretViewObject.copyWith(title: title);
    } else {
      secretViewObject = secretViewObject.copyWith(title: "");
    }
  }

  _isTextValid(String text) {
    return text.isNotEmpty && text.length <= 280;
  }

  _isTitleValid(String title) {
    return title.isNotEmpty && title.length <= 20;
  }

  _isAllInputsValid() {
    return _isTitleValid(secretViewObject.title) &&
        _isTextValid(secretViewObject.text);
  }

  @override
  setSecretLanguage(String language) {
    inputLanguage.add(language);
    secretViewObject = secretViewObject.copyWith(language: language);
  }
}

abstract class AddSecretViewModelInput {
  sendSecret();
  setSecretTitle(String title);
  setSecretText(String text);
  setSecretLanguage(String language);

  Sink get inputLanguage;
  Sink get inputText;
  Sink get inputTitle;
  Sink get inputIsAllInputValid;
}

abstract class AddSecretViewModelOutput {
  Stream<bool> get outputIsTitleValid;
  Stream<bool> get outputIsTextValid;
  Stream<bool> get outputIsAllInputsValid;
}
