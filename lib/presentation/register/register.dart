import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:lottie/lottie.dart';
import 'package:not_so_secret/app/app_prefs.dart';
import 'package:not_so_secret/app/di.dart';
import 'package:not_so_secret/presentation/common/state_renderer/state_render_impl.dart';
import 'package:not_so_secret/presentation/register/register_viewmodel.dart';
import 'package:not_so_secret/presentation/resources/assets_manager.dart';
import 'package:not_so_secret/presentation/resources/color_manager.dart';
import 'package:not_so_secret/presentation/resources/routes_manager.dart';
import 'package:not_so_secret/presentation/resources/strings_manager.dart';
import 'package:not_so_secret/presentation/resources/values_manager.dart';
import 'package:easy_localization/easy_localization.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({Key? key}) : super(key: key);

  @override
  _RegisterViewState createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  RegisterViewModel _viewModel = instance<RegisterViewModel>();
  final _formKey = GlobalKey<FormState>();
  TextEditingController _userNameTextEditingController =
      TextEditingController();
  TextEditingController _passwordTextEditingController =
      TextEditingController();
  AppPreferences _appPreferences = instance<AppPreferences>();

  @override
  void initState() {
    _bind();
    super.initState();
  }

  _bind() {
    _viewModel.start();
    _userNameTextEditingController.addListener(() {
      _viewModel.setUserName(_userNameTextEditingController.text);
    });
    _passwordTextEditingController.addListener(() {
      _viewModel.setPassword(_passwordTextEditingController.text);
    });
    _viewModel.isUserLoggedInSuccessfullyStreamController.stream
        .listen((token) {
      SchedulerBinding.instance?.addPostFrameCallback((_) {
        
        resetAllModule();
        
        Navigator.of(context).pushReplacementNamed(Routes.loginRoute);
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
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
          backgroundColor: ColorManager.white,
          body: StreamBuilder<FlowState>(
            stream: _viewModel.outputState,
            builder: (context, snapshot) {
              return snapshot.data?.getScreenWidget(context, _getContentWidget(),
                      () {
                    _viewModel.register();
                  }) ??
                  _getContentWidget();
            },
          )),
    );
  }

  Widget _getContentWidget() {
    return Container(
      padding: EdgeInsets.only(top: AppPadding.p100),
      color: ColorManager.white,
      child: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              SizedBox(
                height: AppSize.s200,
                width: AppSize.s200,
                child: Lottie.asset(JsonAssets.register), //json image
              ),
              /*Image(
                image: AssetImage(ImageAssets.splashLogo),
                height: AppSize.s140,
                width: AppSize.s140,
              ),*/
              SizedBox(
                height: AppSize.s40,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      AppStrings.registerWelcome.tr(),
                      style: Theme.of(context).textTheme.headline1,
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: AppSize.s12,
              ),
              Text(AppStrings.registerSubtext.tr()),
              SizedBox(
                height: AppSize.s60,
              ),
              Padding(
                padding: EdgeInsets.only(
                    left: AppPadding.p28, right: AppPadding.p28),
                child: StreamBuilder<String?>(
                  stream: _viewModel.outputErrorUserName,
                  builder: (context, snapshot) {
                    return TextFormField(
                        controller: _userNameTextEditingController,
                        keyboardType: TextInputType.name,
                        decoration: InputDecoration(
                          hintText: AppStrings.inputUsername.tr(),
                          labelText: AppStrings.inputUsername.tr(),
                          errorText: snapshot.data,
                        ));
                  },
                ),
              ),
              SizedBox(
                height: AppSize.s28,
              ),
              Padding(
                padding: EdgeInsets.only(
                    left: AppPadding.p28, right: AppPadding.p28),
                child: StreamBuilder<String?>(
                  stream: _viewModel.outputErrorPassword,
                  builder: (context, snapshot) {
                    return TextFormField(
                      controller: _passwordTextEditingController,
                      keyboardType: TextInputType.visiblePassword,
                      obscureText: true,
                      decoration: InputDecoration(
                          hintText: AppStrings.inputPassword.tr(),
                          labelText: AppStrings.inputPassword.tr(),
                          errorText: snapshot.data),
                    );
                  },
                ),
              ),
              SizedBox(
                height: AppSize.s60,
              ),
              Padding(
                  padding: EdgeInsets.only(
                      left: AppPadding.p28, right: AppPadding.p28),
                  child: StreamBuilder<bool>(
                    stream: _viewModel.outputIsAllValid,
                    builder: (context, snapshot) {
                      return SizedBox(
                        width: double.infinity,
                        height: AppSize.s40,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              shape: new RoundedRectangleBorder(
                                  borderRadius:
                                      new BorderRadius.circular(AppSize.s12))),
                          onPressed: (snapshot.data ?? false)
                              ? () {
                                  _viewModel.register();
                                }
                              : null,
                          child: Text(
                            AppStrings.registerButton.tr(),
                            style: TextStyle(
                                color: ColorManager.white,
                                fontSize: AppSize.s16),
                          ),
                        ),
                      );
                    },
                  )),
              Padding(
                padding: EdgeInsets.only(
                    top: AppPadding.p8,
                    left: AppPadding.p28,
                    right: AppPadding.p28),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton(
                        onPressed: () {
                          //.pop çalışmadı daha sonra dön!!!
                          Navigator.of(context)
                              .popAndPushNamed(Routes.loginRoute);
                        },
                        child: Text(
                          AppStrings.haveAccount.tr(),
                          style: Theme.of(context).textTheme.subtitle2,
                          textAlign: TextAlign.end,
                        )),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
