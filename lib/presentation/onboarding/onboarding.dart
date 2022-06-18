import 'package:not_so_secret/app/app_prefs.dart';
import 'package:not_so_secret/app/di.dart';
import 'package:not_so_secret/domain/model/model.dart';
import 'package:not_so_secret/presentation/onboarding/onboarding_viewmodel.dart';
import 'package:not_so_secret/presentation/resources/assets_manager.dart';
import 'package:not_so_secret/presentation/resources/color_manager.dart';
import 'package:not_so_secret/presentation/resources/routes_manager.dart';
import 'package:not_so_secret/presentation/resources/strings_manager.dart';
import 'package:not_so_secret/presentation/resources/values_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:easy_localization/easy_localization.dart';

class OnBoardingView extends StatefulWidget {
  const OnBoardingView({Key? key}) : super(key: key);

  @override
  _OnBoardingViewState createState() => _OnBoardingViewState();
}

class _OnBoardingViewState extends State<OnBoardingView> {
  PageController _pageController = PageController(initialPage: 0);
  OnBoardingViewModel _viewModel = OnBoardingViewModel();
  AppPreferences _appPreferences = instance<AppPreferences>();

  _bind() {
    _appPreferences.setOnBoardingScreenViewed();
    _viewModel.start();
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
    return StreamBuilder<SlideViewObject>(
      stream: _viewModel.outputSliderViewObject,
      builder: (context, snapshot) {
        return _getContentWidget(snapshot.data);
      },
    );
  }

  Widget _getContentWidget(SlideViewObject? slideViewObject) {
    if (slideViewObject == null) {
      return Container();
    } else {
      return Scaffold(
        backgroundColor: ColorManager.white,
        appBar: AppBar(
          backgroundColor: ColorManager.white,
          elevation: AppSize.s0,
          systemOverlayStyle: SystemUiOverlayStyle(
              statusBarColor: ColorManager.white,
              statusBarBrightness: Brightness.dark,
              statusBarIconBrightness: Brightness.dark),
        ),
        body: PageView.builder(
          controller: _pageController,
          itemCount: slideViewObject.numOfSlides,
          onPageChanged: (index) async {
            Duration(milliseconds: DurationConstant.d500);
            _viewModel.onPageChanged(index);
          },
          itemBuilder: (context, index) {
            return OnBoardingPage(slideViewObject.sliderObject);
          },
        ),
        bottomSheet: Container(
          color: ColorManager.white,
          height: AppSize.s100,
          child: Column(
            children: [
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                    onPressed: () {
                      Navigator.pushReplacementNamed(
                          context, Routes.loginRoute);
                    },
                    child: Text(
                      AppStrings.skip.tr(),
                      style: Theme.of(context).textTheme.subtitle2,
                      textAlign: TextAlign.end,
                    )),
              ),
              _getBottomSheetWidget(slideViewObject)
            ],
          ),
        ),
      );
    }
  }

  Widget _getBottomSheetWidget(SlideViewObject slideViewObject) {
    return Container(
      color: ColorManager.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: EdgeInsets.all(AppPadding.p16),
            child: GestureDetector(
              child: SizedBox(
                height: AppSize.s20,
                width: AppSize.s20,
                child: Icon(
                  Icons.arrow_back,
                  size: AppSize.s30,
                  color: ColorManager.white,
                ),
              ),
              onTap: () {
                //_pageController.animateToPage(_viewModel.goPrevious(),
                //  duration: Duration(milliseconds: DurationConstant.d500),
                //curve: Curves.bounceInOut);
              },
            ),
          ),
          Row(
            children: [
              for (int i = 0; i < slideViewObject.numOfSlides; i++)
                Padding(
                  padding: EdgeInsets.all(AppPadding.p8),
                  child: _getProperCircle(i, slideViewObject.currentIndex),
                )
            ],
          ),
          Padding(
            padding: EdgeInsets.all(AppPadding.p16),
            child: GestureDetector(
              child: SizedBox(
                height: AppSize.s20,
                width: AppSize.s20,
                child: Icon(
                  Icons.arrow_forward,
                  size: AppSize.s30,
                  color: ColorManager.white,
                ),
              ),
              onTap: () {
                //_pageController.animateToPage(_viewModel.goNext(),
                //duration: Duration(milliseconds: DurationConstant.d500),
                //curve: Curves.bounceInOut);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _getProperCircle(int index, int _currentIndex) {
    if (index == _currentIndex) {
      return Icon(
        Icons.brightness_1_outlined,
        size: AppSize.s18,
      );
    } else {
      return Icon(
        Icons.brightness_1,
        size: AppSize.s18,
        color: ColorManager.darkGrey,
      );
    }
  }
}

class OnBoardingPage extends StatelessWidget {
  SliderObject _sliderObject;
  OnBoardingPage(this._sliderObject, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Expanded(
          flex: 2,
          child: Padding(
            padding: const EdgeInsets.all(AppPadding.p8),
            child: Text(_sliderObject.title.tr(),
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headline1),
          ),
        ),
        Expanded(
          flex: 6,
          child: Padding(
            padding: const EdgeInsets.all(AppPadding.p8),
            child: Text(_sliderObject.subTitle.tr(),
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.subtitle1),
          ),
        ),
        Expanded(
          flex: 15,
          child: SvgPicture.asset(
            _sliderObject.image,
            height: MediaQuery.of(context).size.height / 2.5,
            width: MediaQuery.of(context).size.width / 1 / 15,
          ),
        ),
        Spacer(
          flex: 7,
        ),
      ],
    );
  }
}
