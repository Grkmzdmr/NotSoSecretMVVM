import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:not_so_secret/domain/model/model.dart';
part 'freezed_data_classes.freezed.dart';

@freezed
class LoginObject with _$LoginObject {
  factory LoginObject(String userName, String password) = _LoginObject;
}

@freezed
class RegisterObject with _$RegisterObject {
  factory RegisterObject(String userName, String password) = _RegisterObject;
}

@freezed
class SecretObject with _$SecretObject {
  factory SecretObject(String title, String text, String language) =
      _SecretObject;
}

@freezed
class CommentAddObject with _$CommentAddObject {
  factory CommentAddObject(int secretId, String data) = _CommentAddObject;
}

@freezed
class ProfileDeleteObject with _$ProfileDeleteObject {
  factory ProfileDeleteObject(int secretId) = _ProfileDeleteObject;
}

@freezed
class HomePostObject with _$HomePostObject {
  factory HomePostObject(String language, int page) = _HomePostObject;
}

@freezed
class ProfilePostObject with _$ProfilePostObject {
  factory ProfilePostObject(int page) = _ProfilePostObject;
}

@freezed
class CommentPostObject with _$CommentPostObject {
  factory CommentPostObject(int secretId,String language,int page) = _CommentPostObject;
}
@freezed
class CommentDeleteObject with _$CommentDeleteObject {
  factory CommentDeleteObject(int secretId,int commentId) = _CommentDeleteObject;
}
@freezed
class CommentSecretObject with _$CommentSecretObject {
  factory CommentSecretObject(int id,
  String title,
  String content,
  String date,
  String sign,
  int viewCount,
  String language,
  int commentCount) = _CommentSecretObject;
}