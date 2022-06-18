import 'dart:async';

import 'package:not_so_secret/app/app_prefs.dart';
import 'package:not_so_secret/app/di.dart';
import 'package:not_so_secret/data/data_source/local_data_source.dart';
import 'package:not_so_secret/domain/model/model.dart';
import 'package:not_so_secret/domain/usecase/home_usecase.dart';
import 'package:not_so_secret/domain/usecase/profile_usecase.dart';
import 'package:not_so_secret/presentation/base/baseviewmodel.dart';
import 'package:not_so_secret/presentation/common/freezed_data_classes.dart';
import 'package:not_so_secret/presentation/common/state_renderer/state_render_impl.dart';
import 'package:not_so_secret/presentation/common/state_renderer/state_renderer.dart';
import 'package:not_so_secret/presentation/resources/strings_manager.dart';
import 'package:rxdart/subjects.dart';
import 'package:easy_localization/easy_localization.dart';

class ProfileViewModel extends BaseViewModel
    with ProfileViewModelInputs, ProfileViewModelOutputs {
  StreamController _personspostStreamController = BehaviorSubject<List<Post>>();
  StreamController _personsnameStreamController = BehaviorSubject<String>();
  StreamController postsdeleteController = BehaviorSubject<int>();
  StreamController _profileUserInfoStreamController =
      BehaviorSubject<UserInfo>();
  StreamController pageController = BehaviorSubject<int>();
  AppPreferences _appPreferences = instance<AppPreferences>();
  var profileViewObject = ProfileDeleteObject(0);

  LocalDataSource _localDataSource = instance<LocalDataSource>();
  var profilePostObject = ProfilePostsUseCaseInputs(1);
  int currentPage = 1;

  ProfileUseCase _profileUseCase;

  ProfileViewModel(this._profileUseCase);
  @override
  void start() {
    getProfile();
    _getUsername();
    getUserInfo();
  }
  //inputs
   @override
  Sink get inputPersonsPost => _personspostStreamController.sink;
  @override
  Sink get inputPersonsUsername => _personsnameStreamController.sink;
  @override
  Sink get inputPostId => postsdeleteController.sink;
   @override
  Sink get inputPage => pageController.sink;
  @override
  Sink get inputUserInfo => _profileUserInfoStreamController.sink;

  //outputs

   @override
  Stream<List<Post>> get outputPersonsPosts =>
      _personspostStreamController.stream.map((posts) => posts);

  @override
  Stream<String> get outputPersonsUsername =>
      _personsnameStreamController.stream.map((username) => username);

  @override
  Stream<UserInfo> get outputUserInfo =>
      _profileUserInfoStreamController.stream.map((userInfo) => userInfo);


  //functions

  getProfile() async {
    inputState.add(LoadingState(
        stateRendererType: StateRendererType.FULL_SCREEN_LOADING_STATE));
    (await _profileUseCase
            .execute(ProfilePostsUseCaseInputs(profilePostObject.page)))
        .fold(
            (failure) => inputState.add(ErrorState(
                StateRendererType.FULL_SCREEN_ERROR_STATE, failure.message)),
            (profileObject) {
      inputState.add(ContentState());

      inputPersonsPost.add(profileObject.data.posts);
      inputPage.add(profileObject.data.totalPage);
    });
  }

  _getUsername() async {
    inputPersonsUsername.add(await _appPreferences.getUsername());
  }

  deleteSecret() async {
    inputState.add(LoadingState(
        stateRendererType: StateRendererType.FULL_SCREEN_LOADING_STATE));
    (await _profileUseCase
            .delete(ProfileUseCaseInputs(profileViewObject.secretId)))
        .fold(
            (failure) => {
                  
                  inputState.add(ErrorState(StateRendererType.POPUP_ERROR_STATE,
                      AppStrings.secretcantsend.tr()))
                }, (data) {
      inputState.add(ContentState());
      getUserInfo();
      getProfile();

      _localDataSource.clearCache();

      
    });
  }

  getOtherPages() async {
    currentPage = await _appPreferences.getPage();
    (await _profileUseCase.execute(ProfilePostsUseCaseInputs(currentPage)))
        .fold((failure) {}, (profileObject) {
      inputPersonsPost.add(profileObject.data.posts);
    });
  }

  @override
  void dispose() {
    _personspostStreamController.close();
    _personsnameStreamController.close();
    postsdeleteController.close();
    pageController.close();
    _profileUserInfoStreamController.close();
    super.dispose();
  }

  @override
  setSecretId(int secretId) {
    inputPostId.add(secretId);
    profileViewObject = profileViewObject.copyWith(secretId: secretId);
  }

  @override
  refresh() {
    getProfile();
  }

 
  @override
  getUserInfo() async {
    (await _profileUseCase.getUserInfo()).fold((failure) {}, (userInfo) {
      inputUserInfo.add(userInfo.data.userInfo);
    });
  }

  

  
}

abstract class ProfileViewModelInputs {
  refresh();
  deleteSecret();
  setSecretId(int id);
  getUserInfo();

  Sink get inputPersonsPost;
  Sink get inputPersonsUsername;
  Sink get inputPostId;
  Sink get inputPage;
  Sink get inputUserInfo;
}

abstract class ProfileViewModelOutputs {
  Stream<List<Post>> get outputPersonsPosts;
  Stream<String> get outputPersonsUsername;
  Stream<UserInfo> get outputUserInfo;
}
