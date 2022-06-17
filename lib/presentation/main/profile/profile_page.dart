import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:not_so_secret/app/app_prefs.dart';
import 'package:not_so_secret/app/di.dart';
import 'package:not_so_secret/domain/model/model.dart';
import 'package:not_so_secret/presentation/common/state_renderer/state_render_impl.dart';

import 'package:not_so_secret/presentation/main/profile/profile_viewmodel.dart';
import 'package:not_so_secret/presentation/resources/color_manager.dart';
import 'package:not_so_secret/presentation/resources/font_manager.dart';
import 'package:not_so_secret/presentation/resources/strings_manager.dart';
import 'package:not_so_secret/presentation/resources/values_manager.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:easy_localization/easy_localization.dart';

class ProfilePageTest extends StatefulWidget {
  const ProfilePageTest({Key? key}) : super(key: key);

  @override
  State<ProfilePageTest> createState() => _ProfilePageTestState();
}

class _ProfilePageTestState extends State<ProfilePageTest> {
  ProfileViewModel _viewModel = instance<ProfileViewModel>();
  AppPreferences _appPreferences = instance<AppPreferences>();
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  int currentPage = 1;
  late List<Post>? post = [];
  late int totalPage;
  @override
  void initState() {
    _bind();
    super.initState();
  }

  _bind() {
    _viewModel.start();
    _viewModel.pageController.stream.listen((page) {
      SchedulerBinding.instance?.addPostFrameCallback((_) {
        totalPage = page;
      });
    });
  }

