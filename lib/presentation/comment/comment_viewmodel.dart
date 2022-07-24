import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
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
import 'package:rxdart/rxdart.dart';

class CommentViewModel extends BaseViewModel
    with CommentViewModelInput, CommentViewModelOutput {
  StreamController _commentStreamController = BehaviorSubject<List<Comment>>();
  StreamController commentIdStreamController = BehaviorSubject<int>();

  StreamController commentDeleteController = BehaviorSubject<int>();
  StreamController isPostSuccessfullySendController = StreamController<bool>();
  StreamController _commentAddController = BehaviorSubject<String>();
  StreamController pageController = BehaviorSubject<int>();
  StreamController _isAllInputsValidStreamController = BehaviorSubject<void>();
  var commentViewObject = CommentAddObject(0, "");
  var commentPostObject = CommentPostObject(0, "tr", 1);
  var commentDeleteObject = CommentDeleteObject(14, 20);
  int currentPage = 1;
  int postId = 1;
  //late final FirebaseMessaging _messaging;
  //PushNotification? _notificationInfo;

  AppPreferences _appPreferences = instance<AppPreferences>();

  CommentUseCase _commentUseCase;
  CommentViewModel(this._commentUseCase);
  @override
  void dispose() {
    _commentStreamController.close();
    commentIdStreamController.close();
    _commentAddController.close();
    commentDeleteController.close();
    _isAllInputsValidStreamController.close();

    pageController.close();

    super.dispose();
  }

  getComments() async {
    postId = await _appPreferences.getPost();
    currentPage = await _appPreferences.getPage();
    inputState.add(LoadingState(
        stateRendererType: StateRendererType.FULL_SCREEN_LOADING_STATE));
    (await _commentUseCase.execute(CommentUseCaseInput(
            postId, commentPostObject.language, commentPostObject.page)))
        .fold((failure) {
      inputState.add(ErrorState(
          StateRendererType.FULL_SCREEN_ERROR_STATE, failure.message));
    }, (commentObject) {
      inputState.add(ContentState());
      inputPostsComments.add(commentObject.data.comments);
      inputPage.add(commentObject.data.totalPage);
    });
  }

  //inputs
  @override
  Sink get inputCommentId => commentIdStreamController.sink;

  @override
  Sink get inputCommentText => _commentAddController.sink;

  @override
  Sink get inputPostsComments => _commentStreamController.sink;

  @override
  Sink get inputDelete => commentDeleteController.sink;

  @override
  Sink get inputPage => pageController.sink;

  //outputs
  @override
  Stream<int> get outputCommentId =>
      commentIdStreamController.stream.map((id) => id);

  @override
  Stream<List<Comment>> get outputComments =>
      _commentStreamController.stream.map((comment) => comment);

  @override
  Stream<bool> get outputIsCommentValid =>
      _commentAddController.stream.map((comment) => _isCommentValid(comment));
  //functions
  @override
  sendComment() async {
    int id = await _appPreferences.getPost();
    inputState.add(LoadingState(
        stateRendererType: StateRendererType.FULL_SCREEN_LOADING_STATE));
    (await _commentUseCase
            .addComment(AddCommentUseCaseInput(id, commentViewObject.data)))
        .fold(
            (failure) => {
                  inputState.add(ErrorState(StateRendererType.POPUP_ERROR_STATE,
                      AppStrings.secretcantsend))
                }, (data) {
      inputState.add(ContentState());

      isPostSuccessfullySendController.add(true);
      getComments();
    });
  }

  @override
  void start() {
    getComments();
  }

  @override
  setCommentText(String text) {
    inputCommentText.add(text);
    if (_isCommentValid(text)) {
      commentViewObject = commentViewObject.copyWith(data: text);
    } else {
      commentViewObject = commentViewObject.copyWith(data: "");
    }
  }

  getOtherPages() async {
    currentPage = await _appPreferences.getPage();
    (await _commentUseCase.execute(CommentUseCaseInput(
            commentPostObject.secretId,
            commentPostObject.language,
            commentPostObject.page)))
        .fold((failure) {}, (commentObject) {
      inputPostsComments.add(commentObject.data.comments);
    });
  }

  @override
  refresh() {
    getComments();
  }

  @override
  deleteComment() async {
    inputState.add(LoadingState(
        stateRendererType: StateRendererType.FULL_SCREEN_LOADING_STATE));
    (await _commentUseCase.deleteComment(
            commentDeleteObject.secretId, commentDeleteObject.commentId))
        .fold((failure) {
      inputState.add(ErrorState(
          StateRendererType.POPUP_ERROR_STATE, AppStrings.secretcantsend));
    }, (data) {
      inputState.add(ContentState());
      getComments();
    });
  }

  @override
  setCommentId(int secretId, int commentId) {
    inputDelete.add(secretId);
    inputDelete.add(commentId);
    commentDeleteObject =
        commentDeleteObject.copyWith(secretId: secretId, commentId: commentId);
  }

  //Future _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  //  print("Handling a background message : ${message.messageId}");
  //}

  /*@override
  requestAndRegisterNotification() async {
    await Firebase.initializeApp();
    _messaging = FirebaseMessaging.instance;
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

    NotificationSettings settings = await _messaging.requestPermission(
      alert: true,
      badge: true,
      provisional: true,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      String? token = await _messaging.getToken();
      FirebaseMessaging.onMessage.listen((RemoteMessage message) {
        PushNotification notification = PushNotification(
            body: message.notification?.title,
            title: message.notification?.body);
        _notificationInfo = notification;
      });
    }
  }*/
}

_isCommentValid(String comment) {
  return comment.length <= 500;
}

abstract class CommentViewModelInput {
  setCommentId(int secretId, int commentId);
  sendComment();
  deleteComment();
  refresh();
 

  setCommentText(String text);
  Sink get inputPostsComments;
  Sink get inputCommentId;
  Sink get inputCommentText;

  Sink get inputPage;
  Sink get inputDelete;
}

abstract class CommentViewModelOutput {
  Stream<List<Comment>> get outputComments;
  Stream<int> get outputCommentId;

  Stream<bool> get outputIsCommentValid;
}
