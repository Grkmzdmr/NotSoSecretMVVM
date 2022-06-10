import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:not_so_secret/app/app_prefs.dart';
import 'package:not_so_secret/app/di.dart';
import 'package:not_so_secret/domain/model/model.dart';
import 'package:not_so_secret/presentation/comment/comment_viewmodel.dart';
import 'package:not_so_secret/presentation/common/state_renderer/state_render_impl.dart';

import 'package:not_so_secret/presentation/resources/color_manager.dart';
import 'package:not_so_secret/presentation/resources/font_manager.dart';
import 'package:not_so_secret/presentation/resources/routes_manager.dart';
import 'package:not_so_secret/presentation/resources/strings_manager.dart';
import 'package:not_so_secret/presentation/resources/values_manager.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class CommentPage extends StatefulWidget {
  const CommentPage({Key? key}) : super(key: key);

  @override
  State<CommentPage> createState() => _CommentPageState();
}

class _CommentPageState extends State<CommentPage> {
  CommentViewModel _viewModel = instance<CommentViewModel>();
  AppPreferences appPreferences = instance<AppPreferences>();
  TextEditingController _commentController = TextEditingController();
  int currentPage = 1;
  late List<Comment>? comment = [];
  late int totalPage;
  String sign = "";
  static const routeName = '/extractArguments';
  

  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  final _formKey = GlobalKey<FormState>();
  String title1 = "";
  @override
  void initState() {
    _bind();
    
    

    super.initState();
  }

  _bind() async {
    _viewModel.start();
    _commentController.addListener(() {
      _viewModel.setCommentText(_commentController.text);
    });
    _viewModel.isPostSuccessfullySendController.stream.listen((event) {
      _commentController.clear();
    });
    _viewModel.pageController.stream.listen((page) {
      SchedulerBinding.instance?.addPostFrameCallback((_) {
        totalPage = page;
      });
    });

    sign = await appPreferences.getUsername();
  }

