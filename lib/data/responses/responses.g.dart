// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'responses.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BaseResponse _$BaseResponseFromJson(Map<String, dynamic> json) {
  return BaseResponse()
    ..exceptions =
        (json['exceptions'] as List<dynamic>?)?.map((e) => e as String).toList()
    ..success = json['success'] as bool?;
}

Map<String, dynamic> _$BaseResponseToJson(BaseResponse instance) =>
    <String, dynamic>{
      'exceptions': instance.exceptions,
      'success': instance.success,
    };

Data _$DataFromJson(Map<String, dynamic> json) {
  return Data(
    json['id'] as int?,
    json['sign'] as String?,
    json['token'] as String?,
  );
}

Map<String, dynamic> _$DataToJson(Data instance) => <String, dynamic>{
      'id': instance.id,
      'sign': instance.name,
      'token': instance.token,
    };

AuthenticationResponse _$AuthenticationResponseFromJson(
    Map<String, dynamic> json) {
  return AuthenticationResponse(
    json['data'] == null
        ? null
        : Data.fromJson(json['data'] as Map<String, dynamic>),
  )
    ..exceptions =
        (json['exceptions'] as List<dynamic>?)?.map((e) => e as String).toList()
    ..success = json['success'] as bool?;
}

Map<String, dynamic> _$AuthenticationResponseToJson(
        AuthenticationResponse instance) =>
    <String, dynamic>{
      'exceptions': instance.exceptions,
      'success': instance.success,
      'data': instance.data,
    };

PostResponse _$PostResponseFromJson(Map<String, dynamic> json) {
  return PostResponse(
    json['content'] as String?,
    json['date'] as String?,
    json['commentCount'] as int?,
    json['id'] as int?,
    json['language'] as String?,
    json['sign'] as String?,
    json['title'] as String?,
    json['viewCount'] as int?,
  )
    ..exceptions =
        (json['exceptions'] as List<dynamic>?)?.map((e) => e as String).toList()
    ..success = json['success'] as bool?;
}

Map<String, dynamic> _$PostResponseToJson(PostResponse instance) =>
    <String, dynamic>{
      'exceptions': instance.exceptions,
      'success': instance.success,
      'id': instance.id,
      'title': instance.title,
      'content': instance.content,
      'date': instance.date,
      'sign': instance.sign,
      'commentCount': instance.commentCount,
      'viewCount': instance.viewCount,
      'language': instance.language,
    };

CommentResponse _$CommentResponseFromJson(Map<String, dynamic> json) {
  return CommentResponse(
    json['id'] as int?,
    json['sign'] as String?,
    json['secretId'] as int?,
    json['userId'] as int?,
    json['date'] as String?,
    json['data'] as String?,
  )
    ..exceptions =
        (json['exceptions'] as List<dynamic>?)?.map((e) => e as String).toList()
    ..success = json['success'] as bool?;
}

Map<String, dynamic> _$CommentResponseToJson(CommentResponse instance) =>
    <String, dynamic>{
      'exceptions': instance.exceptions,
      'success': instance.success,
      'id': instance.id,
      'sign': instance.sign,
      'secretId': instance.secretId,
      'userId': instance.userId,
      'date': instance.date,
      'data': instance.data,
    };

UserInfoResponse _$UserInfoResponseFromJson(Map<String, dynamic> json) {
  return UserInfoResponse(
    json['commentCount'] as int?,
    json['secretCount'] as int?,
  )
    ..exceptions =
        (json['exceptions'] as List<dynamic>?)?.map((e) => e as String).toList()
    ..success = json['success'] as bool?;
}

Map<String, dynamic> _$UserInfoResponseToJson(UserInfoResponse instance) =>
    <String, dynamic>{
      'exceptions': instance.exceptions,
      'success': instance.success,
      'secretCount': instance.secretCount,
      'commentCount': instance.commentCount,
    };

