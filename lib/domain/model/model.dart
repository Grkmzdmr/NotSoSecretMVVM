import 'package:not_so_secret/data/responses/responses.dart';

class SliderObject {
  String title;
  String subTitle;
  String image;

  SliderObject(this.title, this.subTitle, this.image);
}

class UserData {
  int id;
  String sign;
  String token;
  UserData(this.id, this.sign, this.token);
}

class Base {
  String data;
  bool success;
  Base(this.data, this.success);
}

class Authentication {
  UserData? userData;

  Authentication(this.userData);
}

class DeviceInfo {
  String name;
  String identifier;
  String version;
  DeviceInfo(this.name, this.identifier, this.version);
}

class Post {
  int id;
  String title;
  String content;
  String date;
  String sign;
  int viewCount;
  String language;
  int commentCount;

  Post(this.content, this.date, this.id, this.language, this.sign, this.title,
      this.viewCount, this.commentCount);
}

class Comment {
  int id;
  String sign;
  int secretId;
  String data;
  int userId;
  String date;

  Comment(this.id, this.date, this.sign, this.data, this.secretId, this.userId);
}

class CommentData {
  int currentPage;
  int totalPage;
  List<Comment> comments;

  CommentData(this.comments, this.currentPage, this.totalPage);
}

class CommentObject {
  CommentData data;
  CommentObject(this.data);
}

class HomeData {
  int currentPage;
  int totalPage;
  List<Post> posts;

  HomeData(this.posts, this.currentPage, this.totalPage);
}

class HomeObject {
  HomeData data;
  HomeObject(this.data);
}

class UserInfo {
  int secretCount;
  int commentCount;
  UserInfo(this.commentCount, this.secretCount);
}

class ProfileUserInfo {
  UserInfo userInfo;

  ProfileUserInfo(this.userInfo);
}

class ProfileUserInfoObject {
  ProfileUserInfo data;

  ProfileUserInfoObject(this.data);
}

class ProfileData {
  List<Post> posts;
  UserData userData;

  ProfileData(this.posts, this.userData);
}

class ProfileObject {
  ProfileData data;
  ProfileObject(this.data);
}
