import 'dart:async';

import 'package:animate_do/animate_do.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:lottie/lottie.dart';
import 'package:not_so_secret/app/app_prefs.dart';
import 'package:not_so_secret/app/di.dart';
import 'package:not_so_secret/presentation/resources/assets_manager.dart';
import 'package:not_so_secret/presentation/resources/color_manager.dart';
import 'package:not_so_secret/presentation/resources/font_manager.dart';
import 'package:not_so_secret/presentation/resources/routes_manager.dart';
import 'package:not_so_secret/presentation/resources/values_manager.dart';
import 'package:flutter/material.dart';

class SplashView extends StatefulWidget {
  const SplashView({Key? key}) : super(key: key);

  @override
  _SplashViewState createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  Timer? _timer;
  AppPreferences _appPreferences = instance<AppPreferences>();

  _startDelay() {
    _timer = Timer(Duration(seconds: 4, milliseconds: 8), _goNext);
  }

  _goNext() async {
    

    _appPreferences.isUserLoggedIn().then((isUserLoggedIn) => {
          if (isUserLoggedIn)
            {
              //navigate to main screen
              Navigator.pushReplacementNamed(context, Routes.mainRoute)
            }
          else
            {
              _appPreferences
                  .isOnBoardingScreenViewed()
                  .then((isOnBoardingScreenViewed) => {
                        if (isOnBoardingScreenViewed)
                          {
                            Navigator.pushReplacementNamed(
                                context, Routes.loginRoute)
                          }
                        else
                          {
                            Navigator.pushReplacementNamed(
                                context, Routes.onBoardingRoute)
                          }
                      })
            }
        });
  }

  @override
  void initState() {
    super.initState();
    _startDelay();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: ColorManager.black,
        body: ElasticIn(
          delay: Duration(milliseconds: 5),
          duration: Duration(seconds: 3, milliseconds: 5),
          child: Center(
            child: Column(children: [
              Spacer(flex: 3),
              Expanded(
                flex: 3,
                child: Image(
                  image: AssetImage(ImageAssets.splashLogo),
                  width: size.width / 2.07,
                  height: size.width / 3.7,
                ),
              ),
              Spacer(),
              Expanded(
                  flex: 3,
                  child: Text(
                    "Snow Sparrow",
                    style: Theme.of(context).textTheme.headline1?.copyWith(
                        color: ColorManager.white,
                        fontSize: FontSize.s20,
                        wordSpacing: AppSize.s6,
                        letterSpacing: AppSize.s1),
                  )),
              Spacer(
                flex: 2,
              ),
            ]),
          ),
        ));
  }
}