CommentPageResponse _$CommentPageResponseFromJson(Map<String, dynamic> json) {
  return CommentPageResponse(
    json['currentPage'] as int,
    json['totalPage'] as int,
    (json['comments'] as List<dynamic>?)
        ?.map((e) => CommentResponse.fromJson(e as Map<String, dynamic>))
        .toList(),
  )
    ..exceptions =
        (json['exceptions'] as List<dynamic>?)?.map((e) => e as String).toList()
    ..success = json['success'] as bool?;
}

Map<String, dynamic> _$CommentPageResponseToJson(
        CommentPageResponse instance) =>
    <String, dynamic>{
      'exceptions': instance.exceptions,
      'success': instance.success,
      'currentPage': instance.currentPage,
      'totalPage': instance.totalPage,
      'comments': instance.data,
    };

CommentDataResponse _$CommentDataResponseFromJson(Map<String, dynamic> json) {
  return CommentDataResponse(
    json['data'] == null
        ? null
        : CommentPageResponse.fromJson(json['data'] as Map<String, dynamic>),
  )
    ..exceptions =
        (json['exceptions'] as List<dynamic>?)?.map((e) => e as String).toList()
    ..success = json['success'] as bool?;
}

Map<String, dynamic> _$CommentDataResponseToJson(
        CommentDataResponse instance) =>
    <String, dynamic>{
      'exceptions': instance.exceptions,
      'success': instance.success,
      'data': instance.cpageResponse,
    };

HomeDataResponse _$HomeDataResponseFromJson(Map<String, dynamic> json) {
  return HomeDataResponse(
    json['data'] == null
        ? null
        : HomeResponse.fromJson(json['data'] as Map<String, dynamic>),
  )
    ..exceptions =
        (json['exceptions'] as List<dynamic>?)?.map((e) => e as String).toList()
    ..success = json['success'] as bool?;
}

Map<String, dynamic> _$HomeDataResponseToJson(HomeDataResponse instance) =>
    <String, dynamic>{
      'exceptions': instance.exceptions,
      'success': instance.success,
      'data': instance.homeResponse,
    };

HomeResponse _$HomeResponseFromJson(Map<String, dynamic> json) {
  return HomeResponse(
    (json['secrets'] as List<dynamic>?)
        ?.map((e) => PostResponse.fromJson(e as Map<String, dynamic>))
        .toList(),
    json['currentPage'] as int,
    json['totalPage'] as int,
  )
    ..exceptions =
        (json['exceptions'] as List<dynamic>?)?.map((e) => e as String).toList()
    ..success = json['success'] as bool?;
}

Map<String, dynamic> _$HomeResponseToJson(HomeResponse instance) =>
    <String, dynamic>{
      'exceptions': instance.exceptions,
      'success': instance.success,
      'currentPage': instance.currentPage,
      'totalPage': instance.totalPage,
      'secrets': instance.data,
    };

ProfileResponse _$ProfileResponseFromJson(Map<String, dynamic> json) {
  return ProfileResponse(
    (json['data'] as List<dynamic>?)
        ?.map((e) => PostResponse.fromJson(e as Map<String, dynamic>))
        .toList(),
    json[''] == null
        ? null
        : AuthenticationResponse.fromJson(json[''] as Map<String, dynamic>),
  )
    ..exceptions =
        (json['exceptions'] as List<dynamic>?)?.map((e) => e as String).toList()
    ..success = json['success'] as bool?;
}

Map<String, dynamic> _$ProfileResponseToJson(ProfileResponse instance) =>
    <String, dynamic>{
      'exceptions': instance.exceptions,
      'success': instance.success,
      'data': instance.data,
      '': instance.user,
    };

ProfileUserInfoResponse _$ProfileUserInfoResponseFromJson(
    Map<String, dynamic> json) {
  return ProfileUserInfoResponse(
    json['data'] == null
        ? null
        : UserInfoResponse.fromJson(json['data'] as Map<String, dynamic>),
  )
    ..exceptions =
        (json['exceptions'] as List<dynamic>?)?.map((e) => e as String).toList()
    ..success = json['success'] as bool?;
}

Map<String, dynamic> _$ProfileUserInfoResponseToJson(
        ProfileUserInfoResponse instance) =>
    <String, dynamic>{
      'exceptions': instance.exceptions,
      'success': instance.success,
      'data': instance.data,
    };
