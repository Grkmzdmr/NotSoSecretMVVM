import 'package:not_so_secret/app/di.dart';
import 'package:not_so_secret/presentation/add_secret/add_secret.dart';
import 'package:not_so_secret/presentation/comment/comment_page.dart';
import 'package:not_so_secret/presentation/comment/comment_page.dart';
import 'package:not_so_secret/presentation/login/login.dart';
import 'package:not_so_secret/presentation/main/home/contactus_page.dart';

import 'package:not_so_secret/presentation/main/home/settings_page.dart';
import 'package:not_so_secret/presentation/main/main_view.dart';
import 'package:not_so_secret/presentation/onboarding/onboarding.dart';
import 'package:not_so_secret/presentation/register/register.dart';
import 'package:not_so_secret/presentation/resources/strings_manager.dart';
import 'package:not_so_secret/presentation/splash/splash.dart';
import 'package:not_so_secret/presentation/store_details/store_details.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

class Routes {
  static const String splashRoute = "/";
  static const String onBoardingRoute = "/onBoarding";
  static const String loginRoute = "/login";
  static const String registerRoute = "/register";
  static const String mainRoute = "/main";
  static const String storeDetailsRoute = "/storeDetails";
  static const String settingsRoute = "/settings";
  static const String addSecretRoute = "/addSecret";
  static const String commentRoute = "/comment";
  static const String aboutusRoute = "/aboutUs";
}

class RouteGenerator {
  static Route<dynamic> getRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case Routes.splashRoute:
        return MaterialPageRoute(builder: (_) => SplashView());
      case Routes.loginRoute:
        initLoginModule();
        initProfileModule();
        return MaterialPageRoute(builder: (_) => LoginView());
      case Routes.onBoardingRoute:
        return MaterialPageRoute(builder: (_) => OnBoardingView());
      case Routes.registerRoute:
        initRegisterModule();

        return MaterialPageRoute(builder: (_) => RegisterView());
      case Routes.storeDetailsRoute:
        return MaterialPageRoute(builder: (_) => StoreDetails());
      case Routes.mainRoute:
        initHomeModule();
        initProfileModule();
        initCommentModule();
        return MaterialPageRoute(builder: (_) => MainView());
      case Routes.settingsRoute:
        return MaterialPageRoute(builder: (_) => SettingsPage());
      case Routes.addSecretRoute:
        initSendSecretModule();

        return MaterialPageRoute(builder: (_) => AddSecret());
       case Routes.aboutusRoute:
        

        return MaterialPageRoute(builder: (_) => ContactUs());  
      case Routes.commentRoute:
        initCommentModule();
        return MaterialPageRoute(builder: (_) => CommentTest());
      default:
        return unDefinedRoute();
    }
  }

  static Route<dynamic> unDefinedRoute() {
    return MaterialPageRoute(
        builder: (_) => Scaffold(
              appBar: AppBar(
                title: Text(AppStrings.noRouteFound).tr(),
              ),
              body: Center(
                child: Text(AppStrings.noRouteFound).tr(),
              ),
            ));
  }
}