  @override
  void dispose() {
    _viewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return [
            SliverAppBar(
                floating: true,
                snap: true,
                expandedHeight: MediaQuery.of(context).size.height / 3.1,
                flexibleSpace: Container(
                    color: ColorManager.white, child: _getUpContentWidget()))
          ];
        },
        body: Container(
            child: StreamBuilder<FlowState>(
          stream: _viewModel.outputState,
          builder: (context, snapshot) {
            return snapshot.data?.getScreenWidget(context, _getContentWidget(),
                    () {
                  _viewModel.start();
                }) ??
                Container();
          },
        )),
      ),
    );
  }

  Widget _getUpContentWidget() {
    return _getUserInfo();
  }

  Widget _getUserInfo() {
    return StreamBuilder<UserInfo>(
        stream: _viewModel.outputUserInfo,
        builder: (context, snapshot) {
          return _getUserInfoWidget(snapshot.data);
        });
  }

  Widget _getUserInfoWidget(UserInfo? user) {
    if (user != null) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Spacer(flex: 3),
          Expanded(
            flex: 24,
            child: ClipRRect(
                borderRadius: BorderRadius.circular(AppSize.s48),
                child: Text(
                  "?",
                  style: TextStyle(
                      color: ColorManager.primary, fontSize: AppSize.s60),
                )),
          ),
          Spacer(),
          StreamBuilder<String>(
              stream: _viewModel.outputPersonsUsername,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Expanded(
                      flex: 8,
                      child: Text("@" + snapshot.data.toString(),
                          style: Theme.of(context).textTheme.bodyText2));
                } else {
                  return Container();
                }
              }),
          Spacer(flex: 2),
          Expanded(
            flex: 25,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                  flex: 10,
                  child: Column(children: [
                    Expanded(
                        child: Text(AppStrings.countSecret.tr(),
                            style: Theme.of(context).textTheme.headline4)),
                    Expanded(
                        child: Text(user.secretCount.toString(),
                            style: Theme.of(context).textTheme.bodyText2)),
                    Spacer(),
                  ]),
                ),
                Expanded(
                  flex: 10,
                  child: Column(
                    children: [
                      Expanded(
                          child: Text(AppStrings.countComment.tr(),
                              style: Theme.of(context).textTheme.headline4)),
                      Expanded(
                          child: Text(user.commentCount.toString(),
                              style: Theme.of(context).textTheme.bodyText2)),
                      Spacer()
                    ],
                  ),
                ),
                Spacer()
              ],
            ),
          ),
          Expanded(
            flex: 8,
            child: Text(AppStrings.sharedSecrets.tr()),
          ),
          Spacer(flex: 3)
        ],
      );
    } else {
      return Container();
    }
  }

  Widget _getContentWidget() {
    return _getPost();
  }

  Widget _getPost() {
    return StreamBuilder<List<Post>>(
      stream: _viewModel.outputPersonsPosts,
      builder: (context, snapshot) {
        return _getPostWidget(snapshot.data);
      },
    );
  }

  Widget _getPostWidget(List<Post>? posts) {
    if (posts != null) {
      return Padding(
        padding: EdgeInsets.only(left: AppPadding.p12, right: AppPadding.p12),
        child: Column(
          children: [
            Expanded(
              //height: MediaQuery.of(context).size.height,
              //margin: EdgeInsets.symmetric(vertical: AppMargin.m12),

              child: SmartRefresher(
                controller: _refreshController,
                header: WaterDropHeader(),
                footer: CustomFooter(
                    builder: (BuildContext context, LoadStatus? mode) {
                  Widget body;
                  if (mode == LoadStatus.idle) {
                    body = Text(AppStrings.loading.tr());
                  } else if (mode == LoadStatus.loading) {
                    body = CupertinoActivityIndicator();
                  } else if (mode == LoadStatus.failed) {
                    body = Text(AppStrings.failed.tr());
                  } else if (mode == LoadStatus.canLoading) {
                    body = Text(AppStrings.release.tr());
                  } else {
                    body = Text(AppStrings.noMoreSecret.tr());
                  }
                  return Container(
                    height: 55.0,
                    child: Center(child: body),
                  );
                }),
                enablePullDown: true,
                enablePullUp: true,
                onRefresh: () {
                  post = [];
                  currentPage = 1;
                  resetHomeModule();
                  _viewModel.refresh();
                  initHomeModule();
                  initProfileModule();
                  initCommentModule();
                  _refreshController.refreshCompleted();
                },
                onLoading: () async {
                  await Future.delayed(Duration(seconds: 1));
                  if (currentPage < totalPage) {
                    currentPage++;

                    _appPreferences.setPage(currentPage);
                    _viewModel.getOtherPages();

                    _refreshController.loadComplete();
                  } else if (currentPage == totalPage) {
                    _refreshController.loadNoData();
                  }
                },
                child: ListView.builder(
                    itemCount: posts.length,
                    reverse: false,
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    itemBuilder: (context, index) {
                      return InkWell(
                          onTap: () {
                            _appPreferences.setPost(posts[index].id);

                            Navigator.pushNamed(context, "/comment",
                                arguments: posts[index]);
                          },
                          child: Card(
                              elevation: AppSize.s4,
                              shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.circular(AppSize.s12),
                                  side: BorderSide(
                                      color: ColorManager.white,
                                      width: AppSize.s1_5)),
                              child: ListTile(
                                trailing: IconButton(
                                  icon: Icon(Icons.delete),
                                  onPressed: () {
                                    showAlertDialog(context, posts[index].id);
                                  },
                                ),
                                horizontalTitleGap: 6,
                                minVerticalPadding: 24,
                                //trailing : IconButton(icon: Icon(Icons.more_vert),onPressed: (){},),
                                title: Text(posts[index].title,
                                    style: Theme.of(context)
                                        .textTheme
                                        .subtitle2!
                                        .copyWith(fontSize: FontSize.s17)),

                                subtitle: Padding(
                                  padding: const EdgeInsets.only(top: 8.0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        posts[index].content,
                                        style: Theme.of(context)
                                            .textTheme
                                            .subtitle1,
                                        textAlign: TextAlign.left,
                                      ),
                                      Padding(
                                          padding:
                                              const EdgeInsets.only(top: 16.0),
                                          child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                Container(
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width /
                                                      2.5,
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceEvenly,
                                                    children: [
                                                      Icon(
                                                        Icons.visibility,
                                                        size: AppSize.s30,
                                                      ),
                                                      Text(
                                                        posts[index]
                                                            .viewCount
                                                            .toString(),
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .subtitle2!
                                                            .copyWith(
                                                              fontSize:
                                                                  FontSize.s15,
                                                            ),
                                                      ),
                                                      Icon(Icons.comment,
                                                          size: AppSize.s30),
                                                      Text(
                                                          posts[index]
                                                              .commentCount
                                                              .toString(),
                                                          style:
                                                              Theme.of(context)
                                                                  .textTheme
                                                                  .subtitle2!
                                                                  .copyWith(
                                                                    fontSize:
                                                                        FontSize
                                                                            .s15,
                                                                  ))
                                                    ],
                                                  ),
                                                ),
                                              ])),
                                    ],
                                  ),
                                ),
                              )));
                    }),
              ),
            ),
          ],
        ),
      );
    } else {
      return Container();
    }
  }

  showAlertDialog(BuildContext context, int secretId) {
    Widget sureButton = new TextButton(
        style: ButtonStyle(
            foregroundColor: MaterialStateProperty.resolveWith(
                (state) => ColorManager.primary)),
        onPressed: () {
          _viewModel.setSecretId(secretId);
          _viewModel.deleteSecret();
        },
        child: Text(AppStrings.yes.tr(),
            style: Theme.of(context).textTheme.bodyText2));
    Widget notsureButton = new TextButton(
        style: ButtonStyle(
            foregroundColor: MaterialStateProperty.resolveWith(
                (state) => ColorManager.primary)),
        onPressed: () {
          Navigator.pop(context);
        },
        child: Text(
          AppStrings.no.tr(),
          style: Theme.of(context).textTheme.bodyText2,
        ));

    AlertDialog alertDialog = AlertDialog(
      titlePadding: EdgeInsets.only(left: AppSize.s30, top: AppSize.s20),
      scrollable: true,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(AppSize.s24))),
      title: Text(
        AppStrings.delete.tr(),
        style: Theme.of(context).textTheme.headline1,
      ),
      content: Text(
        AppStrings.sure.tr(),
        style: Theme.of(context).textTheme.bodyText2,
      ),
      actions: [sureButton, notsureButton],
    );
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return alertDialog;
        });
  }
}






  