class LoginRequest {
  String sign;
  String password;
  String imei;
  String deviceType;
  LoginRequest(this.sign, this.password, this.deviceType, this.imei);
}

class RegisterRequest {
  String sign;
  String password;

  RegisterRequest(this.sign, this.password);
}

class PostRequest {
  String title;
  String content;
  String language;
  PostRequest(this.title, this.content, this.language);
}

class HomeRequest {
  String language;
  int page;
  HomeRequest(this.language, this.page);
}

class AddCommentRequest {
  int secretId;
  String data;
  AddCommentRequest(this.secretId, this.data);
}

class CommentRequest {
  int secretId;
  String language;
  int page;
  CommentRequest(this.secretId, this.language, this.page);
}

class DeleteCommentRequest {
  int secretId;
  int commentId;
  DeleteCommentRequest(this.secretId, this.commentId);
}
