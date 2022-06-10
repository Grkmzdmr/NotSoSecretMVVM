import 'dart:async';

import 'package:not_so_secret/domain/model/model.dart';
import 'package:not_so_secret/presentation/base/baseviewmodel.dart';
import 'package:not_so_secret/presentation/resources/assets_manager.dart';
import 'package:not_so_secret/presentation/resources/strings_manager.dart';
import 'package:easy_localization/easy_localization.dart';

class OnBoardingViewModel extends BaseViewModel
    with OnBoardingViewModelInputs, OnBoardingViewModelOutputs {
  //stream controllers
  final StreamController _streamController =
      StreamController<SlideViewObject>();

  late final List<SliderObject> _list;
  int _currentIndex = 0;

  //inputs
  @override
  void dispose() {
    _streamController.close();
  }

  @override
  void start() {
    _list = _getSliderData();
    //send this slider data to our view
    _postDataToView();
  }

  @override
  int goNext() {
    int nextIndex = _currentIndex++;
    if (nextIndex >= _list.length) {
      _currentIndex = 0;
    }
    return _currentIndex;
  }

  @override
  int goPrevious() {
    int previousIndex = _currentIndex--;
    if (previousIndex == -1) {
      _currentIndex = _list.length - 1;
    }

    return _currentIndex;
  }

  @override
  void onPageChanged(int index) {
    _currentIndex = index;
    _postDataToView();
  }

  @override
  Sink get inputSliderViewObject => _streamController.sink;

  @override
  // TODO: implement outputSliderViewObject
  Stream<SlideViewObject> get outputSliderViewObject =>
      _streamController.stream.map((SlideViewObject) => SlideViewObject);

  //private functions
  List<SliderObject> _getSliderData() => [
        SliderObject(AppStrings.onBoardingTitle1.tr(), AppStrings.onBoardingContent1.tr(),
            ImageAssets.onBoardingLogo1),
        SliderObject(AppStrings.onBoardingTitle2.tr(), AppStrings.onBoardingContent2.tr(),
            ImageAssets.onBoardingLogo2),
        SliderObject(AppStrings.onBoardingTitle3.tr(), AppStrings.onBoardingContent3.tr(),
            ImageAssets.onBoardingLogo3)
      ];

  _postDataToView() {
    inputSliderViewObject.add(
        SlideViewObject(_list[_currentIndex], _list.length, _currentIndex));
  }
}

// inputs mean the orders that our view model will recieve from our view
abstract class OnBoardingViewModelInputs {
  void goNext(); //when user clicks on right arrow or swipe
  void goPrevious(); // when user clicks on left arrow or swipe right
  void onPageChanged(int index);

  Sink
      get inputSliderViewObject; // this is the way to add data to the stream...
}

// outputs mean data or results that will be sent from our view model to our view
abstract class OnBoardingViewModelOutputs {
  Stream<SlideViewObject> get outputSliderViewObject;
}

class SlideViewObject {
  SliderObject sliderObject;
  int numOfSlides;
  int currentIndex;

  SlideViewObject(this.sliderObject, this.numOfSlides, this.currentIndex);
}
