import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';
import 'package:not_so_secret/domain/model/model.dart';

part 'responses.g.dart';

@JsonSerializable()
class BaseResponse {
  @JsonKey(name: "exceptions")
  List<String>? exceptions;
  @JsonKey(name: "success")
  bool? success;
}

@JsonSerializable()
class Data {
  @JsonKey(name: "id")
  int? id;
  @JsonKey(name: "sign")
  String? name;
  @JsonKey(name: "token")
  String? token;

  Data(this.id, this.name, this.token);

  //from json
  factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);
//to json
  Map<String, dynamic> toJson() => _$DataToJson(this);
}

@JsonSerializable()
class AuthenticationResponse extends BaseResponse {
  @JsonKey(name: "data")
  Data? data;

  AuthenticationResponse(this.data);
//from json
  factory AuthenticationResponse.fromJson(Map<String, dynamic> json) =>
      _$AuthenticationResponseFromJson(json);
//to json
  Map<String, dynamic> toJson() => _$AuthenticationResponseToJson(this);
}

@JsonSerializable()
class PostResponse extends BaseResponse {
  @JsonKey(name: 'id')
  int? id;
  @JsonKey(name: 'title')
  String? title;
  @JsonKey(name: 'content')
  String? content;
  @JsonKey(name: 'date')
  String? date;
  @JsonKey(name: 'sign')
  String? sign;
  @JsonKey(name: 'commentCount')
  int? commentCount;
  @JsonKey(name: 'viewCount')
  int? viewCount;
  @JsonKey(name: 'language')
  String? language;

  PostResponse(this.content, this.date, this.commentCount, this.id,
      this.language, this.sign, this.title, this.viewCount);

  //from json
  factory PostResponse.fromJson(Map<String, dynamic> json) =>
      _$PostResponseFromJson(json);
//to json
  Map<String, dynamic> toJson() => _$PostResponseToJson(this);
}

@JsonSerializable()
class CommentResponse extends BaseResponse {
  @JsonKey(name: 'id')
  int? id;
  @JsonKey(name: 'sign')
  String? sign;
  @JsonKey(name: 'secretId')
  int? secretId;
  @JsonKey(name: 'userId')
  int? userId;
  @JsonKey(name: 'date')
  String? date;
  @JsonKey(name: 'data')
  String? data;

 
 
  CommentResponse(this.id, this.sign, this.secretId, this.userId, this.date,this.data);
  factory CommentResponse.fromJson(Map<String, dynamic> json) =>
      _$CommentResponseFromJson(json);
//to json
  Map<String, dynamic> toJson() => _$CommentResponseToJson(this);
}

@JsonSerializable()
class CommentPageResponse extends BaseResponse {
   @JsonKey(name: 'currentPage')
  int currentPage;
  @JsonKey(name: 'totalPage')
  int totalPage;
  @JsonKey(name: 'comments')
  List<CommentResponse>? data;


 
 
  CommentPageResponse(this.currentPage, this.totalPage, this.data);
  factory CommentPageResponse.fromJson(Map<String, dynamic> json) =>
      _$CommentPageResponseFromJson(json);
//to json
  Map<String, dynamic> toJson() => _$CommentPageResponseToJson(this);
}
@JsonSerializable()
class CommentDataResponse extends BaseResponse {
  @JsonKey(name: 'data')
  CommentPageResponse? cpageResponse;

  CommentDataResponse(this.cpageResponse);
  factory CommentDataResponse.fromJson(Map<String, dynamic> json) =>
      _$CommentDataResponseFromJson(json);
//to json
  Map<String, dynamic> toJson() => _$CommentDataResponseToJson(this);
}


@JsonSerializable()
class HomeDataResponse extends BaseResponse {
  @JsonKey(name: 'data')
  HomeResponse? homeResponse;

  HomeDataResponse(this.homeResponse);
  factory HomeDataResponse.fromJson(Map<String, dynamic> json) =>
      _$HomeDataResponseFromJson(json);
//to json
  Map<String, dynamic> toJson() => _$HomeDataResponseToJson(this);
}

@JsonSerializable()
class HomeResponse extends BaseResponse {
  @JsonKey(name: 'currentPage')
  int currentPage;
  @JsonKey(name: 'totalPage')
  int totalPage;
  @JsonKey(name: 'secrets')
  List<PostResponse>? data;

  HomeResponse(this.data, this.currentPage, this.totalPage);
  //from json
  factory HomeResponse.fromJson(Map<String, dynamic> json) =>
      _$HomeResponseFromJson(json);
//to json
  Map<String, dynamic> toJson() => _$HomeResponseToJson(this);
}

/*@JsonSerializable()
class ProfileDataResponse {
  @JsonKey(name: '')
  List<PostResponse>? posts;
  @JsonKey(name : '')
  UserData? user;
  ProfileDataResponse(this.posts, this.user);
}*/

@JsonSerializable()
class ProfileResponse extends BaseResponse {
  @JsonKey(name: 'data')
  List<PostResponse>? data;
  @JsonKey(name: '')
  AuthenticationResponse? user;
  ProfileResponse(this.data, this.user);
  //from json
  factory ProfileResponse.fromJson(Map<String, dynamic> json) =>
      _$ProfileResponseFromJson(json);
//to json
  Map<String, dynamic> toJson() => _$ProfileResponseToJson(this);
}
