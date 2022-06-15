//to convert the response into a non nullable object(model)

import 'package:not_so_secret/app/extensions.dart';
import 'package:not_so_secret/data/responses/responses.dart';
import 'package:not_so_secret/domain/model/model.dart';
import 'package:not_so_secret/presentation/common/freezed_data_classes.dart';

const EMPTY = "";
const ZERO = 0;

extension UserResponseMapper on Data? {
  UserData toDomain() {
    return UserData(this?.id?.orZero() ?? ZERO, this?.name.orEmpty() ?? EMPTY,
        this?.token?.orEmpty() ?? EMPTY);
  }
}

extension AuthenticationResponseMapper on AuthenticationResponse? {
  Authentication toDomain() {
    return Authentication(this?.data?.toDomain());
  }
}

extension CommentDataResponseMapper on CommentDataResponse? {
  CommentObject toDomain() {
    List<Comment> mappedComments =
        (this?.cpageResponse?.data?.map((comment) => comment.toDomain()) ??
                Iterable.empty())
            .cast<Comment>()
            .toList();

    var data = CommentData(mappedComments, this!.cpageResponse!.currentPage,
        this!.cpageResponse!.totalPage);
    return CommentObject(data);
  }
}

extension CommentResponseMapper on CommentResponse? {
  Comment toDomain() {
    return Comment(
        this?.id?.orZero() ?? ZERO,
        this?.date?.orEmpty() ?? EMPTY,
        this?.sign?.orEmpty() ?? EMPTY,
        this?.data?.orEmpty() ?? EMPTY,
        this?.secretId?.orZero() ?? ZERO,
        this?.userId?.orZero() ?? ZERO);
  }
}

extension UserInfoResponseMapper on UserInfoResponse? {
  UserInfo toDomain() {
    return UserInfo(this?.secretCount?.orZero() ?? ZERO,
        this?.commentCount?.orZero() ?? ZERO);
  }
}

extension PostResponseMapper on PostResponse? {
  Post toDomain() {
   
    return Post(
        this?.content?.orEmpty() ?? EMPTY,
        this?.date?.orEmpty() ?? EMPTY,
        this?.id?.orZero() ?? ZERO,
        this?.language?.orEmpty() ?? EMPTY,
        this?.sign?.orEmpty() ?? EMPTY,
        this?.title?.orEmpty() ?? EMPTY,
        this?.viewCount?.orZero() ?? ZERO,
        this?.commentCount?.orZero() ?? ZERO);
  }
}

extension HomeDataResponseMapper on HomeDataResponse? {
  HomeObject toDomain() {
    List<Post> mappedPosts =
        (this?.homeResponse?.data?.map((post) => post.toDomain()) ??
                Iterable.empty())
            .cast<Post>()
            .toList();
    mappedPosts.sort((a, b) => b.date.compareTo(a.date));

    var data = HomeData(mappedPosts, this!.homeResponse!.currentPage,
        this!.homeResponse!.totalPage);
    return HomeObject(data);
  }
}

extension ProfileResponseMapper on ProfileResponse? {
  ProfileObject toDomain() {
    List<Post> mappedPosts =
        (this?.data?.map((post) => post.toDomain()) ?? Iterable.empty())
            .cast<Post>()
            .toList();
    UserData user = UserData(
        this?.user?.data?.id.orZero() ?? ZERO,
        this?.user?.data?.name.orEmpty() ?? EMPTY,
        this?.user?.data?.token.orEmpty() ?? EMPTY);

    var data = ProfileData(mappedPosts, user);
    return ProfileObject(data);
  }
}

extension UserInfoObjectResponseMapper on ProfileUserInfoResponse? {
  ProfileUserInfoObject toDomain() {
    UserInfo userInfo = UserInfo(this?.data?.commentCount?.orZero() ?? ZERO,
        this?.data?.secretCount?.orZero() ?? ZERO);

    var data = ProfileUserInfo(userInfo);
    return ProfileUserInfoObject(data);
  }
}
