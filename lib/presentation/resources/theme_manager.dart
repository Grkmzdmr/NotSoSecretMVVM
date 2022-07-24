import 'package:not_so_secret/presentation/resources/color_manager.dart';
import 'package:not_so_secret/presentation/resources/font_manager.dart';
import 'package:not_so_secret/presentation/resources/styles_manager.dart';
import 'package:not_so_secret/presentation/resources/values_manager.dart';
import 'package:flutter/material.dart';

ThemeData getApplicationTheme() {
  return ThemeData(
    

      primaryColor: ColorManager.primary,
      primaryColorLight: ColorManager.primaryOpacity70,
      primaryColorDark: ColorManager.darkPrimary,
      disabledColor: ColorManager.grey1, // disabled button
      accentColor: ColorManager.grey,
      splashColor: ColorManager.primaryOpacity70,
      cardTheme: CardTheme(
          color: ColorManager.white,
          shadowColor: ColorManager.grey,
          elevation: AppSize.s4),
      appBarTheme: AppBarTheme(
        centerTitle: true,
        color: ColorManager.appbar,
        elevation: AppSize.s4,
        shadowColor: ColorManager.primaryOpacity70,
        titleTextStyle:
            getBoldStyle(color: ColorManager.primary, fontSize: FontSize.s20),
      ),
      
      buttonTheme: ButtonThemeData(
        shape: StadiumBorder(),
        disabledColor: ColorManager.grey1,
        buttonColor: ColorManager.primary,
        splashColor: ColorManager.primaryOpacity70,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
              textStyle: getRegularStyle(color: ColorManager.white),
              primary: ColorManager.primary,
              shape: RoundedRectangleBorder())),
      textTheme: TextTheme(
          headline1: getSemiBoldStyle(
              color: ColorManager.primary, fontSize: FontSize.s18),
          headline2: getRegularStyle(
              color: ColorManager.white, fontSize: FontSize.s18),
          headline3: getRegularStyle(
              color: ColorManager.darkGrey, fontSize: FontSize.s15),
          headline4: getSemiBoldStyle(
              color: ColorManager.primary, fontSize: FontSize.s15),
          subtitle1: getMediumStyle(
              color: ColorManager.darkGrey, fontSize: FontSize.s16),
          caption: getRegularStyle(color: ColorManager.grey1),
          bodyText1: getRegularStyle(color: ColorManager.grey),
          bodyText2: getRegularStyle(color: ColorManager.black,fontSize: FontSize.s14)),
      inputDecorationTheme: InputDecorationTheme(
          contentPadding: EdgeInsets.all(AppPadding.p8),
          hintStyle: getRegularStyle(color: ColorManager.grey1),
          labelStyle: getMediumStyle(color: ColorManager.darkGrey),
          errorStyle: getRegularStyle(color: ColorManager.error),
          enabledBorder: OutlineInputBorder(
              borderSide:
                  BorderSide(color: ColorManager.grey, width: AppSize.s1_5),
              borderRadius: BorderRadius.all(Radius.circular(AppSize.s8))),
          focusedBorder: OutlineInputBorder(
              borderSide:
                  BorderSide(color: ColorManager.primary, width: AppSize.s1_5),
              borderRadius: BorderRadius.all(Radius.circular(AppSize.s8))),
          errorBorder: OutlineInputBorder(
              borderSide:
                  BorderSide(color: ColorManager.error, width: AppSize.s1_5),
              borderRadius: BorderRadius.all(Radius.circular(AppSize.s8))),
          focusedErrorBorder: OutlineInputBorder(
              borderSide:
                  BorderSide(color: ColorManager.primary, width: AppSize.s1_5),
              borderRadius: BorderRadius.all(Radius.circular(AppSize.s8)))));
}
