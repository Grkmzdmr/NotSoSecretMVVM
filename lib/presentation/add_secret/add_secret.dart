import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

import 'package:not_so_secret/app/di.dart';
import 'package:not_so_secret/presentation/add_secret/add_secret_viewmodel.dart';
import 'package:not_so_secret/presentation/common/state_renderer/state_render_impl.dart';
import 'package:not_so_secret/presentation/resources/color_manager.dart';
import 'package:not_so_secret/presentation/resources/routes_manager.dart';
import 'package:not_so_secret/presentation/resources/strings_manager.dart';
import 'package:not_so_secret/presentation/resources/values_manager.dart';
import 'package:easy_localization/easy_localization.dart';

class AddSecret extends StatefulWidget {
  const AddSecret({Key? key}) : super(key: key);

  @override
  State<AddSecret> createState() => _AddSecretState();
}

class _AddSecretState extends State<AddSecret> {
  AddSecretViewModel _viewModel = instance<AddSecretViewModel>();
  TextEditingController _titleController = TextEditingController();
  TextEditingController _textController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  _bind() {
    _viewModel.start();
    _textController.addListener(() {
      _viewModel.setSecretText(_textController.text);
    });
    _titleController.addListener(() {
      _viewModel.setSecretTitle(_titleController.text);
    });
    _viewModel.setSecretLanguage("tr");
    _viewModel.isSecretSharedSuccessfullyStreamController.stream
        .listen((isPostShared) {
      SchedulerBinding.instance.addPostFrameCallback((_) {
        Navigator.of(context).pushReplacementNamed(Routes.mainRoute);
        resetHomeModule();
        initHomeModule();
        initProfileModule();
      });
    });
  }

  @override
  void initState() {
    _bind();
    super.initState();
  }

  @override
  void dispose() {
    _viewModel.dispose();
    _textController.dispose();
    _titleController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: ColorManager.white,
        body: StreamBuilder<FlowState>(
          stream: _viewModel.outputState,
          builder: (context, snapshot) {
            return snapshot.data?.getScreenWidget(context, getContentWidget(),
                    () {
                  _viewModel.sendSecret();
                }) ??
                getContentWidget();
          },
        ));
  }

  Widget getContentWidget() {
    return Container(
      padding: EdgeInsets.only(top: AppPadding.p12),
      color: ColorManager.white,
      child: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: AppMargin.m10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text(
                        AppStrings.cancel.tr(),
                        style: Theme.of(context).textTheme.headline1,
                      ),
                    ),
                    StreamBuilder<bool>(
                        stream: _viewModel.outputIsAllInputsValid,
                        builder: (context, snapshot) {
                          return TextButton(
                            onPressed: () {
                              _viewModel.sendSecret();
                            },
                            child: Text(
                              AppStrings.share.tr(),
                              style: Theme.of(context).textTheme.headline1,
                            ),
                          );
                        })
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(AppMargin.m10),
                child: StreamBuilder<bool>(
                    stream: _viewModel.outputIsTitleValid,
                    builder: (context, snapshot) {
                      return TextFormField(
                        controller: _titleController,
                        autofocus: true,
                        maxLines: 1,
                        maxLength: 120,
                        decoration: InputDecoration(
                            hintStyle: Theme.of(context).textTheme.bodyText1,
                            hintText: AppStrings.title.tr(),
                            border: OutlineInputBorder()),
                      );
                    }),
              ),
              Padding(
                padding: const EdgeInsets.all(AppMargin.m10),
                child: StreamBuilder<bool>(
                    stream: _viewModel.outputIsTextValid,
                    builder: (context, snapshot) {
                      return TextFormField(
                        controller: _textController,
                        maxLength: 2000,
                        autofocus: true,
                        maxLines: 8,
                        decoration: InputDecoration(
                            hintStyle: Theme.of(context).textTheme.bodyText1,
                            hintText: AppStrings.text.tr(),
                            border: OutlineInputBorder()),
                      );
                    }),
              )
            ],
          ),
        ),
      ),
    );
  }
}
