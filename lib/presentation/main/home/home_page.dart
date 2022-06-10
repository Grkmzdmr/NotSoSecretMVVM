import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:like_button/like_button.dart';
import 'package:not_so_secret/app/app_prefs.dart';
import 'package:not_so_secret/app/di.dart';
import 'package:not_so_secret/data/data_source/local_data_source.dart';
import 'package:not_so_secret/domain/model/model.dart';
import 'package:not_so_secret/presentation/comment/comment_viewmodel.dart';
import 'package:not_so_secret/presentation/common/state_renderer/state_render_impl.dart';

import 'package:not_so_secret/presentation/main/home/home_viewmodel.dart';
import 'package:not_so_secret/presentation/resources/color_manager.dart';
import 'package:not_so_secret/presentation/resources/routes_manager.dart';
import 'package:not_so_secret/presentation/resources/strings_manager.dart';
import 'package:not_so_secret/presentation/resources/values_manager.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:easy_localization/easy_localization.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  int currentPage = 1;
  late List<Post>? post = [];
  late int totalPage;
  HomeViewModel _viewModel = instance<HomeViewModel>();
  AppPreferences _appPreferences = instance<AppPreferences>();
  LocalDataSource _localDataSource = instance<LocalDataSource>();

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
    /*_viewModel.isPostSuccessfullySendController.stream.listen((isPostSend) {
      SchedulerBinding.instance?.addPostFrameCallback((_) {
        Navigator.of(context).pushNamed(Routes.commentRoute);
      });
    });*/
  }

  @override
  void dispose() {
    _viewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: StreamBuilder<FlowState>(
      stream: _viewModel.outputState,
      builder: (context, snapshot) {
        return snapshot.data?.getScreenWidget(context, _getContentWidgets(),
                () {
              _viewModel.start();
            }) ??
            Container();
      },
    ));
  }

  Widget _getContentWidgets() {
    return _getPost();
  }

  /*Widget _getPostsTitle(String title) {
    return Padding(
      padding: EdgeInsets.only(
          top: AppPadding.p12,
          right: AppPadding.p12,
          left: AppPadding.p12,
          bottom: AppPadding.p2),
      child: Text(
        title,
        style: Theme.of(context).textTheme.headline2,
      ),
    );
  }*/

  Widget _getPost() {
    return StreamBuilder<List<Post>>(
        stream: _viewModel.outputPosts,
        builder: (context, snapshot) {
          if (snapshot.data != null) {
            post?.addAll(snapshot.data!);
          } else {}

          return _getPostWidget(post);
        });
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
                    _localDataSource.clearCache();
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
                      _viewModel.getOtherPosts();

                      _refreshController.loadComplete();
                    } else if (currentPage == totalPage) {
                      _refreshController.loadNoData();
                    }
                    _localDataSource.clearCache();
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
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(
                                              AppMargin.m8),
                                          child: SizedBox(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                AppSize.s2,
                                            child: Container(
                                              margin:
                                                  EdgeInsets.all(AppMargin.m8),
                                              child: Text(
                                                  posts[index].title.toString(),
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .headline1),
                                            ),
                                          ),
                                        ),
                                        Container(
                                            child: Text(
                                          posts[index].date.substring(8, 10) +
                                              '-' +
                                              posts[index]
                                                  .date
                                                  .substring(5, 7) +
                                              '-' +
                                              posts[index]
                                                  .date
                                                  .substring(0, 4) +
                                              ' ' +
                                              posts[index]
                                                  .date
                                                  .substring(11, 16),
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyText2,
                                        ))
                                      ],
                                    ),
                                  ],
                                ),
                                Container(
                                    margin: EdgeInsets.all(AppMargin.m8),
                                    child: Padding(
                                      padding:
                                          const EdgeInsets.all(AppMargin.m10),
                                      child: Text(
                                        posts[index].content,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText2,
                                      ),
                                    )),
                                SizedBox(
                                  height: AppSize.s10,
                                ),
                                Row(
                                  children: [
                                    Padding(
                                      padding:
                                          const EdgeInsets.all(AppMargin.m8),
                                      child: SizedBox(
                                        child: Row(
                                          children: [
                                            Container(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width /
                                                    AppSize.s8,
                                                child: Icon(Icons.visibility)),
                                            Container(
                                              child: Text(posts[index]
                                                  .viewCount
                                                  .toString()),
                                            ),
                                            Container(
                                              child: IconButton(
                                                icon: Icon(Icons.comment),
                                                onPressed: () {
                                                  _appPreferences
                                                      .setPost(posts[index].id);

                                                  Navigator.pushNamed(
                                                      context, "/comment",
                                                      arguments: posts[index]);
                                                },
                                              ),
                                            ),
                                            Container(
                                              child: Text(posts[index]
                                                  .commentCount
                                                  .toString()),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: AppSize.s130,
                                    ),
                                    Expanded(
                                      child: Container(
                                        child: Center(
                                          child: Text(
                                            "@" + posts[index].sign,
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyText1,
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),
                        );
                      })),
            ),
          ],
        ),
      );
    } else {
      return Container();
    }
  }
}
