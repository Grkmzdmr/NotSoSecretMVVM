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
import 'package:not_so_secret/presentation/resources/strings_manager.dart';
import 'package:not_so_secret/presentation/resources/values_manager.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:easy_localization/easy_localization.dart';

class CommentTest extends StatefulWidget {
  const CommentTest({Key? key}) : super(key: key);

  @override
  State<CommentTest> createState() => _CommentTestState();
}

class _CommentTestState extends State<CommentTest> {
  CommentViewModel _viewModel = instance<CommentViewModel>();
  late List<Comment>? comments = [];
  AppPreferences appPreferences = instance<AppPreferences>();
  TextEditingController _commentController = TextEditingController();
  late int totalPage;
  String sign = "";

  int currentPage = 1;
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

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
      SchedulerBinding.instance.addPostFrameCallback((_) {
        totalPage = page;
      });
    });

    sign = await appPreferences.getUsername();
  }

  @override
  void dispose() {
    _viewModel.dispose();
    _commentController.dispose();
    _refreshController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //final args = ModalRoute.of(context)!.settings.arguments as Post;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          AppStrings.commentAppBar.tr(),
          style: Theme.of(context).textTheme.headline2?.copyWith(color: ColorManager.primary),
        ),
      ),
      body: Container(
        child: StreamBuilder<FlowState>(
          stream: _viewModel.outputState,
          builder: (context, snapshot) {
            return snapshot.data
                    ?.getScreenWidget(context, _getContentWidget(), () {}) ??
                Container();
          },
        ),
      ),
    );
  }

  Widget _getContentWidget() {
    return _getComments();
  }

  Widget _getComments() {
    return StreamBuilder<List<Comment>>(
        stream: _viewModel.outputComments,
        builder: (context, snapshot) {
          if (snapshot.data != null) {
            comments?.addAll(snapshot.data!);
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
                child: commentSmartRefresher(data)),
            Align(
                alignment: Alignment.bottomLeft,
                child: Container(
                  padding: EdgeInsets.only(left: 5, bottom: 10, top: 10),
                  height: MediaQuery.of(context).size.height / 10.5,
                  width: double.infinity,
                  child: Row(
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width / 27.6,
                      ),
                      Expanded(
                          child: StreamBuilder<bool>(
                              stream: _viewModel.outputIsCommentValid,
                              builder: (context, snapshot) {
                                return TextFormField(
                                  autofocus: false,
                                  controller: _commentController,
                                  style: Theme.of(context).textTheme.bodyText2,
                                  maxLength: 500,
                                  decoration: InputDecoration(
                                    hintText: AppStrings.comment.tr(),
                                    hintStyle:
                                        Theme.of(context).textTheme.bodyText1,
                                    border: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: ColorManager.primary),
                                        borderRadius:
                                            BorderRadius.circular(AppSize.s24)),
                                    //errorText: (snapshot.data ?? false)
                                    //  ? null
                                    //: AppStrings.commentError.tr()
                                  ),
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
        child: Text(AppStrings.ok.tr(),
            style: Theme.of(context)
                .textTheme
                .subtitle1
                ?.copyWith(color: ColorManager.primary)));

    AlertDialog alert = AlertDialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(AppSize.s12))),
      content: Text(AppStrings.complaintText.tr(),
          style: Theme.of(context).textTheme.subtitle1),
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
          _viewModel.setCommentId(secretId, commentId);   
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

  Widget commentSmartRefresher(List<Comment>? data) {
    return SmartRefresher(
      controller: _refreshController,
      header: WaterDropHeader(),
      footer: CustomFooter(builder: (BuildContext context, LoadStatus? mode) {
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
        comments = [];
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
        children: data!.map((comment) => commentCard(comment)).toList(),
      ),
    );
  }

  Widget commentCard(Comment comment) {
    return Card(
      elevation: AppSize.s4,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSize.s12),
          side: BorderSide(color: ColorManager.white, width: AppSize.s1_5)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              PopupMenuButton(onSelected: (value) {
                if (value.toString() == "/complaint") {
                  showAlertDialog(context);
                } else if (value.toString() == "/delete") {
                  showDeleteAlertDialog(context, comment.secretId, comment.id);
                }
              }, itemBuilder: (BuildContext bc) {
                if (comment.sign == sign) {
                  return [
                    PopupMenuItem(
                      child: Text(
                        AppStrings.delete.tr(),
                        style: Theme.of(context)
                            .textTheme
                            .subtitle1
                            ?.copyWith(fontSize: FontSize.s14),
                      ),
                      value: "/delete",
                    )
                  ];
                } else {
                  return [
                    PopupMenuItem(
                      child: Text(AppStrings.complaint.tr(),
                          style: Theme.of(context)
                              .textTheme
                              .subtitle1
                              ?.copyWith(fontSize: FontSize.s14)),
                      value: "/complaint",
                    ),
                  ];
                }
              })
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(
                top: 2,
                left: AppMargin.m12,
                right: AppMargin.m12,
                bottom: AppMargin.m8),
            child: Container(
              child: Text(comment.data,
                  style: Theme.of(context)
                      .textTheme
                      .bodyText2!
                      .copyWith(fontSize: FontSize.s15)),
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.width / 20,
          ),
          Padding(
            padding: const EdgeInsets.only(right: AppMargin.m10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Column(
                  children: [
                    Text("@" + comment.sign,
                        style: Theme.of(context)
                            .textTheme
                            .bodyText2!
                            .copyWith(fontSize: FontSize.s14)),
                    Text(
                        comment.date.substring(8, 10) +
                            '-' +
                            comment.date.substring(5, 7) +
                            '-' +
                            comment.date.substring(2, 4) +
                            ' ' +
                            comment.date.substring(11, 16),
                        style: Theme.of(context)
                            .textTheme
                            .bodyText2!
                            .copyWith(fontSize: FontSize.s12)),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.width / 20,
          ),
        ],
      ),
    );
  }
}
