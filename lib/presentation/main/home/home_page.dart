import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

import 'package:not_so_secret/app/app_prefs.dart';
import 'package:not_so_secret/app/di.dart';
import 'package:not_so_secret/data/data_source/local_data_source.dart';
import 'package:not_so_secret/domain/model/model.dart';

import 'package:not_so_secret/presentation/common/state_renderer/state_render_impl.dart';

import 'package:not_so_secret/presentation/main/home/home_viewmodel.dart';
import 'package:not_so_secret/presentation/resources/color_manager.dart';
import 'package:not_so_secret/presentation/resources/font_manager.dart';

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
              child: SmartRefresher(
                  controller: _refreshController,
                  header: WaterDropHeader(),
                  footer: homePageRefresherFooter(),
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
                  child: homePageListView(posts)),
            ),
          ],
        ),
      );
    } else {
      return Container();
    }
  }

  CustomFooter homePageRefresherFooter() {
    return CustomFooter(
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
                });
  }

  ListView homePageListView(List<Post> posts) {
    return ListView.builder(
                    itemCount: posts.length,
                    reverse: false,
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onLongPress: (){
                          
                        },
                        onTap: () {
                          _appPreferences.setPost(posts[index].id);

                          Navigator.pushNamed(context, "/comment",
                              arguments: posts[index]);
                        },
                        child: homePageCard(context, posts, index),
                      );
                    });
  }

  Card homePageCard(BuildContext context, List<Post> posts, int index) {
    return Card(
                          elevation: AppSize.s4,
                          shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.circular(AppSize.s12),
                              side: BorderSide(
                                  color: ColorManager.white,
                                  width: AppSize.s1_5)),
                         child: homePageListTile(context, posts, index)
                        );
  }

  ListTile homePageListTile(BuildContext context, List<Post> posts, int index) {
    return ListTile(
                       
                        
                        horizontalTitleGap: AppSize.s6,
                        minVerticalPadding : AppSize.s24,
                        title: listTileTitle(context, posts, index),
                        subtitle: listTileSubtitle(posts, index, context),
                       );
  }

  Padding listTileSubtitle(List<Post> posts, int index, BuildContext context) {
    return Padding(
                        padding: const EdgeInsets.only(top :8.0),
                        child: Column(
                          mainAxisAlignment : MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                 
                 children: [
                            Text(posts[index].content,
                            style: Theme.of(context).textTheme.subtitle1,
                            textAlign: TextAlign.left,
                            ),
                            SizedBox(height: MediaQuery.of(context).size.width/ 10),

                            Padding(
                              padding: const EdgeInsets.only(top :0.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  Container(
                                    width: MediaQuery.of(context).size.width / 2.5,
                                    child: Row(
                                      
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      children: [
                                      
                                        Icon(Icons.visibility,size: AppSize.s30,color: ColorManager.darkGrey,),
                                        Text(posts[index].viewCount.toString(),style: Theme.of(context).textTheme.subtitle2!.copyWith(fontSize: FontSize.s15,),),
                                        Icon(Icons.comment,size: AppSize.s30,color: ColorManager.darkGrey),
                                        Text(posts[index].commentCount.toString(),style: Theme.of(context).textTheme.subtitle2!.copyWith(fontSize: FontSize.s15,))

                                      
                                    ],),
                                  ),
                                  SizedBox(width: MediaQuery.of(context).size.width / 13.8,

                                  ),
                                  Container(
                                    width: MediaQuery.of(context).size.width / 3.1,
                                    child : Column(
                                      
                                      crossAxisAlignment: CrossAxisAlignment.end,
                                      children : [
                                        
                                        Text("@" + posts[index].sign),
                                        Text(posts[index].date.substring(8, 10) +
                                          '-' +
                                          posts[index]
                                              .date
                                              .substring(5, 7) +
                                          '-' +
                                          posts[index]
                                              .date
                                              .substring(2, 4) 
                                          
                                          )


                                      ]
                                    )
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
  }

  Column listTileTitle(BuildContext context, List<Post> posts, int index) {
    return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                              mainAxisAlignment : MainAxisAlignment.end,
                              children: [
                               PopupMenuButton(onSelected: (value) {
                                    if (value.toString() == "/complaint") {
                                      showAlertDialog(context);
                                    } 
                                  }, itemBuilder: (BuildContext bc) {
                                    
                                      return [
                                        PopupMenuItem(
                                          child: Text(AppStrings.complaint.tr(),style: Theme.of(context).textTheme.subtitle1?.copyWith(fontSize: FontSize.s14)),
                                          value: "/complaint",
                                        ),
                                      ];
                                    
                                  })
                                ],
                            ),
                            Padding(
                               padding: const EdgeInsets.only(right: AppMargin.m12,bottom: AppMargin.m8),
                               child: Container(
                                  
                                  child :
                                     Text(
                                     posts[index].title,
                                      style: Theme.of(context).textTheme.subtitle2!.copyWith(fontSize: FontSize.s17)
                                    ),
                                  
                        ),)

                      ],);
  }
 
  showAlertDialog(BuildContext context) {
    
    Widget okButton = TextButton(
        onPressed: () {
          Navigator.of(context).pop();
        },
        child: Text(AppStrings.ok.tr(),style: Theme.of(context).textTheme.subtitle1?.copyWith(color: ColorManager.primary)));

    AlertDialog alert = AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(AppSize.s12))
      ),
      content: Text(AppStrings.complaintText.tr(),style: Theme.of(context).textTheme.subtitle1),
      actions: [okButton],
    );
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return alert;
        });
  }
}
