import 'package:flutter/scheduler.dart';
import 'package:lottie/lottie.dart';
import 'package:not_so_secret/app/app_prefs.dart';
import 'package:not_so_secret/app/di.dart';
import 'package:not_so_secret/presentation/common/state_renderer/state_render_impl.dart';
import 'package:not_so_secret/presentation/login/login_viewmodel.dart';
import 'package:not_so_secret/presentation/main/profile/profile_viewmodel.dart';
import 'package:not_so_secret/presentation/resources/assets_manager.dart';
import 'package:not_so_secret/presentation/resources/color_manager.dart';
import 'package:not_so_secret/presentation/resources/routes_manager.dart';
import 'package:not_so_secret/presentation/resources/strings_manager.dart';
import 'package:not_so_secret/presentation/resources/values_manager.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  LoginViewModel _viewModel =
      instance<LoginViewModel>(); //todo pass here login usecase
  AppPreferences _appPreferences = instance<AppPreferences>();
  

  TextEditingController _userNameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  _bind() {
    _viewModel.start();
    _userNameController
        .addListener(() => _viewModel.setUserName(_userNameController.text));
    _passwordController
        .addListener(() => _viewModel.setPassword(_passwordController.text));

    _viewModel.isUserLoggedInSuccessfullyStreamController.stream
        .listen((token) {
      SchedulerBinding.instance?.addPostFrameCallback((_) {
        _appPreferences.setIsUserLoggedIn();
        _appPreferences.setToken(token);

        resetAllModule();
        Navigator.of(context).pushReplacementNamed(Routes.mainRoute);
      });
      _viewModel.isUserNameSuccessfullyTaken.stream.listen((username) {
        SchedulerBinding.instance?.addPostFrameCallback((_) {
          _appPreferences.setUsername(username);
        });
      });
      _viewModel.isUserIdSuccessfullyTaken.stream.listen((id) {
        SchedulerBinding.instance?.addPostFrameCallback((_) {
          _appPreferences.setUserId(id);
          
        });
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
                  _viewModel.login();
                }) ??
                _getContentWidget();
          },
        ),
      ),
    );
  }

  Widget _getContentWidget() {
    return Container(
      
      color: ColorManager.white,
      child: Container(
        height: MediaQuery.of(context).size.height,
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Spacer(flex: 5,),
              Expanded(
                flex: 15,
                child: SizedBox(
                  height: AppSize.s200,
                  width: AppSize.s200,
                  child: Image(image: AssetImage(ImageAssets.splashLogo),) ,
                  //Lottie.asset(JsonAssets.login), //json image
                ),
              ),
              /*Image(
                image: AssetImage(ImageAssets.splashLogo),
                height: AppSize.s140,
                width: AppSize.s140,
              ),*/
              Spacer(flex: 2,),
              Expanded(
                flex: 5,
                child: Text(
                  AppStrings.loginWelcome.tr(),
                  style: Theme.of(context).textTheme.headline1,
                ),
              ),
              
              Expanded(
                flex: 5,
                child: Text(AppStrings.loginText.tr())),
              
              Expanded(
                flex: 9,
                child: Padding(
                  padding: EdgeInsets.only(
                      left: AppPadding.p28, right: AppPadding.p28),
                  child: StreamBuilder<bool>(
                    stream: _viewModel.outputIsUserNameValid,
                    builder: (context, snapshot) {
                      return TextFormField(
                        controller: _userNameController,
                        keyboardType: TextInputType.name,
                        decoration: InputDecoration(
                            hintText: AppStrings.inputUsername.tr(),
                            labelText: AppStrings.inputUsername.tr(),
                            errorText: (snapshot.data ?? true)
                                ? null
                                : AppStrings.usernamError.tr()),
                      );
                    },
                  ),
                ),
              ),
              Spacer(),
              
              Expanded(
                flex: 9,
                child: Padding(
                  padding: EdgeInsets.only(
                      left: AppPadding.p28, right: AppPadding.p28),
                  child: StreamBuilder<bool>(
                    stream: _viewModel.outputIsPasswordValid,
                    builder: (context, snapshot) {
                      return TextFormField(
                        controller: _passwordController,
                        keyboardType: TextInputType.visiblePassword,
                        obscureText: true,
                        decoration: InputDecoration(
                            hintText: AppStrings.inputPassword.tr(),
                            labelText: AppStrings.inputPassword.tr(),
                            errorText: (snapshot.data ?? true)
                                ? null
                                : AppStrings.passwordError.tr()),
                      );
                    },
                  ),
                ),
              ),
              Spacer(),
              
              Expanded(
                flex: 4,
                child: Padding(
                    padding: EdgeInsets.only(
                        left: AppPadding.p28, right: AppPadding.p28),
                    child: StreamBuilder<bool>(
                      stream: _viewModel.outputIsAllInputsValid,
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
                                    _viewModel.login();
                                  }
                                : null,
                            child: Text(
                              AppStrings.loginButton.tr(),
                              style: TextStyle(
                                  color: ColorManager.white,
                                  fontSize: AppSize.s16),
                            ),
                          ),
                        );
                      },
                    )),
              ),
              Expanded(
                flex : 10,
                child: Padding(
                  padding: EdgeInsets.only(
                      top: AppPadding.p8,
                      left: AppPadding.p28,
                      right: AppPadding.p28),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextButton(
                          onPressed: () {
                            Navigator.pushReplacementNamed(
                                context, Routes.registerRoute);
                          },
                          child: Text(
                            AppStrings.registerText.tr(),
                            style: Theme.of(context).textTheme.subtitle2,
                            textAlign: TextAlign.end,
                          ))
                    ],
                  ),
                ),
              ),
              Spacer()
            ],
          ),
        ),
      ),
    );
  }
}
