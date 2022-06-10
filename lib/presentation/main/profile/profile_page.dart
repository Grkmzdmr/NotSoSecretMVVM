import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:not_so_secret/app/app_prefs.dart';
import 'package:not_so_secret/app/di.dart';
import 'package:not_so_secret/data/network/dio_factory.dart';
import 'package:not_so_secret/domain/model/model.dart';
import 'package:not_so_secret/presentation/common/state_renderer/state_render_impl.dart';
import 'package:not_so_secret/presentation/main/profile/profile_viewmodel.dart';
import 'package:not_so_secret/presentation/resources/color_manager.dart';
import 'package:not_so_secret/presentation/resources/strings_manager.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:not_so_secret/presentation/resources/values_manager.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class PersonPage extends StatefulWidget {
  const PersonPage({Key? key}) : super(key: key);

  @override
  State<PersonPage> createState() => _PersonPageState();
}

class _PersonPageState extends State<PersonPage> {
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

  showAlertDialog(BuildContext context, int secretId) {
    Widget sureButton = new TextButton(
        style: ButtonStyle(
            foregroundColor: MaterialStateProperty.resolveWith(
                (state) => ColorManager.primary)),
        onPressed: () {
          _viewModel.postsdeleteController
              .add(_viewModel.setSecretId(secretId));
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          toolbarHeight: MediaQuery.of(context).size.height / AppSize.s3_5,
          flexibleSpace: Column(
            children: [
              Stack(children: [
                Container(
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                    colors: [
                      Colors.white,
                      Colors.grey.shade300,
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  )),
                  height: MediaQuery.of(context).size.height / AppSize.s3_6,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ClipRRect(
                              borderRadius: BorderRadius.circular(AppSize.s48),
                              child: Text(
                                "?",
                                style: TextStyle(
                                    color: ColorManager.primary,
                                    fontSize: AppSize.s60),
                              )),
                        ],
                      ),
                      StreamBuilder<String>(
                          stream: _viewModel.outputPersonsUsername,
                          builder: (context, snapshot) {
                            return Container(
                                width: MediaQuery.of(context).size.width /
                                    AppSize.s2,
                                child: Center(
                                    child: Text(
                                  "@" + snapshot.data.toString(),
                                  style: Theme.of(context).textTheme.bodyText2,
                                )));
                          })
                    ],
                  ),
                ),
              ]),
              /*SizedBox(
                height: 18,
              ),*/
              /*Text(
                "Önceki Paylaşımlarım",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
              ),
              SizedBox(
                height: 10,
              ),*/
            ],
          ),
        ),
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
        )));
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
                        onTap : () {
                            _appPreferences.setPost(posts[index].id);
                            

                            Navigator.pushNamed(context, "/comment",arguments: posts[index]);
                          },
                        child: Card(
                          elevation: AppSize.s4,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(AppSize.s12),
                              side: BorderSide(
                                  color: ColorManager.white,
                                  width: AppSize.s1_5)),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(AppMargin.m8),
                                    child: SizedBox(
                                      width: MediaQuery.of(context).size.width /
                                          AppSize.s2_2,
                                      child: Container(
                                        margin: EdgeInsets.all(AppMargin.m8),
                                        child: Text(posts[index].title.toString(),
                                            style: Theme.of(context)
                                                .textTheme
                                                .headline1),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(AppMargin.m8),
                                    child: StreamBuilder<Object>(
                                        builder: (context, snapshot) {
                                      return Container(
                                          width: AppSize.s40,
                                          child: IconButton(
                                              onPressed: () {
                                                /*_viewModel
                                                        .postsdeleteController
                                                        .add(_viewModel
                                                            .setSecretId(
                                                                post.id));
                                                    
                                                    _viewModel.deleteSecret();*/
                                                showAlertDialog(context, posts[index].id);
                                              },
                                              icon: Icon(
                                                Icons.delete,
                                              )));
                                    }),
                                  )
                                ],
                              ),
                              Container(
                                  margin: EdgeInsets.all(AppMargin.m8),
                                  child: Padding(
                                    padding: const EdgeInsets.all(AppMargin.m10),
                                    child: Text(
                                      posts[index].content,
                                      style:
                                          Theme.of(context).textTheme.bodyText2,
                                    ),
                                  )),
                              SizedBox(
                                height: AppSize.s10,
                              ),
                              Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(AppMargin.m8),
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
                                            child:
                                                Text(posts[index].viewCount.toString()),
                                          ),
                                          Container(
                                            child: IconButton(
                                              icon: Icon(Icons.comment),
                                              onPressed: () {},
                                            ),
                                          ),
                                          Container(
                                            child: Text(
                                                posts[index].commentCount.toString()),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: AppSize.s160,
                                  ),
                                  /*Expanded(
                                        child: Container(
                                          child: Center(
                                            child: Text("@"+
                                              post.sign,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyText1,
                                            ),
                                          ),
                                        ),
                                      )*/
                                ],
                              )
                            ],
                          ),
                        ),
                      );
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
}
