import 'dart:async';
import 'dart:ffi';

import 'package:not_so_secret/app/app_prefs.dart';
import 'package:not_so_secret/app/di.dart';
import 'package:not_so_secret/domain/model/model.dart';
import 'package:not_so_secret/domain/usecase/comment_usecase.dart';
import 'package:not_so_secret/domain/usecase/home_usecase.dart';
import 'package:not_so_secret/presentation/base/baseviewmodel.dart';
import 'package:not_so_secret/presentation/common/freezed_data_classes.dart';
import 'package:not_so_secret/presentation/common/state_renderer/state_render_impl.dart';
import 'package:not_so_secret/presentation/common/state_renderer/state_renderer.dart';
import 'package:not_so_secret/presentation/resources/strings_manager.dart';
import 'package:rxdart/subjects.dart';

class HomeViewModel extends BaseViewModel
    with HomeViewModelInputs, HomeViewModelOutputs {
  StreamController _postStreamController = BehaviorSubject<List<Post>>();
  StreamController pageController = BehaviorSubject<int>();
  StreamController commentSecretController = BehaviorSubject<Post>();
  var homePostObject = HomePostObject("tr", 1);
  var commentPostObject = CommentSecretObject(0, "", "", "", "", 0, "", 0);
  AppPreferences _appPreferences = instance<AppPreferences>();
  int currentPage = 1;
  HomeUseCase _homeUseCase;

  HomeViewModel(this._homeUseCase);
  //inputs
  @override
  void start() {
    getHome();
  }

  getHome() async {
    currentPage = await _appPreferences.getPage();
    inputState.add(LoadingState(
        stateRendererType: StateRendererType.FULL_SCREEN_LOADING_STATE));
    (await _homeUseCase.execute(HomeUseCaseInputs(homePostObject.language, 1)))
        .fold((failure) {
      inputState.add(ErrorState(
          StateRendererType.FULL_SCREEN_ERROR_STATE, failure.message));
    }, (homeObject) {
      inputState.add(ContentState());

      inputPost.add(homeObject.data.posts);
      inputPage.add(homeObject.data.totalPage);
    });
  }

  getOtherPosts() async {
    currentPage = await _appPreferences.getPage();

    (await _homeUseCase
            .execute(HomeUseCaseInputs(homePostObject.language, currentPage)))
        .fold((failure) {}, (homeObject) {
      inputPost.add(homeObject.data.posts);
    });
  }

  @override
  void dispose() {
    _postStreamController.close();
    pageController.close();
    commentSecretController.close();

    super.dispose();
  }

  @override
  // TODO: implement inputPost
  Sink get inputPost => _postStreamController.sink;
  //outputs
  @override
  // TODO: implement outputPosts
  Stream<List<Post>> get outputPosts =>
      _postStreamController.stream.map((posts) => posts);

  @override
  refresh() {
    getHome();
    
  }

  @override
  // TODO: implement inputPage
  Sink get inputPage => pageController.sink;

  @override
  // TODO: implement inputCommentPost
  Sink get inputCommentPost => commentSecretController.sink;

  @override
  // TODO: implement outputCommentPost
  Stream<Post> get outputCommentPost =>
      commentSecretController.stream.map((post) => post);

 
}

abstract class HomeViewModelInputs {
  refresh();
  

  Sink get inputPost;
  Sink get inputPage;
  Sink get inputCommentPost;
}

abstract class HomeViewModelOutputs {
  Stream<List<Post>> get outputPosts;
  Stream<Post> get outputCommentPost;
}
