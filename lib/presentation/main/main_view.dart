import 'package:flutter/material.dart';
import 'package:not_so_secret/presentation/main/home/home_page.dart';
import 'package:not_so_secret/presentation/main/notifications_page.dart';

import 'package:not_so_secret/presentation/main/profile/profile_page.dart';
import 'package:not_so_secret/presentation/resources/color_manager.dart';
import 'package:not_so_secret/presentation/resources/routes_manager.dart';
import 'package:not_so_secret/presentation/resources/strings_manager.dart';
import 'package:not_so_secret/presentation/resources/values_manager.dart';
import 'package:easy_localization/easy_localization.dart';

class MainView extends StatefulWidget {
  const MainView({Key? key}) : super(key: key);

  @override
  _MainViewState createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  List<Widget> pages = [
    HomePage(),
    //NotificationPage(),
    PersonPage()
  ];
  List<String> titles = [
    AppStrings.home.tr(),

    //AppStrings.notification,
    AppStrings.person.tr()
  ];
  var _title = AppStrings.home.tr();
  var _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.add_box),
          onPressed: () {
            Navigator.pushNamed(context, Routes.addSecretRoute);
          },
        ),
        title: Text(
          _title,
          style: Theme.of(context).textTheme.headline2,
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {
              Navigator.pushNamed(context, Routes.settingsRoute);
            },
          )
        ],
      ),
      body: pages[_currentIndex],
      bottomNavigationBar: Container(
        decoration: BoxDecoration(boxShadow: [
          BoxShadow(color: ColorManager.black, spreadRadius: AppSize.s1)
        ]),
        child: BottomNavigationBar(
          selectedItemColor: ColorManager.primary,
          unselectedItemColor: ColorManager.grey,
          currentIndex: _currentIndex,
          onTap: onTap,
          items: [
            BottomNavigationBarItem(
                icon: Icon(Icons.home), label: AppStrings.home.tr()),
            //BottomNavigationBarItem(icon: Icon(Icons.notifications),label: AppStrings.notification),
            BottomNavigationBarItem(
                icon: Icon(Icons.person), label: AppStrings.person.tr()),
          ],
        ),
      ),
    );
  }

  onTap(int index) {
    setState(() {
      _currentIndex = index;
      _title = titles[index];
    });
  }
}