  @override
  void dispose() {
    _viewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as Post;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          toolbarHeight: MediaQuery.of(context).size.height / AppSize.s2_5,
          flexibleSpace: Column(
            children: [
              Stack(children: [
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(AppSize.s12),
                      gradient: LinearGradient(
                        colors: [
                          Colors.white,
                          Colors.grey.shade300,
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      )),
                  height: MediaQuery.of(context).size.height / AppSize.s2_4,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Card(
                        elevation: AppSize.s4,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(AppSize.s12),
                            side: BorderSide(
                                color: ColorManager.white,
                                width: AppSize.s1_5)),
                        child: Container(
                          height:
                              MediaQuery.of(context).size.height / AppSize.s2_6,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: AppSize.s12,
                              ),
                              Row(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Padding(
                                        padding:
                                            const EdgeInsets.all(AppMargin.m8),
                                        child: SizedBox(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              AppSize.s2,
                                          child: Container(
                                            margin:
                                                EdgeInsets.all(AppMargin.m8),
                                            child: Text(args.title.toString(),
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .headline1),
                                          ),
                                        ),
                                      ),
                                      Container(
                                          child: Text(
                                        args.date.substring(8, 10) +
                                              '-' +
                                              args
                                                  .date
                                                  .substring(5, 7) +
                                              '-' +
                                              args
                                                  .date
                                                  .substring(0, 4) +
                                              ' ' +
                                              args
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
                                  width: MediaQuery.of(context).size.width,
                                  height: MediaQuery.of(context).size.height /
                                      AppSize.s6_8,
                                  child: Padding(
                                    padding: const EdgeInsets.all(AppMargin.m8),
                                    child: Text(
                                      args.content,
                                      style: TextStyle(fontSize: FontSize.s14),
                                    ),
                                  )),
                              SizedBox(
                                height: AppSize.s40,
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
                                              child: Icon(
                                                Icons.visibility,
                                                size: AppSize.s28,
                                              )),
                                          Container(
                                            child: Text(
                                              args.viewCount.toString(),
                                              style: TextStyle(
                                                  fontSize: FontSize.s16),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: AppSize.s160,
                                  ),
                                  Expanded(
                                    child: Container(
                                      child: Center(
                                        child: Text(
                                          args.sign,
                                          style:
                                              TextStyle(fontSize: FontSize.s15),
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                      )
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
              return snapshot.data
                      ?.getScreenWidget(context, _getContentWidget(), () {
                    _viewModel.start();
                  }) ??
                  Container();
            },
          ),
        ));
  }

  Widget _getContentWidget() {
    return _getComments();
  }

  Widget _getComments() {
    return StreamBuilder<List<Comment>>(
        stream: _viewModel.outputComments,
        builder: (context, snapshot) {
          if (snapshot.data != null) {
            comment?.addAll(snapshot.data!);
          } else {}
          return _getCommentWidget(snapshot.data);
        });
  }

  Widget _getCommentWidget(List<Comment>? data) {
    if (data != null) {
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
                  comment = [];
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

                    appPreferences.setPage(currentPage);
                    _viewModel.getOtherPages();

                    _refreshController.loadComplete();
                  } else if (currentPage == totalPage) {
                    _refreshController.loadNoData();
                  }
                },
                child: ListView(
                  reverse: false,
                  scrollDirection: Axis.vertical,
                  children: data
                      .map((comment) => Card(
                            elevation: AppSize.s4,
                            shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.circular(AppSize.s12),
                                side: BorderSide(
                                    color: ColorManager.white,
                                    width: AppSize.s1_5)),
                            child: Container(
                              height: MediaQuery.of(context).size.height /
                                  AppSize.s6,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        width: MediaQuery.of(context).size.width / AppSize.s1_4,
                                          margin: EdgeInsets.all(AppMargin.m8),
                                          child: Padding(
                                            padding: const EdgeInsets.all(
                                                AppMargin.m10),
                                            child: Text(
                                              comment.data,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyText2,
                                            ),
                                          )),
                                      PopupMenuButton(onSelected: (value) {
                                        if (value.toString() == "/complaint") {
                                          showAlertDialog(context);
                                        } else if (value.toString() ==
                                            "/delete") {
                                          showDeleteAlertDialog(context,
                                              comment.secretId, comment.id);
                                        }
                                      }, itemBuilder: (BuildContext bc) {
                                        if (comment.sign == sign) {
                                          return [
                                            PopupMenuItem(
                                              child: Text("Sil"),
                                              value: "/delete",
                                            )
                                          ];
                                        } else {
                                          return [
                                            PopupMenuItem(
                                              child: Text("Şikayet Et"),
                                              value: "/complaint",
                                            ),
                                          ];
                                        }
                                      })
                                    ],
                                  ),
                                  SizedBox(
                                    height: AppSize.s10,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Padding(
                                        padding:
                                            const EdgeInsets.all(AppMargin.m12),
                                        child: Text(comment.sign),
                                      )
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ))
                      .toList(),
                ),
              ),
            ),
            Align(
                alignment: Alignment.bottomLeft,
                child: Container(
                  padding: EdgeInsets.only(left: 5, bottom: 10, top: 10),
                  height: 70,
                  width: double.infinity,
                  child: Row(
                    children: [
                      SizedBox(
                        width: 15,
                      ),
                      Expanded(
                          child: StreamBuilder<bool>(
                              stream: _viewModel.outputIsCommentValid,
                              builder: (context, snapshot) {
                                return TextFormField(
                                  autofocus: true,
                                  controller: _commentController,
                                  style: Theme.of(context).textTheme.bodyText2,
                                  decoration: InputDecoration(
                                      hintText: AppStrings.comment.tr(),
                                      hintStyle:
                                          Theme.of(context).textTheme.bodyText1,
                                      border: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: ColorManager.primary),
                                          borderRadius: BorderRadius.circular(
                                              AppSize.s24)),
                                      errorText: (snapshot.data ?? false)
                                          ? null
                                          : AppStrings.commentError.tr()),
                                );
                              })),
                      SizedBox(
                        width: AppSize.s10,
                      ),
                      Padding(
                          padding: const EdgeInsets.only(
                              right: AppSize.s8, bottom: AppSize.s2),
                          child: StreamBuilder<bool>(
                            stream: _viewModel.outputIsCommentValid,
                            builder: (context, snapshot) {
                              return FloatingActionButton(
                                onPressed: (snapshot.data ?? true)
                                    ? () {
                                        _viewModel.sendComment();
                                      }
                                    : null,
                                child: Icon(
                                  Icons.send,
                                  color: ColorManager.white,
                                  size: AppSize.s20,
                                ),
                                backgroundColor: ColorManager.primary,
                                elevation: AppSize.s0,
                              );
                            },
                          )),
                    ],
                  ),
                ))
          ],
        ),
      );
    } else {
      return Container();
    }
  }

  showAlertDialog(BuildContext context) {
    Widget okButton = TextButton(
        onPressed: () {
          Navigator.of(context).pop();
        },
        child: Text("Tamam"));

    AlertDialog alert = AlertDialog(
      content: Text("Şikayetiniz incelenecektir."),
      actions: [okButton],
    );
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return alert;
        });
  }

  showDeleteAlertDialog(BuildContext context, int secretId, int commentId) {
    Widget sureButton = new TextButton(
        style: ButtonStyle(
            foregroundColor: MaterialStateProperty.resolveWith(
                (state) => ColorManager.primary)),
        onPressed: () {
          _viewModel.commentDeleteController
              .add(_viewModel.setCommentId(secretId, commentId));

          _viewModel.deleteComment();
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
